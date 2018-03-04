//
//  AboutQiQuViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "AboutQiQuViewController.h"
#import "CellAboutQiQu.h"
#import "UsingHelpViewController.h"
#import "ContactUsViewController.h"
#import "LoadWebViewViewController.h"
@interface AboutQiQuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AboutQiQuViewController{
    NSArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    arrData = @[@"检查更新",@"用户协议",@"使用帮助",@"联系方式"];
    
    UIView *viewFoot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.view.height-35)];
    viewFoot.backgroundColor = HOMECOLOR;
    _tableView.tableFooterView = viewFoot;
    _tableView.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_W, Sc(413));
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        LoadWebViewViewController *load = [[LoadWebViewViewController alloc]init];
        load.navTitle = arrData[indexPath.row];
        load.strUrl = @"reg.php";
        [self.navigationController pushViewController:load animated:YES];
    }else if (indexPath.row == 2)
    {//使用帮助
//        UsingHelpViewController *usingHelpVC = [[UsingHelpViewController alloc]init];
//        usingHelpVC.navTitle = arrData[indexPath.row];
//        [self.navigationController pushViewController:usingHelpVC animated:YES];
        LoadWebViewViewController *load = [[LoadWebViewViewController alloc]init];
        load.navTitle = arrData[indexPath.row];
        load.strUrl = [NSString stringWithFormat:@"help.php?username=%@",USERNAME];
        [self.navigationController pushViewController:load animated:YES];
    }else if (indexPath.row == 3)
    {//联系方式
        ContactUsViewController *contactUsVC = [[ContactUsViewController alloc]init];
        contactUsVC.navTitle = arrData[indexPath.row];
        [self.navigationController pushViewController:contactUsVC animated:YES];
    }
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
    CellAboutQiQu *cell = LoadViewWithNIB(@"CellAboutQiQu");
    if (cell == nil) {
        cell = [[CellAboutQiQu alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellAboutQiQu"];
    }
    cell.strName = arrData[indexPath.row];
    if (indexPath.row != 0) {
        cell.rightBtn.hidden = NO;
    }else{
        cell.rightBtn.hidden = YES;
    }
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
