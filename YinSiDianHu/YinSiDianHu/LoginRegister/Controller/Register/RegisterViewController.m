//
//  RegisterViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "RegisterViewController.h"
#import "Check.h"
#import "DeleagteViewController.h"
#import "NavigationViewController.h"
@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop6;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop7;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop8;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeftTure;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutCodeWidth;

@property (weak, nonatomic) IBOutlet UITextField *IphoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *promotionTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@end

@implementation RegisterViewController{
    BOOL isDidRead;
    AFNetworkReachabilityStatus netStatus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self layout];
    
    if (ISIPHONE_6) {
        _layoutCodeWidth.constant = 82.5;
    }else if (ISIPHONE_6P){
        
    }
    
    isDidRead = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"BackGroundVIew"].CGImage);
    //网络监测
    [DataRequest networkStatus:^(AFNetworkReachabilityStatus status) {
        netStatus = status;
    }];
}
-(void)layout{
    _layoutTop.constant = Sc(124);
    _layTop1.constant = Sc(24);
    _layTop2.constant = Sc(60);
    _layTop3.constant = Sc(26);
    _layTop4.constant = Sc(26);
    _layTop5.constant = Sc(26);
    _layTop6.constant = Sc(38);
    _layTop7.constant = Sc(38);
    _layTop8.constant = Sc(182);
    
    _layLeftTure.constant = Sc(295);
    _layoutLeft.constant = Sc(127);
    _layHeight.constant = Sc(90);
    _layoutCodeWidth.constant =Sc(185);
    
    _IphoneTF.cornerRadius = Sc(5);
    _passWordTF.cornerRadius = Sc(5);
    _promotionTF.cornerRadius = Sc(5);
    _codeTF.cornerRadius = Sc(5);
    _btnCode.cornerRadius = Sc(5);
    _btnRegister.cornerRadius =Sc(5);
    
}
- (IBAction)didSelectRead:(UIButton *)sender {
    if (sender.isSelected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    isDidRead = sender.selected;
}
- (IBAction)getCode:(UIButton *)sender {
    //[Tools md5:[Tools md5:@"ystel_dc"]]
    
    [Check checkWith:^(Check *check) {
        check.textField(_IphoneTF).name(@"手机号").null().validate(CheckRegularPhone, nil);
        check.textField(_passWordTF).name(@"密码").null().validate(CheckRegularPassword, nil).END;
    } completion:^(CheckResult result, NSString *message, UITextField *textField) {
        if (result == CheckResultUnValidated || result == CheckResultNull)
        {
            [MessageHUG showWarningAlert:message];
        }else if (result == CheckResultSuccess)
        {
            NSDictionary *dic = @{@"action":@"regsms",@"username":_IphoneTF.text,@"system":@"794b324d9557791471ea054f0624939f"};
            
            [DataRequest POST_Parameters:dic showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
                [MessageHUG showSuccessAlert:[responseObject objectForKey:@"msg"]];
                
                __block NSInteger time = 59; //倒计时时间
                
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                
                dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                
                dispatch_source_set_event_handler(_timer, ^{
                    
                    if(time <= 0){ //倒计时结束，关闭
                        
                        dispatch_source_cancel(_timer);
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            //设置按钮的样式
                            [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                            sender.enabled = YES;
                        });
                        
                    }else{
                        
                        int seconds = time % 60;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            //设置按钮显示读秒效果
                            [sender setTitle:[NSString stringWithFormat:@"剩余(%.2d)", seconds] forState:UIControlStateNormal];
                            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                            sender.enabled = NO;
                        });
                        time--;
                    }
                });
                dispatch_resume(_timer);
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                sender.enabled = YES;
                [[self.view viewWithTag:66666] removeFromSuperview];
            }];
        }
    }];
    
}
- (IBAction)btnRegisterClick:(UIButton *)sender {
    
    [Check checkWith:^(Check *check) {
        check.textField(_IphoneTF).name(@"手机号").null().validate(CheckRegularPhone, nil);
        check.textField(_passWordTF).name(@"密码").null().validate(CheckRegularPassword, nil);
        check.textField(_codeTF).name(@"验证码").null().validate(CheckRegularCaptcha, nil).END;
    } completion:^(CheckResult result, NSString *message, UITextField *textField) {
        if (result == CheckResultUnValidated || result == CheckResultNull)
        {
            [MessageHUG showWarningAlert:message];
        }else if (result == CheckResultSuccess)
        {
            if (isDidRead)
            {
                //注册
                sender.enabled = NO;
                NSDictionary *dic = @{@"action":@"reg",@"username":_IphoneTF.text,@"userpass":_passWordTF.text,@"vericode":_codeTF.text,@"imei":@"123456",@"userdistr":_promotionTF.text,@"union":@"qqtel",@"version":APP_VERSION};
                
                [DataRequest POST_Parameters:dic showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"%@",responseObject);
                    //登录
                    NSDictionary *dicParameters = @{
                                                    @"action":@"login",
                                                    @"username":_IphoneTF.text,
                                                    @"userpass":_passWordTF.text,
                                                    @"version":APP_VERSION
                                                    };
                    [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject)
                    {
                        if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"])
                        {
                            [SAMKeychain setPassword:_passWordTF.text forService:BundleId account:_IphoneTF.text];
                            [UserManager userInfoManager:responseObject];
                            [MessageHUG restoreTabbarViewController];
                        }else{
                            [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"]];
                        }
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        [[self.view viewWithTag:66666] removeFromSuperview];
                    }];
                }failure:^(NSURLSessionDataTask *task, NSError *error)
                {
                    sender.enabled = YES;
                    [[self.view viewWithTag:66666] removeFromSuperview];
                }];
            }else
            {
                [MessageHUG showWarningAlert:@"请确认阅读协议"];
            }
        }
    }];
    
    
    
}
- (IBAction)goLogin:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location>=11&&[textField isEqual:_IphoneTF]) {
        return NO;
    }else if (range.location>=18&&[textField isEqual:_passWordTF]){
        return NO;
    }else if (range.location>=8&&[textField isEqual:_promotionTF]){
        return NO;
    }else if (range.location>=6&&[textField isEqual:_codeTF]){
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 101){
        UITextField *tFPassWord = [self.view viewWithTag:102];
        [tFPassWord becomeFirstResponder];
    }
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // 移除第一响应者
    [super touchesEnded:touches withEvent:event];
    
    [self.view endEditing:YES];
}
- (IBAction)readDeleagte:(UIButton *)sender {
    if (netStatus == AFNetworkReachabilityStatusNotReachable) {
        [MessageHUG showWarningAlert:@"没有网络,无法查看!"];
        return;
    }
    DeleagteViewController *load = [[DeleagteViewController alloc]init];
    load.strUrl = @"reg.php";
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:load];
    [self presentViewController:nav animated:NO completion:nil];
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
