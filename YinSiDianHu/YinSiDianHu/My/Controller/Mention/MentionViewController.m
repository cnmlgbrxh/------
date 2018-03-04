//
//  MentionViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "MentionViewController.h"
#import "CellPayWay.h"
#import "MentionDetailViewController.h"
@interface MentionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFAmount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIView *footView;
@end

@implementation MentionViewController{
    NSArray *arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"提现";
    arrData = @[@"支付宝",@"银行卡"];
    
    [_textFAmount becomeFirstResponder];
    _textFAmount.placeholder = [NSString stringWithFormat:@"当前可提现%@元",[_dicDetail objectForKey:@"commission"]];
    
    if (ISIPHONE_6) {
        _layoutWidth.constant = 92;
    }else if (ISIPHONE_6P){
        _layoutWidth.constant = 110;
    }
    
    self.tableView.tableFooterView = self.footView;
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
}
#pragma mark - 全额Action
- (IBAction)btnAllAmountClick:(UIButton *)sender {
    _textFAmount.text = [NSString stringWithFormat:@"%ld",[[_dicDetail objectForKey:@"commission"] integerValue]];
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_textFAmount.text.length == 0 && [[_dicDetail objectForKey:@"commission"]isEqualToString:@"0.00"]) {
        [MessageHUG showWarningAlert:@"暂无可提现金额哦~"];
        return;
    } 
    
    if (![Tools isValidateNumber:_textFAmount.text])
    {
        [MessageHUG showWarningAlert:@"请输入纯数字"];
        return;
    }
    
    if ([_textFAmount.text integerValue]>[[_dicDetail objectForKey:@"commission"] integerValue])
    {
        [MessageHUG showWarningAlert:@"您提现金额超过可提现额度"];
        return;
    }
    
    if ([_textFAmount.text integerValue]>=100) {
        MentionDetailViewController *mentionDetailVC = [[MentionDetailViewController alloc] init];
        mentionDetailVC.strPayStyle = arrData[indexPath.row];
        mentionDetailVC.strAmount = _textFAmount.text;
        [self.navigationController pushViewController:mentionDetailVC animated:YES];
    }else{
        [MessageHUG showWarningAlert:@"提现金额不得少于100元"];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000000000001;
}
#pragma mark 自定组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = [NSString stringWithFormat:@"   %@", @"提现方式"];
    lab.textColor = ColorHex(0xb1b1b1);
    lab.font = [UIFont systemFontOfSize:15];
    lab.backgroundColor = HOMECOLOR;
    return lab;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellPayWay *cell = LoadViewWithNIB(@"CellPayWay");
    if (cell == nil) {
        cell = [[CellPayWay alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellPayWay"];
    }
    cell.strMention = arrData[indexPath.row];
    return cell;
}

- (UIView *)footView {
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_W, 50)];
        _footView.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 13, 13)];
        imageView.image= QQIMAGE(@"提示");
        [_footView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.x+imageView.width+5, 10, 200, 13)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [Tools getUIColorFromString:@"858585"];
        label.text = @"提现金额仅限于佣金。";
        [_footView addSubview:label];
    }
    return _footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
