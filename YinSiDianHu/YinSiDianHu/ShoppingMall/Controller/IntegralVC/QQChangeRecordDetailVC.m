//
//  QQChangeRecordDetailVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQChangeRecordDetailVC.h"
#import "QQShoppingOrderDetailModel.h"
#import "QQChangeRecordCell.h"

@interface QQChangeRecordDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *getGoolsBtn;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,strong)QQShoppingOrderDetailModel *detailModel;
@end

@implementation QQChangeRecordDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDetailRequest];
}

- (void)getDetailRequest {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@&username=%@&gid=%@",integ_recordDetailURL,[UserManager shareManager].userName,self.model.gid];
    NSLog(@"%@",Integ_API_CON(urlStr));
    [HYBNetworking getWithUrl:Integ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        if (response) {
            wSelf.detailModel = [QQShoppingOrderDetailModel yy_modelWithJSON:response];
            [wSelf.tableView reloadData];
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"系统繁忙、请稍后再试"];
        }
        NSLog(@"%@",response);
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)createUI {
    self.title = @"兑换记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.status isEqualToString:@"0"] || [self.status isEqualToString:@"1"]) {
        return 4;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QQChangeRecordCell *cell =[tableView dequeueReusableCellWithIdentifier:QQChangeRecordCellID];
        cell.model = self.model;
        cell.hiddenRightBtn = YES;
        cell.hiddenBtn = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 1 ||indexPath.row == 2){
        QQChangeTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:QQChangeTimeCellID];
        cell.backgroundColor = [Tools getUIColorFromString:@"efefef" ];
        if ([self.status isEqualToString:@"1"] && indexPath.row == 2) {
            cell.leftLabelStr = @"兑换方式";
            cell.rightLabelStr = @"支付宝";
        }
        if ([self.status isEqualToString:@"2"] && indexPath.row == 2) {
            cell.leftLabelStr = @"配送方式";
            cell.rightLabelStr = self.detailModel.distribution;
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if ([self.status isEqualToString:@"2"] && indexPath.row == 3) {
            QQChangeTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:QQChangeTimeCellID];
            cell.selectionStyle = UITableViewScrollPositionNone;
            cell.leftLabelStr = @"物流单号";
            cell.rightLabelStr = self.detailModel.districode.length>0?self.detailModel.districode:@"暂无";
            return cell;
        }
        QQChangeExplianCell *cell = [tableView dequeueReusableCellWithIdentifier:QQChangeExplianCellID ];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.status isEqualToString:@"2"]) {
        if (indexPath.row == 0 || indexPath.row == 4) {
            return 150;
        }
    }else{
        if (indexPath.row == 0 || indexPath.row == 3) {
            return 150;
        }
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QQChangeRecordHeadView *view =[[QQChangeRecordHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 95*QQAdapter)];
    view.nameLabel.text = self.detailModel.owner;
    view.placeLabel.text = self.detailModel.address;
    view.phoneLabel.text = self.detailModel.phone;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.status isEqualToString:@"2"]?95:0;
}
#pragma mark - UI
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-63) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:QQChangeRecordCellClass bundle:nil] forCellReuseIdentifier:QQChangeRecordCellID];
        [_tableView registerClass:[QQChangeTimeCell class] forCellReuseIdentifier:QQChangeTimeCellID];
        [_tableView registerClass:[QQChangeExplianCell class] forCellReuseIdentifier:QQChangeExplianCellID];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f5f5f5"];
        //        _tableView.tableHeaderView = [[QQChangeRecordHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 95)];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UIView *)bgView {
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H-64-64, SCREEN_W, 64)];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    _getGoolsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getGoolsBtn.layer.cornerRadius = 5;
    _getGoolsBtn.layer.masksToBounds = YES;
    _getGoolsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _getGoolsBtn.frame = CGRectMake(SCREEN_W-110, 10, 100, 40);
    [_getGoolsBtn addTarget:self action:@selector(getGoolsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_getGoolsBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [_getGoolsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getGoolsBtn.backgroundColor = [Tools getUIColorFromString:@"ed4044"];
    [_bgView addSubview:_getGoolsBtn];
    
    _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 0.5)];
    _line.backgroundColor = [Tools getUIColorFromString:@"d9d9d9"];
    [_bgView addSubview:_line];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W-125, 10, 110, 40)];
    label.textColor = [Tools getUIColorFromString:@"ed4044"];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentRight;
    [_bgView addSubview:label];
    
    
    if ([self.model.gstats isEqualToString:@"1"] && [self.model.is_delivery isEqualToString:@"1"] && [self.model.take_delivery isEqualToString:@"1"]) {
        label.text = @"兑换成功";
        _getGoolsBtn.hidden = YES;
    }else if ([self.model.gstats isEqualToString:@"1"] && [self.model.is_delivery isEqualToString:@"1"]) {
        label.hidden = YES;
        _getGoolsBtn.hidden = NO;
    }else{
        label.text = @"等待发货";
        _getGoolsBtn.hidden = YES;
    }
    return _bgView;
}


- (void)getGoolsBtnClick {
    WS(wSelf);
    [QQShoppingTools showAlertControllerWithTitle:@"" message:@"确定收到宝贝了吗？" confirmTitle:@"确定" cancleTitle:@"取消" vc:wSelf confirmBlock:^{
        [wSelf configGetGoolsRequest];
    } cancleBlock:^{
    }];
}


- (void)configGetGoolsRequest {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&gid=%@",integ_confimOrderURL,[UserManager shareManager].userName,self.model.gid];
    NSLog(@"%@",Integ_API_CON(urlStr));
    [HYBNetworking getWithUrl:Integ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        if ([response[@"stats"]isEqualToString:@"ok"]) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"兑换成功"];
            if (wSelf.integ_configGetGoolsBlock) {
                wSelf.integ_configGetGoolsBlock();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wSelf.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
        }
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
