//
//  SmallStateViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "SmallStateViewController.h"
#import "CellSmallState.h"
@interface SmallStateViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSMutableDictionary *dicmSelect;

@end

@implementation SmallStateViewController{
    NSArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = HOMECOLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
}
-(void)loadData{
    
    _dicmSelect = [NSMutableDictionary dictionary];
    
    NSDictionary *dicParameters = @{@"action":@"didownbuy",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS
                                    };
    [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject)
     {
         arrData = responseObject;
         if (arrData.count > 0) {
             [arrData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 [_dicmSelect setObject:[obj objectForKey:@"prior"] forKey:[NSNumber numberWithInteger:100+idx]];
             }];
             [_tableView reloadData];
         }else{
             [[BSNoDataCustomView sharedInstance]showCustormViewToTargetView:self.view];
         }
         
//         if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"])
//         {
//             
//         }else if ([[responseObject objectForKey:@"stats"] isEqualToString:@"errorlogin"])
//         {
//             [MessageHUG showAlert:[responseObject objectForKey:@"msg"] animateWithDuration:3 showAddedTo:self.view completion:^{
//                 [MessageHUG restoreLoginViewController];
//             }];
//             
//         }else
//         {
//             [MessageHUG showAlert:[responseObject objectForKey:@"msg"] showAddedTo:self.view];
//         }
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
    CellSmallState *cell = LoadViewWithNIB(@"CellSmallState");
    if (cell == nil) {
        cell = [[CellSmallState alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellSmallState"];
    }
    cell.dicDetail = arrData[indexPath.row];
    cell.tag = indexPath.row+100;
    cell.isSelect = [[self.dicmSelect objectForKey:[NSNumber numberWithInteger:indexPath.row+100]] boolValue];
//    if ([self.dicmSelect.allKeys containsObject:[NSNumber numberWithInteger:indexPath.row+100]])
//    {
//        cell.isSelect = [[self.dicmSelect objectForKey:[NSNumber numberWithInteger:indexPath.row+100]] boolValue];
//    }else{
//        
//    }
    
    WeakSelf;
    cell.BlockSelect = ^(BOOL isSelect,NSInteger intTag) {
        [weakSelf.dicmSelect setObject:[NSNumber numberWithBool:isSelect] forKey:[NSNumber numberWithInteger:intTag]];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//#pragma mark - 懒加载
//-(NSMutableDictionary *)dicmSelect{
//    if (!_dicmSelect) {
//        self.dicmSelect = [NSMutableDictionary dictionary];
//    }
//    return _dicmSelect;
//}
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
