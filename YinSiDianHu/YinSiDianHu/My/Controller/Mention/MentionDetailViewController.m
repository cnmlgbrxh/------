//
//  MentionDetailViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "MentionDetailViewController.h"
#import "CellMentionDetail.h"
@interface MentionDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labAmount;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *labPayWay;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *dicmValue;

@end

@implementation MentionDetailViewController{
    NSArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"提现";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //尾部
    UIView *viewTabViewFoot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 100)];
    viewTabViewFoot.backgroundColor = HOMECOLOR;
    UILabel *labFoot = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, SCREEN_W-20, 30)];
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];//后一天
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    labFoot.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"预计到账时间：%@",[dateFormatter stringFromDate:nextDay]] changeStr:@"预计到账时间：" color:ColorHex(0x9b9b9b) font:[UIFont systemFontOfSize:13]];
    labFoot.font = [UIFont systemFontOfSize:13];
    labFoot.textAlignment = NSTextAlignmentRight;
    labFoot.backgroundColor = [UIColor clearColor];
    [viewTabViewFoot addSubview:labFoot];
    _tableView.tableFooterView = viewTabViewFoot;
    _tableView.backgroundColor = HOMECOLOR;
    
    //赋值
    if ([_strPayStyle isEqualToString:@"支付宝"])
    {
        _labPayWay.text = @"支付宝支付";
        _imageV.image = [UIImage imageNamed:@"支付宝支付"];
        arrData = @[@{@"账户":@"请输入您的支付宝账户"},@{@"名称":@"请输入您的支付宝名称"}];
    }else if ([_strPayStyle isEqualToString:@"银行卡"])
    {
        _labPayWay.text = @"银行卡支付";
        _imageV.image = [UIImage imageNamed:@"银行卡支付"];
        arrData = @[@{@"户行":@"请输入您的开户银行"},@{@"名称":@"请输入您的支开户行名称"},@{@"卡号":@"请输入您的银行卡号"},@{@"持卡人":@"请输入您的持卡人姓名"}];
    }
    
    _labAmount.text = [NSString stringWithFormat:@"%@元",_strAmount];
}
-(void)setStrPayStyle:(NSString *)strPayStyle{
    _strPayStyle = strPayStyle;
}
-(void)setStrAmount:(NSString *)strAmount{
    _strAmount = strAmount;
}
#pragma mark - 下一步Action
- (IBAction)next:(UIButton *)sender {
    if ([_strPayStyle isEqualToString:@"支付宝"])
    {
        if (self.dicmValue.count < 2) {
            [MessageHUG showWarningAlert:@"信息不完整,请核实后在提交"];
            return;
        }
        NSString *strCardNumber = [self.dicmValue objectForKey:@"账户"];
        if (![Tools isValidateNumber:strCardNumber]) {
            [MessageHUG showWarningAlert:@"账户请输入手机号"];
            return;
        }
        NSDictionary *dicParameters = @{@"action":@"cash_alipay",
                                        @"username":USERNAME,
                                        @"userpass":USERPASS,
                                        @"bankname":[self.dicmValue objectForKey:@"账户"],
                                        @"bankuser":[self.dicmValue objectForKey:@"名称"],
                                        @"bankcash":_strAmount
                                        };
        [DataRequest POST_Parameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
            [DataManager save:@"" forKey:@"刷新用户信息"];
            WeakSelf
            [MessageHUG showSystemAlert:[responseObject objectForKey:@"msg"] controller:self completion:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
    }else if ([_strPayStyle isEqualToString:@"提现到银行卡"])
    {
        if (self.dicmValue.count < 4) {
            [MessageHUG showWarningAlert:@"信息不完整,请核实后在提交"];
            return;
        }
        NSString *strCardNumber = [self.dicmValue objectForKey:@"卡号"];
        if (![Tools isValidateNumber:strCardNumber]) {
            [MessageHUG showWarningAlert:@"卡号请输入纯数字"];
            return;
        }
        if (!(strCardNumber.length>=16&&strCardNumber.length<=19)) {
            [MessageHUG showWarningAlert:@"卡号位数不正确"];
            return;
        }
        NSDictionary *dicParameters = @{@"action":@"cash_bank",
                                        @"username":USERNAME,
                                        @"userpass":USERPASS,
                                        @"bankname":[self.dicmValue objectForKey:@"户行"],
                                        @"bankuser":[self.dicmValue objectForKey:@"持卡人"],
                                        @"bankcash":_strAmount,
                                        @"banktype":[self.dicmValue objectForKey:@"名称"],
                                        @"banknumber":strCardNumber,
                                        };
        [DataRequest POST_Parameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
            [DataManager save:@"" forKey:@"刷新用户信息"];
            WeakSelf
            [MessageHUG showSystemAlert:[responseObject objectForKey:@"msg"] controller:self completion:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
    }
    
    
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellMentionDetail *cell = LoadViewWithNIB(@"CellMentionDetail");
    if (cell == nil) {
        cell = [[CellMentionDetail alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellMentionDetail"];
    }
    cell.dicDetail = arrData[indexPath.row];
    WeakSelf
    cell.Block = ^(NSString *name, NSString *content) {
        IsNilString(content)?:[weakSelf.dicmValue setObject:content forKey:name];
    };
    if (indexPath.row == 0) {
        cell.isBecomeFirstResponder = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - 懒加载
-(NSMutableDictionary *)dicmValue{
    if (!_dicmValue) {
        _dicmValue = [NSMutableDictionary dictionary];
    }
    return _dicmValue;
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
