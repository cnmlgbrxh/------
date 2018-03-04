//
//  QQShoppingAllOrderVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingAllOrderVC.h"
#import "QQShoppingOrderListCell.h"
#import "QQShoppingOrderDetailVC.h"
#import "QQShoppingOrderListModel.h"

@interface QQShoppingAllOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *urlStr;
@end

@implementation QQShoppingAllOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setUrlStr];
    [self getAllOrderRequest];
}

- (void)deleteOrder:(QQShoppingOrderListModel *)model{
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&oid=%@",shopping_cancleOrderURL,[UserManager shareManager].userName,model.gid];
    //NSLog(@"url ----- %@",QQ_API_CON(urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        //NSLog(@"----%@",response);
        if ([response[@"stats"] isEqualToString:@"ok"]) {
            [wSelf.dataArray removeObject:model];
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"订单取消成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wSelf getAllOrderRequest];
            });
        }
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)setUrlStr {
    if (self.currentIndex == 0) {
        self.urlStr = [NSString stringWithFormat:@"%@username=%@",shopping_orderListURL,[UserManager shareManager].userName];
    }else if (self.currentIndex == 1) {
        self.urlStr = [NSString stringWithFormat:@"%@username=%@&nopay=1",shopping_orderListURL,[UserManager shareManager].userName];
    }else if (self.currentIndex == 2) {
        self.urlStr = [NSString stringWithFormat:@"%@username=%@&no_delivery=1",shopping_orderListURL,[UserManager shareManager].userName];
    }else if (self.currentIndex == 3) {
        self.urlStr = [NSString stringWithFormat:@"%@username=%@&delivery=1",shopping_orderListURL,[UserManager shareManager].userName];
    }else if (self.currentIndex == 4) {
        self.urlStr = [NSString stringWithFormat:@"%@username=%@&take=1",shopping_orderListURL,[UserManager shareManager].userName];
    }else{
        self.urlStr = [NSString stringWithFormat:@"%@username=%@&abolish=1",shopping_orderListURL,[UserManager shareManager].userName];
    }
}

- (void)getAllOrderRequest {
    WS(wSelf);
    NSLog(@"全部订单%@",QQ_API_CON(self.urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(self.urlStr) refreshCache:YES success:^(id response) {
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
        [wSelf.dataArray removeAllObjects];
       // NSLog(@"%@",response);
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
                [wSelf getAllOrderRequest];
            };
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //QQShoppingOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingOrderListCellId];
    QQShoppingOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingOrderListCellId forIndexPath:indexPath];
    QQShoppingOrderListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    WS(wSelf);
    cell.shopping_orderListCancleBlock = ^(NSString *titleStr) {
        if ([titleStr isEqualToString:@"取消订单"]) {
            [QQShoppingTools showAlertControllerWithTitle:@"" message:@"确认要取消订单吗！" confirmTitle:@"确定" cancleTitle:@"再想想" vc:wSelf confirmBlock:^{
                [wSelf deleteOrder:model];
            } cancleBlock:^{
            }];
        }
    };
    
    cell.shopping_orderListYesBlock = ^(NSString *titleStr) {
        QQShoppingOrderDetailVC *vc = [[QQShoppingOrderDetailVC alloc]init];
        vc.model = model;
        vc.shopping_deleteOrderBlock = ^{
            [wSelf getAllOrderRequest];
        };
        [wSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(wSelf);
    QQShoppingOrderListModel *model = self.dataArray[indexPath.row];
    QQShoppingOrderDetailVC *vc = [[QQShoppingOrderDetailVC alloc]init];
    vc.shopping_deleteOrderBlock = ^{
        [wSelf getAllOrderRequest];
    };
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createUI {
    self.view.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-45-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 250;
        _tableView.separatorStyle = UITableViewScrollPositionNone;
        [_tableView registerNib:[UINib nibWithNibName:@"QQShoppingOrderListCell" bundle:nil] forCellReuseIdentifier:QQShoppingOrderListCellId];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
