//
//  LoginViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Check.h"
#import "TabBarController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop5;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeftTure;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;

@property (weak, nonatomic) IBOutlet UITextField *IphoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self layout];
    
    //全局配置提示信息
    [[Check check].messageConfigure setValue:@"密码为6-16位数字或字母" forKey:CheckMessagePassword];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"BackGroundVIew"].CGImage);
   
    _IphoneTF.text = USERNAME;
    _passwordTF.text = USERPASS;
}
-(void)layout{
    _layoutTop.constant = Sc(124);
    _layTop1.constant = Sc(30);
    _layTop2.constant = Sc(108);
    _layTop3.constant = Sc(26);
    _layTop4.constant = Sc(58);
    _layTop5.constant = Sc(400);
    _layLeftTure.constant = Sc(295);
    _layoutLeft.constant = Sc(127);
    _layHeight.constant = Sc(90);
    _IphoneTF.cornerRadius = Sc(5);
    _passwordTF.cornerRadius = Sc(5);
    _btnLogin.cornerRadius = Sc(5);
}
- (IBAction)btnLoginClick:(UIButton *)sender {
    if (ISIPHONE_5) {
        [MessageHUG showWarningAlert:@"您当前设备不适合此应用"];
        return;
    }
    //依次校验手机号、密码
    [Check checkWith:^(Check *check) {
        check.textField(_IphoneTF).name(@"手机号").null().validate(CheckRegularPhone, nil);
        check.textField(_passwordTF).name(@"密码").null().validate(CheckRegularPassword, nil).END;
        
    } completion:^(CheckResult result, NSString *message, UITextField *textField) {
        if (result == CheckResultUnValidated || result == CheckResultNull)
        {
            [MessageHUG showWarningAlert:message];
        }else if (result == CheckResultSuccess)
        {
            
            [SAMKeychain setPassword:_passwordTF.text forService:BundleId account:_IphoneTF.text];
            USERDEFAULT_setObject(_IphoneTF.text, @"username");
            USERDEFAULT_setObject(@"super", @"level");
            [MessageHUG restoreTabbarViewController];
            
//            NSDictionary *dicParameters = @{
//                                            @"action":@"login",
//                                            @"username":_IphoneTF.text,
//                                            @"userpass":_passwordTF.text,
//                                            @"version":APP_VERSION
//                                            };
//            [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSLog(@"responseObject:%@",responseObject);
//                if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"])
//                {
//                    [SAMKeychain setPassword:_passwordTF.text forService:BundleId account:_IphoneTF.text];
//                    [UserManager userInfoManager:responseObject];
//                    [MessageHUG restoreTabbarViewController];
//                }else{
//                    [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"]];
//                }
//                
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                [[self.view viewWithTag:66666] removeFromSuperview];
//            }];
        }
    }];
    
    
}
- (IBAction)goRegister:(UIButton *)sender {
    if (ISIPHONE_5) {
        [MessageHUG showWarningAlert:@"您当前设备不适合此应用"];
        return;
    }
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self presentViewController:registerVC animated:NO completion:^{
        
    }];
}
- (IBAction)btnForgotPassword:(UIButton *)sender {
    if ([Tools isValidateMobile:_IphoneTF.text])
    {
        NSDictionary *dicParameters = @{@"action":@"getpwd",
                                        @"username":_IphoneTF.text
                                        };
        [DataRequest POST_Parameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
            [MessageHUG showSuccessAlert:[responseObject objectForKey:@"msg"]];
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[self.view viewWithTag:66666] removeFromSuperview];
        }];
    }else
    {
        [MessageHUG showWarningAlert:@"手机号码有误"];
    }
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:_IphoneTF]&&_IphoneTF.isEditing) {
        _passwordTF.text = @"";
    }
    if (range.location>=11&&[textField isEqual:_IphoneTF]) {
        return NO;
    }else if (range.location>=18&&[textField isEqual:_passwordTF]){
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 100) {
        UITextField *tFPassWord = [self.view viewWithTag:101];
        [tFPassWord becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // 移除第一响应者
    [super touchesEnded:touches withEvent:event];
    
    [self.view endEditing:YES];
    
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
