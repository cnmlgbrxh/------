//
//  UsingHelpViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/26.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "UsingHelpViewController.h"
#import "CellUsingHelp.h"
@interface UsingHelpViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UsingHelpViewController{
    NSArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrData = @[@"奇趣电话是什么",@"使用奇趣电话的优势",@"无法拨打电话诸多原因及自我排查",@"邀请好友有什么用",@"为什么拨打电话提示暂不支持国际号码",@"为什么我充值后无法使用自定义号码",@"该软件账户和影子电话、万能电话的区别"];
    
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = HOMECOLOR;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
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
    CellUsingHelp *cell = LoadViewWithNIB(@"CellUsingHelp");
    if (cell == nil) {
        cell = [[CellUsingHelp alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellUsingHelp"];
    }
    cell.strName = arrData[indexPath.row];
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
