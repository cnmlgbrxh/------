//
//  QQShoppingOrderDetailVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingOrderDetailVC.h"
#import "QQConfirmOrderHeadView.h"
#import "QQShoppingConfirmOrderCell.h"
#import "QQShoppingOrderDetailGoolsPriceCell.h"
#import "QQShoppingOrderDetailModel.h"
#import "QQShoppingAddressListModel.h"
#import "QQShoppingCarModel.h"
#import "QQAlipayManagerTool.h"
#import "QQShoppingOrderViewController.h"
#import "QQShoppingOrderViewController.h"

@interface QQShoppingOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)QQShoppingOrderDetailModel *detailModel;
@property (nonatomic,strong)UIButton *nextBtn;
@property (nonatomic,strong)UILabel *explainLabel;
@end

@implementation QQShoppingOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)getDetailData {
    WS(wSelf);
    self.detailModel = [[QQShoppingOrderDetailModel alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&gid=%@",shopping_orderDetailURL,[UserManager shareManager].userName,self.model.gid];
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        wSelf.detailModel = [QQShoppingOrderDetailModel yy_modelWithJSON:response];
        [wSelf.tableView reloadData];
        [wSelf setNextBtnTitle];
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)setNextBtnTitle {
    if ([self.detailModel.status isEqualToString:@"已收货"] || [self.detailModel.status isEqualToString:@"已取消"]) {
        self.explainLabel.hidden = YES;
        [self.nextBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    }else if ([self.detailModel.status isEqualToString:@"待付款"]) {
        self.explainLabel.hidden = YES;
        [self.nextBtn setTitle:@"立即付款" forState:UIControlStateNormal];
    }else if ([self.detailModel.status isEqualToString:@"待收货"]) {
        self.explainLabel.hidden = YES;
        [self.nextBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    }else{
        [self setNextBtnTitle:@"已付款 等待发货"];
    }
}

- (void)setNextBtnTitle:(NSString *)titleStr {
    self.explainLabel.text = titleStr;
    self.nextBtn.hidden = YES;
    self.nextBtn.userInteractionEnabled = NO;
}

- (void)nextBtnClick {
    WS(wSelf);
    NSString *allPrice = [NSString stringWithFormat:@"￥%.2f",[self.detailModel.num integerValue]*[self.detailModel.price floatValue]+[self.detailModel.freight integerValue]];
    if ([self.detailModel.status isEqualToString:@"待付款"] && [self.detailModel.payment isEqualToString:@"移动支付宝"]) {
        NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&gid=%@",shopping_alipayURL,[UserManager shareManager].userName,self.model.gid];
        [[QQAlipayManagerTool sharedInstance]shoppingAlipayWithURLStr:urlStr productName:self.detailModel.pname Price:allPrice];
    }
    if ([self.detailModel.status isEqualToString:@"待付款"] && [self.detailModel.payment isEqualToString:@"微信支付"]) {
        NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&gid=%@",shopping_wechatPayURL,[UserManager shareManager].userName,self.model.gid];
        [[QQAlipayManagerTool sharedInstance]wechatPay:urlStr];
    }
    if ([self.nextBtn.titleLabel.text isEqualToString:@"删除订单"]) {
        [QQShoppingTools showAlertControllerWithTitle:@"" message:@"确认要删除该订单吗?" confirmTitle:@"删除" cancleTitle:@"再想想" vc:wSelf confirmBlock:^{
            [wSelf deleteDetailOrder];
        } cancleBlock:^{
        }];
    }
    if ([self.nextBtn.titleLabel.text isEqualToString:@"确认收货"]) {
        [QQShoppingTools showAlertControllerWithTitle:@"" message:@"亲、确定收货吗？" confirmTitle:@"确定" cancleTitle:@"再想想" vc:wSelf confirmBlock:^{
            [wSelf confimOrderRequest];
        } cancleBlock:^{
        }];
    }
}

- (void)confimOrderRequest {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&gid=%@",shopping_confimOrder,[UserManager shareManager].userName,self.model.gid];
    NSLog(@"%@",QQ_API_CON(urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        if ([response[@"stats"]isEqualToString:@"ok"]) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"交易已完成!"];
            NSArray *vcArr = wSelf.navigationController.viewControllers;
            for (id objc in vcArr) {
                if ([objc isKindOfClass:[QQShoppingOrderViewController class]]) {
                    QQShoppingOrderViewController *vc  = (QQShoppingOrderViewController *)objc;
                    vc.selectIndex = 4;
                }
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                [wSelf.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
        }
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)deleteDetailOrder {
    WS(wSelf);
    NSString *url = [NSString stringWithFormat:@"%@username=%@&gid=%@",shopping_deleteOrderURL,[UserManager shareManager].userName,self.model.gid];
    [HYBNetworking getWithUrl:QQ_API_CON(url) refreshCache:YES success:^(id response) {
        if ([response[@"stats"] isEqualToString:@"ok"]) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"订单删除成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (wSelf.shopping_deleteOrderBlock) {
//                    wSelf.shopping_deleteOrderBlock();
//                }
                [wSelf.navigationController popViewControllerAnimated:YES];
            });
        }
        NSLog(@"删除订单 ---- %@",response);
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        QQConfirmOrderHeadView *cell = [tableView dequeueReusableCellWithIdentifier:QQConfirmOrderHeadViewID];
        QQShoppingAddressListModel *model = [[QQShoppingAddressListModel alloc]init];
        model.caddr = self.detailModel.address;
        model.cname = self.detailModel.owner;
        model.cphone = self.detailModel.phone;
        cell.arrowBtn.hidden = YES;
        cell.model = model;
        cell.orderNumLabel.text = self.detailModel.ordno;
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.hiddenTapLabel = YES;
        return cell;
    }else if (indexPath.row == 0) {
        QQShoppingOrderDetailFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingOrderDetailFirstCellID];
        cell.statesStr = self.detailModel.status;
        cell.backgroundColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
    }else if (indexPath.row == 2) {
        QQShoppingConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingConfirmOrderCellID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bgView.backgroundColor = [UIColor whiteColor];
        cell.line.hidden = NO;
        QQShoppingCarModel *model = [[QQShoppingCarModel alloc]init];
        model.productPic = self.detailModel.pic;
        model.productPrice = self.detailModel.price;
        model.carNum = self.detailModel.num;
        model.product_dp = self.model.product_dp;
        model.productName = self.detailModel.pname;
        cell.model = model;
        return cell;
    }else{
        QQShoppingOrderDetailGoolsPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingOrderDetailGoolsPriceCellID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.model = self.detailModel;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 143;
    }else if (indexPath.row == 0) {
        return 57;
    }else if (indexPath.row == 2) {
        return 97;
    }
    
    if ([self.detailModel.status isEqualToString:@"待付款"] || [self.detailModel.status isEqualToString:@"已取消"] ) {
        return 220;
    }
    if ([self.detailModel.status isEqualToString:@"待发货"] ) {
        return 240;
    }
    return 260;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-57-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"QQConfirmOrderHeadView" bundle:nil] forCellReuseIdentifier:QQConfirmOrderHeadViewID];
        [_tableView registerNib:[UINib nibWithNibName:@"QQShoppingConfirmOrderCell" bundle:nil] forCellReuseIdentifier:QQShoppingConfirmOrderCellID];
        [_tableView registerClass:[QQShoppingOrderDetailFirstCell class] forCellReuseIdentifier:QQShoppingOrderDetailFirstCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"QQShoppingOrderDetailGoolsPriceCell" bundle:nil] forCellReuseIdentifier:QQShoppingOrderDetailGoolsPriceCellID];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H-57-64, SCREEN_W, 57)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 1)];
        line.backgroundColor = [Tools getUIColorFromString:@"efefef"];
        [_bgView addSubview:line];
        
        self.explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, SCREEN_W-30, 43)];
        self.explainLabel.textColor = [Tools getUIColorFromString:@"ed4044"];
        self.explainLabel.font = [UIFont systemFontOfSize:15];
        self.explainLabel.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:self.explainLabel];
        
        self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextBtn.backgroundColor =  [Tools getUIColorFromString:@"ed4044"];
        self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.nextBtn.layer.cornerRadius = 3;
        self.nextBtn.layer.masksToBounds = YES;
        self.nextBtn.frame = CGRectMake(SCREEN_W-120, 7, 105, 43);
        [self.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:self.nextBtn];
    }
    return _bgView;
}

- (void)createUI {
    self.title = @"订单详情";
    [self getDetailData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(back) name:APPAlipayNotification object:nil];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
