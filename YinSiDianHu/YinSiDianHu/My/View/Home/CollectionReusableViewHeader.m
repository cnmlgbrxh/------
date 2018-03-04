//
//  CollectionReusableViewHeader.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CollectionReusableViewHeader.h"
#import "RealNameCertification.h"
#import "MentionViewController.h"
#import "RechargeViewController.h"
#import "UIButton+Button.h"
#import "MyView.h"
@interface CollectionReusableViewHeader ()

@property (weak, nonatomic) IBOutlet UILabel *labName;

@property (weak, nonatomic) IBOutlet UILabel *labCertification;

@property (weak, nonatomic) IBOutlet UILabel *labLevel;

@property (weak, nonatomic) IBOutlet UIImageView *imageVCertification;

@property (weak, nonatomic) IBOutlet UILabel *labAllAmount;

@property (weak, nonatomic) IBOutlet UILabel *labYongJin;

@property (weak, nonatomic) IBOutlet UILabel *labZengYi;
@property (weak, nonatomic) IBOutlet UILabel *labZengYiSubtitle;

@property (weak, nonatomic) IBOutlet UILabel *labYuE;

@property (weak, nonatomic) IBOutlet UIButton *btnNumber;

@property (weak, nonatomic) IBOutlet UIButton *btnVoice;

@property (weak, nonatomic) IBOutlet UIButton *btnDiamond;

@property (weak, nonatomic) IBOutlet UIButton *btnTime;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UISwitch *switchbtn;

@end
@implementation CollectionReusableViewHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    if (![USERMANAGER.level isEqualToString:@"super"]) {
//        _labZengYi.hidden = YES;
//        _labZengYiSubtitle.hidden = YES;
//    }
    
    [_switchbtn setOn:USERMANAGER.isEnhancedCall animated:NO];
    
    _labName.text = USERNAME;
    
    _labLevel.layer.cornerRadius = _labLevel.height/2;
    _labLevel.layer.masksToBounds = YES;
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
    /*
     bindphone = 13278013588;
     callerid = 13278013588;
     capital = "0.00";
     commission = "0.00";//y
     didcall = 01053502051;
     earnings = "0.00";
     guoqi = "2022-07-28";
     money = "15880.00";
     msg = "\U767b\U5f55\U6210\U529f";
     point = "16760.00";
     stats = ok;
     userlevel = "\U94bb\U77f3\U4f1a\U5458";
     username = 13278013588;
     uservoice = "\U539f\U58f0\U97f3";
     */
    if (_dicDetail == nil) {
        return;
    }
    _labLevel.text = [_dicDetail objForKey:@"userlevel"];
    
    NSString *strAllmoney = [NSString stringWithFormat:@"%@",[_dicDetail objForKey:@"allmoney"]];
    NSMutableAttributedString *attriPrice =     [[NSMutableAttributedString alloc] initWithString:strAllmoney];
    [attriPrice addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:38] range:NSMakeRange(0, attriPrice.length-1)];
    [attriPrice addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriPrice.length-2, 2)];
    _labAllAmount.attributedText = attriPrice;
    
    _labYongJin.text = [_dicDetail objForKey:@"commission"];
    _labZengYi.text = [_dicDetail objForKey:@"earnings"];
    _labYuE.text = [_dicDetail objForKey:@"usermoney"];
    
    if (IsNilString([_dicDetail objForKey:@"callerid"])) {
        [_btnNumber setTitle:@"随机号码" forState:UIControlStateNormal];
    }else{
        
        [_btnNumber setTitle:[_dicDetail objForKey:@"callerid"] forState:UIControlStateNormal];
    }
    [_btnNumber centerImageAndTitle:10];
    
    [_btnVoice setTitle:[_dicDetail objForKey:@"uservoice"] forState:UIControlStateNormal];
    [_btnVoice centerImageAndTitle:10];
    
    [_btnDiamond setTitle:[_dicDetail objForKey:@"rate_group"] forState:UIControlStateNormal];
    [_btnDiamond centerImageAndTitle:10];
    
    [_btnTime setTitle:[NSString stringWithFormat:@"至%@",[_dicDetail objForKey:@"guoqi"]] forState:UIControlStateNormal];
    [_btnTime centerImageAndTitle:10];
//    self.switchbtn = 
}
- (IBAction)btnNumberClick:(UIButton *)sender {
    MyView *myView = [[MyView alloc] init];
    [myView setUpShowNumber:_viewController alertAddedTo:self];
}
- (IBAction)btnVoiceClick:(UIButton *)sender {
    MyView *myView = [[MyView alloc] init];
    [myView setUpCallTone:_viewController alertAddedTo:self];
}
- (IBAction)btnDiamondClick:(UIButton *)sender {
    [self RechargeClick:nil];
}
- (IBAction)btnTimeClick:(UIButton *)sender {
    [self RechargeClick:nil];
}

#pragma mark - 实名认证
- (IBAction)RealNameCertificationClick:(UIButton *)sender {
    //[MessageHUG showWarningAlert:@"暂未开放,敬请期待哦~"];
    RealNameCertification *realNameCertification = [[RealNameCertification alloc]init];
    realNameCertification.navTitle = @"实名认证";
    [_viewController.navigationController pushViewController:realNameCertification animated:YES];
}
#pragma mark - 充值
- (IBAction)RechargeClick:(UIButton *)sender {
    RechargeViewController *rechargeVC = [[RechargeViewController alloc]init];
    rechargeVC.navTitle = @"充值";
    [_viewController.navigationController pushViewController:rechargeVC animated:YES];
}
#pragma mark - 提现
- (IBAction)PresentClick:(UIButton *)sender {
    MentionViewController *mentionVC = [[MentionViewController alloc] init];
    mentionVC.dicDetail = _dicDetail;
    [_viewController.navigationController pushViewController:mentionVC animated:YES];
}
#pragma mark - 是否开启增强呼叫
- (IBAction)switchAction:(UISwitch *)sender {
    sender.enabled = NO;
    NSDictionary *dicParameters = @{@"action":@"checkcall",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS
                                    };
    [DataRequest POST_TParameters:dicParameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         sender.enabled = YES;
         if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"])
         {
             USERMANAGER.isEnhancedCall = sender.isOn;
         }else if ([[responseObject objectForKey:@"stats"] isEqualToString:@"errorlogin"])
         {
             [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"] animateWithDuration:4.5 completion:^{
                 [MessageHUG restoreLoginViewController];
             }];
         }else
         {
             [sender setOn:!sender.isOn];
             USERMANAGER.isEnhancedCall = NO;
             [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"]];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         sender.enabled = YES;
         [sender setOn:!sender.isOn];
         [[self viewWithTag:66666] removeFromSuperview];
     }];
}

@end
