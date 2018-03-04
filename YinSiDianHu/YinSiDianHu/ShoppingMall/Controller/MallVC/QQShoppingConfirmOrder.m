//
//  QQShoppingConfirmOrder.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingConfirmOrder.h"
#import "QQConfirmOrderHeadView.h"
#import "QQShoppingConfirmOrderCell.h"
#import "QQShoppingConfirmStyleModel.h"
#import "QQShoppingConfirmModel.h"
#import "QQShoppingAddGoolsPlace.h"
#import "QQShoppingPostAndPayView.h"
#import "QQShoppingPlaceManagerVC.h"
#import "QQShoppingSendStyleModel.h"
#import "QQAlipayManagerTool.h"
#import "QQShoppingOrderViewController.h"
#import "QQShoppingConfirmAcountView.h"

@interface QQShoppingConfirmOrder ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *stylesArray;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)QQShoppingConfirmModel *model;
@property(nonatomic,strong)QQConfirmOrderHeadView *headView;
@property(nonatomic,strong)NSMutableArray *sendStyleArr;
@property(nonatomic,strong)NSString *allPrice;//价钱总和
@property(nonatomic,strong)NSString *sendStr;//配送方式
@property(nonatomic,strong)NSString *payStr;//支付方式
@property(nonatomic,assign)NSInteger allNum;//数量总额
@property(nonatomic,strong)NSString *allPid;//所有的产品id
@property(nonatomic,strong)NSString *cidStr;//所有的购物车id
@property(nonatomic,strong)NSMutableArray *cidArray;
@property(nonatomic,strong)NSString *priceStr;//单价的拼接字符串
@property(nonatomic,strong)QQShoppingConfirmAcountView *footView;//底部view
@property(nonatomic,strong)NSString *usermoney;//账户余额
@end

@implementation QQShoppingConfirmOrder
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:APPAlipayNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification) name:APPAlipayNotification object:nil];
    [self getStyleRequest];
    [self getBalanceRequest];
}

- (void)getBalanceRequest {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@",shopping_getBalanceURL,[UserManager shareManager].userName];
    NSLog(@"%@",QQ_API_CON(urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        if (response[@"usermoney"]) {
            wSelf.usermoney = response[@"usermoney"];
        }
    } fail:^(NSError *error) {
    }];
}

- (void)notification {
    [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"订单支付成功~"];
    NSArray *vcArr = self.navigationController.viewControllers;
    NSMutableArray *muArr = [[NSMutableArray alloc]initWithArray:vcArr];
    QQShoppingOrderViewController *vc = [[QQShoppingOrderViewController alloc]init];
    [muArr removeLastObject];
    [muArr removeLastObject];
    [muArr addObject:vc];
    vc.selectIndex = 2;
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.viewControllers = [muArr copy];
}

- (void)getAllPrice {
    CGFloat price = 0;
    self.allNum = 0;
    self.allPid = @"";
    self.cidStr = @"";
    self.priceStr = @"";
    for (int i = 0; i<self.modelArray.count; i++) {
        QQShoppingCarModel *model = self.modelArray[i];
        price += [model.carNum integerValue] * [model.productPrice floatValue];
        self.allNum += [model.carNum integerValue];
        self.allPid = [self.allPid stringByAppendingString:model.pid];
        if (i == 0) {
            self.priceStr = [self.priceStr  stringByAppendingString:model.productPrice];
        }else{
            self.priceStr = [self.priceStr  stringByAppendingString:[NSString stringWithFormat:@",%@",model.productPrice]];
        }
        if (model.carId) {
            [self.cidArray addObject:model.carId];
        }
    }
    self.allPrice = [NSString stringWithFormat:@"%.2f",price];
}

//直接点支付
- (void)alipayRequest {
    WS(wSelf);
    NSString *proStr = [NSString stringWithFormat:@"&product_dp=%@",self.product_dp];
    NSString *urlStr;
    NSString *payUrl;
    if ([self.payStr isEqualToString:@"支付宝"]) {
        payUrl = shopping_alipayURL;
    }else if ([self.payStr isEqualToString:@"微信"]) {
        payUrl = shopping_wechatPayURL;
    }else{
        payUrl = shopping_balancePayURL;
    }
    if (self.isCar) {
        self.allPrice = @"0.01";
        urlStr= [NSString stringWithFormat:@"%@username=%@&aid=%@&gdistribution=%@&cid=%@",payUrl,[UserManager shareManager].userName,self.addressModel.aid,self.sendStr,[self.cidArray componentsJoinedByString:@","]];
    }else{
        urlStr= [NSString stringWithFormat:@"%@username=%@&paymoney=%@&aid=%@&gdistribution=%@&pid=%@&num=%ld%@",payUrl,[UserManager shareManager].userName,self.allPrice,self.addressModel.aid,self.sendStr,self.allPid,self.allNum,proStr];
    }
    //点击支付宝
    if ([wSelf.payStr isEqualToString:@"支付宝"]) {
        NSString *productName = @"";
        for (int i = 0; i<self.modelArray.count; i++) {
            QQShoppingCarModel *model = self.modelArray[i];
            productName = [productName stringByAppendingString:model.productName];
        }
        [[QQAlipayManagerTool sharedInstance]shoppingAlipayWithURLStr:urlStr productName:productName Price:self.allPrice];
    }else if ([wSelf.payStr isEqualToString:@"余额"]){
        [QQShoppingTools showAlertControllerWithTitle:@"" message:[NSString stringWithFormat:@"余额支付%@元",self.allPrice] confirmTitle:@"确定" cancleTitle:@"取消" vc:wSelf confirmBlock:^{
            [wSelf banlancePay:urlStr];
        } cancleBlock:^{
        }];

    }else{
        [[QQAlipayManagerTool sharedInstance]wechatPay:urlStr];
    }
}

- (void)banlancePay:(NSString *)urlStr {
    NSString *utf8 = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",QQ_API_CON(urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(utf8) refreshCache:YES success:^(id response) {
        if ([response[@"stats"] isEqualToString:@"okok"] || [response[@"stats"] isEqualToString:@"ok"]) {
            [DataManager save:@"" forKey:@"刷新用户信息"];
            [[NSNotificationCenter defaultCenter]postNotificationName:APPAlipayNotification object:@"支付成功"];
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
        }
//        NSLog(@"余额支付 ------ %@",response);
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

//获取快递方式
- (void)getStyleRequest {
    NSString *str = [NSString stringWithFormat:@"%@username=%@",shopping_deliveryURL,[UserManager shareManager].userName];
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        //NSLog(@"配送方式 ----------%@",response);
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingSendStyleModel class] json:response];
        [self.sendStyleArr addObjectsFromArray:tempArr];
    } fail:^(NSError *error) {
        NSLog(@"配送方式 ----------%@",error);
    }];
}

- (void)getData {
    self.model = [[QQShoppingConfirmModel alloc]init];
    self.model.defPlace = YES;
    NSArray *keyArr = @[@"配送方式",@"支付方式"];
    NSArray *valueArr = @[@"请选择配送方式",@"请选择支付方式"];
    for (int i=0; i<keyArr.count; i++) {
        QQShoppingConfirmStyleModel *model = [[QQShoppingConfirmStyleModel alloc]init];
        model.styleKey = keyArr[i];
        model.styleValue = valueArr[i];
        [self.stylesArray addObject:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count+1+self.stylesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.modelArray.count) {
        QQShoppingConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingConfirmOrderCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.modelArray[indexPath.row];
        return cell;
    }else if (indexPath.row == self.modelArray.count) {
        QQShoppingConfirmExplineCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingConfirmExplineCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        QQShoppingConfirmChooseStyle *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingConfirmChooseStyleID];
        cell.model = self.stylesArray[indexPath.row-self.modelArray.count-1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.modelArray.count) {
        return 97;
    }else if (indexPath.row == self.modelArray.count ) {
        return 45;
    }else{
        return 58*SCREEN_W/375;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(wSelf);
    if (indexPath.row == self.modelArray.count+1+self.stylesArray.count-2) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (QQShoppingSendStyleModel *model in self.sendStyleArr) {
            [arr addObject:model.dname];
        }
        if (arr.count == 0) {
            [arr addObject:@"圆通"];
            [arr addObject:@"申通"];
            [arr addObject:@"韵达"];
        }
        [QQShoppingTools showSheetControllerWithTitiles:arr vc:self confirmBlock:^(NSInteger index) {
//            NSLog(@"%ld(long)",index);
            QQShoppingConfirmChooseStyle *cell = [tableView cellForRowAtIndexPath:indexPath];
            wSelf.sendStr = arr[index];
            [cell.rightBtn setTitle:arr[index] forState:UIControlStateNormal];
        }];
    }
    if (indexPath.row == self.modelArray.count+1+self.stylesArray.count-1) {
        QQShoppingConfirmStyleModel *model = self.stylesArray[1];
        QQShoppingConfirmChooseStyle *cell = [tableView cellForRowAtIndexPath:indexPath];
        QQShoppingPostAndPayView *view = [[QQShoppingPostAndPayView alloc]init];
        view.shopping_postAndPayBlock = ^(NSString *stye, NSString *imageName) {
            model.styleValue = stye;
            model.imageName = imageName;
            cell.model = model;
            wSelf.payStr = stye;
        };
        //余额是否足够
        view.isBalance = [self.allPrice floatValue] > [self.usermoney floatValue]?NO:YES;
        view.isPost = NO;
        [view show];
    }
}

- (void)createUI {
    self.title = @"确认订单";
    [self getData];
    [self getAllPrice];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-57-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"QQShoppingConfirmOrderCell" bundle:nil] forCellReuseIdentifier:QQShoppingConfirmOrderCellID];
        [_tableView registerClass:[QQShoppingConfirmExplineCell class] forCellReuseIdentifier:QQShoppingConfirmExplineCellID];
        [_tableView registerClass:[QQShoppingConfirmChooseStyle class] forCellReuseIdentifier:QQShoppingConfirmChooseStyleID];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        self.headView = [[NSBundle mainBundle]loadNibNamed:@"QQConfirmOrderHeadView" owner:self options:nil][0];
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, 106);
        self.headView.orderNumView.hidden = YES;
        self.headView.orderNumViewHeight.constant = 0;
        self.headView.hiddenTapLabel = self.addressModel?YES:NO;
        self.headView.model = self.addressModel;
        _tableView.tableHeaderView = self.headView;
        WS(wSelf);
        self.headView.shopping_addPlaceBlock = ^{
            QQShoppingPlaceManagerVC *vc = [[QQShoppingPlaceManagerVC alloc]init];
            vc.shopping_goolsPlaceBlock = ^(QQShoppingAddressListModel *model) {
                wSelf.headView.hiddenTapLabel = YES;
                wSelf.headView.model = model;
                wSelf.addressModel = model;
            };
            [wSelf.navigationController pushViewController:vc animated:YES];
        };
        self.footView = [[NSBundle mainBundle]loadNibNamed:@"QQShoppingConfirmAcountView" owner:nil options:nil][0];
        self.footView.frame = CGRectMake(0, 0, SCREEN_W, 65);
        self.footView.acountPrice.text = [NSString stringWithFormat:@"￥%.2f",[self.allPrice floatValue]];
        _tableView.tableFooterView = self.footView;
    }
    return _tableView;
}

- (UIView *)footView {
    if (!_footView) {

    }
    return _footView;
}

- (NSMutableArray *)sendStyleArr {
    if (!_sendStyleArr) {
        _sendStyleArr = [[NSMutableArray alloc]init];
    }
    return _sendStyleArr;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray *)stylesArray {
    if (!_stylesArray) {
        _stylesArray = [[NSMutableArray alloc]init];
    }
    return _stylesArray;
}

- (NSMutableArray *)cidArray {
    if (!_cidArray) {
        _cidArray = [[NSMutableArray alloc]init];
    }
    return _cidArray;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_H-57-64, SCREEN_W, 57)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"提交订单" forState:UIControlStateNormal];
        [btn setBackgroundColor:[Tools getUIColorFromString:@"ed4044"]];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(sendOrderBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(SCREEN_W-120, 7, 105, 43);
        [_bgView addSubview:btn];
        
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-120-15, 57)];
        self.priceLabel.font = [UIFont systemFontOfSize:13];
        self.priceLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"合计：￥%@",self.allPrice] changeStr:self.allPrice color:[Tools getUIColorFromString:@"ed4044"] font:[UIFont systemFontOfSize:13]];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:self.priceLabel];
    }
    return _bgView;
}

- (void)sendOrderBtnClick {
    if (self.headView.nameLabel.text.length == 0) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请选择收货地址"];
        return;
    }
    if (!self.sendStr) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请选择配送方式"];
        return;
    }
    if (!self.payStr) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请选择支付方式"];
        return;
    }
    [self alipayRequest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
