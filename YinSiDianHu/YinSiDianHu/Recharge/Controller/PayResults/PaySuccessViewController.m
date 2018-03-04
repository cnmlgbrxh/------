//
//  PaySuccessViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/27.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PaySuccessViewController.h"

@interface PaySuccessViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableAttributedString *attriLevel = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您已成功支付%@元",_strAmount]];
    //[attriLevel addAttribute:NSForegroundColorAttributeName value:ColorHex(0x444444) range:NSMakeRange(0, attriLevel.length-4)];
    [attriLevel addAttribute:NSForegroundColorAttributeName value:ColorHex(0xE17706) range:NSMakeRange(6, _strAmount.length)];
    _lab.attributedText = attriLevel;
}
-(void)setStrAmount:(NSString *)strAmount{
    _strAmount = strAmount;
}
- (IBAction)confirm:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
