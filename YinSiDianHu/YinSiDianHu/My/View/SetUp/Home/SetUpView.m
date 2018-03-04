//
//  SetUpView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "SetUpView.h"
#import "CellSetUp.h"
#import "RechargeViewController.h"
#import "PurchaseNumberViewController.h"
#import "LevelQueryViewController.h"
#import "MyView.h"
@interface SetUpView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView *headImageView;
@end

@implementation SetUpView{
    UITableView *_tableView;
    NSArray *arrData;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
//        if ([USERMANAGER.level isEqualToString:@"super"]) {
            arrData = @[@"账户充值",@"设置显示号码",@"购买小号",@"通话变音"];
//        }else{
//            arrData = @[@"账户充值",@"通话变音"];
//        }
        
        [self creatUI];
        
    }
    return self;
}
#pragma mark - 创建UI
-(void)creatUI{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.height) style:UITableViewStylePlain];
    }
    _tableView.backgroundColor = HOMECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = Sc(94);
    _tableView.tableHeaderView = self.headImageView;
    [self addSubview:_tableView];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *strTitle = arrData[indexPath.row];
    if ([strTitle isEqualToString:@"账户充值"])
    {
        RechargeViewController *accountRechargeVC = [[RechargeViewController alloc]init];
        accountRechargeVC.navTitle = arrData[indexPath.row];
        [_viewController.navigationController pushViewController:accountRechargeVC animated:YES];
    }else if ([strTitle isEqualToString:@"设置显示号码"])
    {
        MyView *myView = [[MyView alloc]init];
        [myView setUpShowNumber:_viewController alertAddedTo:self];
    }else if ([strTitle isEqualToString:@"购买小号"])
    {
        PurchaseNumberViewController *purchaseNumberVC = [[PurchaseNumberViewController alloc]init];
        purchaseNumberVC.navTitle = @"";
        [_viewController.navigationController pushViewController:purchaseNumberVC animated:YES];
    }else if ([strTitle isEqualToString:@"通话变音"])
    {
        MyView *myView = [[MyView alloc]init];
        [myView setUpCallTone:_viewController alertAddedTo:self];
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
    CellSetUp *cell = LoadViewWithNIB(@"CellSetUp");
    if (cell == nil) {
        cell = [[CellSetUp alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.strName = arrData[indexPath.row];
    return cell;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, Sc(579))];
        _headImageView.image = QQIMAGE(@"setting_bannerImage");
    }
    return _headImageView;
}
@end
