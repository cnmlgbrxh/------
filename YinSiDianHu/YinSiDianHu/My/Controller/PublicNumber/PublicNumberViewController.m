//
//  PublicNumberViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/27.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PublicNumberViewController.h"
#import "WXApi.h"
@interface PublicNumberViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeft;

@end

@implementation PublicNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self layout];
}
-(void)layout{
    _layTop.constant = Sc(40);
    _layTop1.constant = Sc(18);
    _layTop2.constant = Sc(44);
    _layTop3.constant = Sc(80);
    _layLeft.constant = Sc(123);
    _layHeight.constant = Sc(90);
    _layoutLeft.constant = Sc(70);
}
- (IBAction)iKnow:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:@"奇趣电话"];
    
    NSURL * wechat_url = [NSURL URLWithString:@"weixin://"];
    if ([[UIApplication sharedApplication] canOpenURL:wechat_url]) {
        NSLog(@"canOpenURL");
        [[UIApplication sharedApplication] openURL:wechat_url];
    } else {
        [MessageHUG showWarningAlert:@"未安装微信"];
    }
    
//    // 跳到微信
//    if ([WXApi isWXAppInstalled]) {
//        JumpToBizProfileReq *req = [[JumpToBizProfileReq alloc]init];
//        req.username = @"gh_f0a0b26bc6a9";
//        req.extMsg = @"";
//        req.profileType =0;
//        [WXApi sendReq:req];
//    } else {
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    [pasteboard setString:@"123"];
//    }
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
