//
//  QQChangeRecordVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//兑换记录

#import "QQChangeRecordVC.h"
#import "RSCommonTableView.h"
#import "QQChangeRecordCell.h"
#import "QQChangeRecordModel.h"
#import "QQChangeRecordDetailVC.h"
#import "QQShoppingOrderListModel.h"

@interface QQChangeRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)RSCommonTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation QQChangeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRecordRequest];
}

- (void)getRecordRequest {
    WS(wSelf);
    [[RSMBProgressHUDTool shareProgressHUDManager]showViewLoadingHUD:self.view showText:@"正在加载..."];
    NSString *url = [NSString stringWithFormat:@"%@username=%@",integ_changeRecordURL,[UserManager shareManager].userName];
    NSLog(@"%@",Integ_API_CON(url));
    [HYBNetworking getWithUrl:Integ_API_CON(url) refreshCache:YES success:^(id response) {
        [wSelf.dataArray removeAllObjects];
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingOrderListModel class] json:response];
        [wSelf.dataArray addObjectsFromArray:tempArr];
        if (wSelf.dataArray.count == 0) {
            [[BSNoDataCustomView sharedInstance]showCustormViewToTargetView:self.view];
        }else{
            [[BSNoDataCustomView sharedInstance]hiddenNoDataView];
        }
        [wSelf.tableView reloadData];

    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
        if (error.code == -1009) {
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-4)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf getRecordRequest];
            };
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)createUI {
    self.title = @"兑换记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark --- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQChangeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:QQChangeRecordCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QQShoppingOrderListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    WS(wSelf);
    cell.shopping_changeRecordBlock = ^{
        [QQShoppingTools showAlertControllerWithTitle:@"" message:@"兑换成功，请注意查收！" confirmTitle:nil cancleTitle:@"好" vc:self confirmBlock:^{
        } cancleBlock:^{
//           model.goolsStatus = @"0";
            [wSelf.tableView reloadData];
        }];

    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingOrderListModel *model = self.dataArray[indexPath.row];
    if ([model.gstats isEqualToString:@"1"] && [model.is_delivery isEqualToString:@"1"] && [model.take_delivery isEqualToString:@"1"]) {
        return 150;
    }else if ([model.gstats isEqualToString:@"1"] && [model.is_delivery isEqualToString:@"1"]) {
        return 196;
    }else{
        return 150;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QQChangeRecordDetailVC *vc = [[QQChangeRecordDetailVC alloc]init];
//    if (indexPath.row == 0) {
//        vc.status = @"0";
//    }else if (indexPath.row == 1) {
//        vc.status = @"1";
//    }else {
        vc.status = @"2";
//    }
    WS(wSelf);
    QQShoppingOrderListModel *model = self.dataArray[indexPath.row];
    vc.model = model;
    vc.integ_configGetGoolsBlock = ^{
        [wSelf getRecordRequest];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UI
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[RSCommonTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:QQChangeRecordCellClass bundle:nil] forCellReuseIdentifier:QQChangeRecordCellID];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];;
    }
    return _dataArray;
}

- (void)back {
    if (self.toRootVC) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
