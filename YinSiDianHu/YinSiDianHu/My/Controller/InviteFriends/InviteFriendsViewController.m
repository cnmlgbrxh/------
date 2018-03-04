//
//  InviteFriendsViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/27.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "InviteFriendsViewController.h"
#import "MentionViewController.h"
#import <UMSocialCore/UMSocialCore.h>//分享
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
@interface InviteFriendsViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutCodeX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layBtnWidth;

@property (weak, nonatomic) IBOutlet UILabel *labCode;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnPYQ;
@property (weak, nonatomic) IBOutlet UIButton *btnWXHY;
@property (weak, nonatomic) IBOutlet UIButton *btnQQHY;
@property (weak, nonatomic) IBOutlet UIButton *btnQQKJ;



@end

@implementation InviteFriendsViewController{
    UMSocialPlatformType shareType;
    NSString *strCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (![QQApiInterface isQQInstalled]&&![QQApiInterface isQQSupportApi]) {
        _btnQQHY.hidden = YES;
        _btnQQKJ.hidden = YES;
        _layBtnWidth.constant = SCREEN_W/4;
    }
    
    if (![WXApi isWXAppInstalled]&&![WXApi isWXAppSupportApi]) {
        _btnPYQ.hidden = YES;
        _btnWXHY.hidden = YES;
        _layBtnWidth.constant = SCREEN_W/4;
    }
    
    UILongPressGestureRecognizer
    *longPressGes = [[UILongPressGestureRecognizer
 alloc]initWithTarget:self action:@selector(longPressGes:)];
    [_labCode addGestureRecognizer:longPressGes];
    
    [self layout];
    
    [self loadData];
    
}
-(void)loadData{
    NSDictionary *dicParameters = @{@"action":@"checkdistr",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS
                                    };
    [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject)
     {
         strCode = [responseObject objectForKey:@"numb"];
         _labCode.text = [NSString stringWithFormat:@"%@ (长按可复制)",strCode];
         NSString *count = [responseObject objectForKey:@"count"];
         NSString *price = [_dicDetail objectForKey:@"commission"];
         NSMutableAttributedString *attriLevel = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您已邀请%@位好友,共获得奖励佣金%@元",count,price]];
         [attriLevel addAttribute:NSForegroundColorAttributeName value:ColorHex(0xff4936) range:NSMakeRange(4, count.length)];
         [attriLevel addAttribute:NSForegroundColorAttributeName value:ColorHex(0xff4936) range:NSMakeRange(attriLevel.length-1-price.length, price.length)];
         _labPrice.attributedText = attriLevel;
         
         //         if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"])
         //         {
         //
         //         }else if ([[responseObject objectForKey:@"stats"] isEqualToString:@"errorlogin"])
         //         {
         //             [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"] animateWithDuration:3.5 completion:^{
         //                 [MessageHUG restoreLoginViewController];
         //             }];
         //         }else
         //         {
         //             [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"]];
         //         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [[self.view viewWithTag:666666] removeFromSuperview];
     }];
}
-(void)layout{
    _layTop.constant = Sc(60);
    _layLeft.constant = Sc(123);
    _layHeight.constant = Sc(90);
    
    if (ISIPHONE_6){
        _layoutWidth.constant = 58;
    }else if (ISIPHONE_6P){
        _layoutWidth.constant = 75;
        _layoutCodeX.constant = -12;
    }
}
#pragma mark - 点击手势进入此方法
-(void)longPressGes:(UITapGestureRecognizer *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:strCode];
    [MessageHUG showSystemAlert:@"推广码已成功复制!" controller:self completion:nil];
}

-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
}
- (IBAction)shareClick:(UIButton *)sender {
    
    if ([sender.currentTitle isEqualToString:@"朋友圈"])
    {
        if (![WXApi isWXAppInstalled]&&![WXApi isWXAppSupportApi]) {
            [MessageHUG showWarningAlert:@"未安装微信或者版本过低,请安装后再试"];
        }
        shareType = UMSocialPlatformType_WechatTimeLine;
    }else if ([sender.currentTitle isEqualToString:@"微信好友"])
    {
        if (![WXApi isWXAppInstalled]&&![WXApi isWXAppSupportApi]) {
            [MessageHUG showWarningAlert:@"未安装微信或者版本过低,请安装后再试"];
        }
        shareType = UMSocialPlatformType_WechatSession;
    }else if ([sender.currentTitle isEqualToString:@"QQ好友"])
    {
        if (![QQApiInterface isQQInstalled]&&![QQApiInterface isQQSupportApi]) {
            [MessageHUG showWarningAlert:@"未安装QQ或者版本过低,请安装后再试"];
        }
        shareType = UMSocialPlatformType_QQ;
    }else if ([sender.currentTitle isEqualToString:@"QQ空间"])
    {
        if (![QQApiInterface isQQInstalled]&&![QQApiInterface isQQSupportApi]) {
            [MessageHUG showWarningAlert:@"未安装QQ或者版本过低,请安装后再试"];
        }
        shareType = UMSocialPlatformType_Qzone;
    }
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"奇趣电话" descr:@"随时随地拨打电话,免费畅聊" thumImage:[UIImage imageNamed:@"logo"]];
    //设置网页地址
    NSString *str = [NSString stringWithFormat:@"share.php?username=%@",USERNAME];
    URL_HEADER(str);
    shareObject.webpageUrl = URL_HEADER(str);
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:shareType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            [MessageHUG showSuccessAlert:@"分享成功"];
        }
    }];
    
}
- (IBAction)mention:(UIButton *)sender {
    MentionViewController *mentionVC = [[MentionViewController alloc] init];
    mentionVC.dicDetail = _dicDetail;
    [self.navigationController pushViewController:mentionVC animated:YES];
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
