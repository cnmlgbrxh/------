//
//  PurchaseNumberDetailViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PurchaseNumberDetailViewController.h"
#import "PurchasePackageFootView.h"
#import "CellTableViewDefault.h"
#import "CellSelectState.h"
@interface PurchaseNumberDetailViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *labNumber;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;

@end

@implementation PurchaseNumberDetailViewController{
    NSArray *arrData;
    NSString *strPayAmount;
    NSIndexPath *beforeIndexPath;
    NSString *strMonth;
    NSString *strMonthFee;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"购买小号";
    
    _layTop.constant = Sc(20);
    
    _layHeight.constant = Sc(114);
    
    strMonth = @"1";
    
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = HOMECOLOR;
    _tableView.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_W, Scale(50));
    
    _labNumber.text = [_dicDetail objectForKey:@"name"];
    
    _labPrice.text = [NSString stringWithFormat:@"合计:%@元",strPayAmount];
    
    PurchasePackageFootView *purchasePackageFootView = LoadViewWithNIB(@"PurchasePackageFootView");
    purchasePackageFootView.frame = CGRectMake(0, 0, SCREEN_W, 70);
    purchasePackageFootView.strLayout = @"";
    purchasePackageFootView.strAlert = @" 号码接听每分钟1毛,打电话免费,号码购买开通的时候赠送10%的余额。";
    _tableView.tableFooterView = purchasePackageFootView;
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
    //月租费
    strMonthFee = [NSString stringWithFormat:@"%@元",[_dicDetail objectForKey:@"money"]];
    
    arrData = @[@[@{@"选号费":[NSString stringWithFormat:@"%@元",[_dicDetail objectForKey:@"buynum"]]},@{@"月租费":strMonthFee}],@[@"一个月",@"三个月",@"六个月",@"一年"]];
    //一个月共多少钱
    strPayAmount = [NSString stringWithFormat:@"%ld",[[_dicDetail objectForKey:@"buynum"] integerValue]+[[_dicDetail objectForKey:@"money"] integerValue]];
    
    [_tableView reloadData];
}
- (IBAction)goBuyClick:(UIButton *)sender {
    
    
    NSDictionary *dicParameters = @{@"action":@"didpay",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS,
                                    @"didnumber":[_dicDetail objectForKey:@"name"],
                                    @"money":strPayAmount,
                                    @"month":strMonth
                                    };
    [DataRequest POST_Parameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //购买成功,通知刷新界面
         if (self.BlockSuccess) {
             self.BlockSuccess();
         }
         [DataManager save:@"" forKey:@"刷新用户信息"];
         WeakSelf
         [MessageHUG showSystemAlert:[responseObject objectForKey:@"msg"] controller:self completion:^{
             [weakSelf.navigationController popViewControllerAnimated:YES];
         }];
     }];
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath == beforeIndexPath) {
        return;
    }
    
    CellSelectState *cellSelect = (CellSelectState *)[self.view viewWithTag:100+indexPath.row];
    cellSelect.isSelect = YES;
    CellSelectState *cellBefore =(CellSelectState *)[self.view viewWithTag:100+beforeIndexPath.row];;
    cellBefore.isSelect = NO;
    beforeIndexPath = indexPath;
    
    
    if (indexPath.row == 0) {
        strMonth = @"1";
    }else if (indexPath.row == 1){
        strMonth = @"3";
    }else if (indexPath.row == 2){
        strMonth = @"6";
    }else if (indexPath.row == 3){
        strMonth = @"12";
    }
    
    _labPrice.text = [NSString stringWithFormat:@"合计:%ld元",[strMonthFee integerValue]*[strMonth integerValue]+[[_dicDetail objectForKey:@"buynum"] integerValue]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return Scale(55);
    }else{
        return Scale(50);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.000000000000001;
    }else{
        return Scale(47);
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000000000000001;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark 自定组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = [NSString stringWithFormat:@"%@",@"  选择使用期限"];
        lab.textColor = ColorHex(0xb1b1b1);
        lab.font = [UIFont systemFontOfSize:16];
        lab.backgroundColor = HOMECOLOR;
        return lab;
    }else
    {
        return nil;
    }
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arrData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        CellTableViewDefault *cell = LoadViewWithNIB(@"CellTableViewDefault");
        if (cell == nil) {
            cell = [[CellTableViewDefault alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellTableViewDefault"];
        }
        cell.dicDetail = arrData[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        CellSelectState *cell =[tableView dequeueReusableCellWithIdentifier:@"CellSelectState"];
        if (cell == nil) {
            cell = LoadViewWithNIB(@"CellSelectState");
        }
        if (indexPath.row == 0) {
            cell.isSelect = YES;
            beforeIndexPath = indexPath;
        }
        cell.tag = 100+indexPath.row;
        cell.strName = arrData[indexPath.section][indexPath.row];
        return cell;
    }
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
