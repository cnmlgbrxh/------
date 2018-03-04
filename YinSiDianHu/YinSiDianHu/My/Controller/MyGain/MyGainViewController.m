//
//  MyGainViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "MyGainViewController.h"
#import "CellMentionDetail.h"
#import "PurchasePackageFootView.h"
@interface MyGainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyGainViewController{
    NSArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrData = @[@[@{@"卡号":@"请输入您的银行卡号"},@{@"持卡人":@"请输入您的持卡人姓名"}],@[@{@"户行":@"请输入您的开户银行"},@{@"名称":@"请输入您的支开户行名称"}]];
    
    PurchasePackageFootView *purchasePackageFootView = LoadViewWithNIB(@"PurchasePackageFootView");
    purchasePackageFootView.frame = CGRectMake(0, 0, SCREEN_W, 60);
    purchasePackageFootView.strAlert = @"  我们会在1-3个工作日内把资金退还到您指定的银行卡上,请耐心等待。";
    _tableView.tableFooterView = purchasePackageFootView;
}
- (IBAction)confirm:(UIButton *)sender {
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000000000001;
}
#pragma mark 自定组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lab = [[UILabel alloc]init];
    if (section == 0) {
        lab.text = [NSString stringWithFormat:@"   %@", @"持卡人信息   请填写真实信息,核实后不可更改"];
    }else
    {
        lab.text = [NSString stringWithFormat:@"   %@", @"银行卡信息   请如实填写"];
    }
    lab.textColor = ColorHex(0x5e5e5e);
    lab.font = [UIFont systemFontOfSize:13];
    lab.backgroundColor = HOMECOLOR;
    return lab;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arrData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellMentionDetail *cell = LoadViewWithNIB(@"CellMentionDetail");
    if (cell == nil) {
        cell = [[CellMentionDetail alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellMentionDetail"];
    }
    cell.dicDetail = arrData[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
