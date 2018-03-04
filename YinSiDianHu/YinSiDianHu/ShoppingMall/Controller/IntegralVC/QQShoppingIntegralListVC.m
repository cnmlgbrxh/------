//
//  QQShoppingIntegralListVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingIntegralListVC.h"
#import "QQShoppingJifenListCell.h"
#import "QQIntegConsumeDetailModel.h"

@interface QQShoppingIntegralListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArary;
@end

@implementation QQShoppingIntegralListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

- (void)getData {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&userpass=%@",integ_jifenDetailURL,[UserManager shareManager].userName,USERPASS];
    [HYBNetworking getWithUrl:Integ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        NSLog(@"%@",response);
        if (response) {
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQIntegConsumeDetailModel class] json:response];
            [wSelf.dataArary addObjectsFromArray:tempArr];
            if (wSelf.dataArary.count == 0) {
                [[BSNoDataCustomView sharedInstance] showCustormViewToTargetView:self.view promptText:@"暂无相关数据哦~" customViewFrame:CGRectMake(0, 308, SCREEN_W, SCREEN_H-308)];
            }else{
                [[BSNoDataCustomView sharedInstance] hiddenNoDataView];
            }
            [wSelf.tableView reloadData];
        }
    } fail:^(NSError *error) {
        if (error.code == -1009) {
            WS(wSelf);
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-4)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf getData];
            };
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingJifenListCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingJifenListCellID];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.model = self.dataArary[indexPath.row];
    return cell;
}

- (void)createUI {
    self.title = @"积分明细";
    self.view.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        [_tableView registerNib:[UINib nibWithNibName:@"QQShoppingJifenListCell" bundle:nil] forCellReuseIdentifier:QQShoppingJifenListCellID];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataArary {
    if (!_dataArary) {
        _dataArary = [[NSMutableArray alloc]init];
    }
    return _dataArary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
