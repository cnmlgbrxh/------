//
//  PaymentMethodView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/20.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PaymentMethodView.h"

@interface PaymentMethodView ()

@property (weak, nonatomic) IBOutlet UILabel *lanAmount;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation PaymentMethodView

-(void)setStrAmount:(NSString *)strAmount{
    _strAmount = strAmount;
    _lanAmount.text = _strAmount;
    _tableView.tableFooterView = [UIView new];
    [_tableView setSeparatorColor:ColorHex(0x515151)];
}
- (IBAction)btnCloseClick:(UIButton *)sender {
    if (_BlockClose) {
        self.BlockClose();
    }
}

@end
