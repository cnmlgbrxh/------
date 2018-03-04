//
//  QQShoppingIntegralDetailVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingIntegralDetailVC.h"
#import "QQShoppingIntegralDetailHeadView.h"
#import "QQShoppingProducDetailHeadView.h"
#import "QQShoppingExchangeStyesVC.h"
#import "QQShoppingPhoneMoneyVC.h"
#import "QQShoppingChangeGoolsVC.h"
#import "QQShoppingProductDetailModel.h"

@interface QQShoppingIntegralDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *footiew;
@property(nonatomic,strong)NSString *explainStr;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)QQShoppingIntegralDetailHeadView *headView;
@property(nonatomic,strong)QQShoppingProductDetailModel *detailModel;
@property(nonatomic,strong)UILabel *explanLabel;
@property(nonatomic,strong)UIButton *nextBtn;
@end

@implementation QQShoppingIntegralDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

- (void)getData {
    self.headView.model = self.model;
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&pid=%@",integ_produceDetailURL,[UserManager shareManager].userName,self.model.productId.length>0?self.model.productId:self.pid];
    NSLog(@"%@",Integ_API_CON(urlStr));
    [HYBNetworking getWithUrl:Integ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        NSLog(@"%@",response);
        wSelf.detailModel = [QQShoppingProductDetailModel yy_modelWithJSON:response];
        wSelf.headView.detailModel = wSelf.detailModel;
        [wSelf setNextBtn];
        [wSelf.tableView reloadData];
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)setNextBtn {
    if (self.pid) {
        if ([self.score floatValue] >=[self.detailModel.producting floatValue]) {
            self.nextBtn.backgroundColor = [Tools getUIColorFromString:@"ed4044"];
            self.nextBtn.userInteractionEnabled = YES;
        }
    }else{
        if ([self.score floatValue] >= [self.model.producting floatValue]) {
            self.nextBtn.backgroundColor = [Tools getUIColorFromString:@"ed4044"];
            self.nextBtn.userInteractionEnabled = YES;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0? 1:self.detailModel.details.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QQShoppingIntegraDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingIntegraDetailTitleCellID];
        cell.nameLabel.text = self.detailModel.describe;
        return cell;
    }
        QQShoppingProducDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingProducDetailCellID];
    NSArray *arr = self.detailModel.details;
    cell.urlStr = arr[indexPath.row];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00000f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat height = [[QQShoppingTools shareInstance]calculateRowHeight:self.detailModel.describe fontSize:12 bgViewWidth:SCREEN_W-20];
        if (self.detailModel.describe.length >0) {
            return height+10;
        }else{
            return 0;
        }
    }
    return SCREEN_W*0.93;
}

- (void)createUI {
    self.title = @"积分商城";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-72-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        self.headView = [[NSBundle mainBundle] loadNibNamed:@"QQShoppingIntegralDetailHeadView" owner:self options:nil][0];
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[QQShoppingIntegraDetailTitleCell class] forCellReuseIdentifier:QQShoppingIntegraDetailTitleCellID];
        [_tableView registerClass:[QQShoppingProducDetailCell class] forCellReuseIdentifier:QQShoppingProducDetailCellID];
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (UIView *)footiew {
    if (!_footiew) {
        _footiew = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 0)];
        _footiew.backgroundColor = [UIColor whiteColor];
        [_footiew addSubview:self.explanLabel];
    }
    return _footiew;
}

- (UILabel *)explanLabel {
    if (!_explanLabel) {
        _explanLabel = [[UILabel alloc]init];
        _explanLabel.font = [UIFont systemFontOfSize:12];
        _explanLabel.textColor = [Tools getUIColorFromString:@"686868"];
        _explanLabel.numberOfLines = 0;
        _explanLabel.backgroundColor = [UIColor whiteColor];
    }
    return _explanLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H-72-64, SCREEN_W, 72)];
        _bgView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        
        self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextBtn.frame = CGRectMake(60, 13, SCREEN_W-60-60, 40);
        self.nextBtn.layer.cornerRadius = 3;
        self.nextBtn.layer.masksToBounds = YES;
        [self.nextBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        [self.nextBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.nextBtn.backgroundColor = [Tools getUIColorFromString:@"d2d2d2"];
        self.nextBtn.userInteractionEnabled = NO;
        [_bgView addSubview:self.nextBtn];
    }
    return _bgView;
}

- (void)changeBtnClick {
    //0：现金红包  1：手机充值  2：实物
    NSInteger status = 2;
    if (status == 0) {
    QQShoppingExchangeStyesVC *vc = [[QQShoppingExchangeStyesVC alloc]initWithNibName:@"QQShoppingExchangeStyesVC" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (status == 1){
        QQShoppingPhoneMoneyVC *vc = [[QQShoppingPhoneMoneyVC alloc]initWithNibName:@"QQShoppingPhoneMoneyVC" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        QQShoppingChangeGoolsVC *vc = [[QQShoppingChangeGoolsVC alloc]initWithNibName:@"QQShoppingChangeGoolsVC" bundle:[NSBundle mainBundle]];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
