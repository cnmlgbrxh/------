//
//  TradingRecordsViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "TradingRecordsViewController.h"
#import "CellTradingRecords.h"
@interface TradingRecordsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TradingRecordsViewController{
    NSArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = HOMECOLOR;

    NSDictionary *dicParameters = @{@"action":@"paylog",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS,
                                    };
    [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
        
        arrData = responseObject;
        if (arrData.count > 0) {
            [_tableView reloadData];
        }else{
            [[BSNoDataCustomView sharedInstance]showCustormViewToTargetView:self.view];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellTradingRecords *cell = LoadViewWithNIB(@"CellTradingRecords");
    if (cell == nil) {
        cell = [[CellTradingRecords alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTradingRecords"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dicDetail = arrData[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
