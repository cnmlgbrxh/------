//
//  ModifyPasswordSecondViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ModifyPasswordSecondViewController.h"
#import "Check.h"
@interface ModifyPasswordSecondViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;

@property (weak, nonatomic) IBOutlet UITextField *textF_OldPassWord;

@property (weak, nonatomic) IBOutlet UITextField *textF_FirstPassWord;

@property (weak, nonatomic) IBOutlet UITextField *textF_SecondPassWord;

@end

@implementation ModifyPasswordSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layout];
}
-(void)layout{
    _layTop.constant = Sc(60);
    _layLeft.constant = Sc(123);
    _layHeight.constant = Sc(90);
}
- (IBAction)determiningModifications:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if ([_textF_OldPassWord.text isEqualToString:USERPASS]) {
        [Check checkWith:^(Check *check) {
            check.textField(_textF_FirstPassWord).name(@"新密码").null().validate(CheckRegularPassword, nil).END;
        } completion:^(CheckResult result, NSString *message, UITextField *textField) {
            if (result == CheckResultUnValidated || result == CheckResultNull)
            {
                [MessageHUG showWarningAlert:message];
            }else if (result == CheckResultSuccess)
            {
                if ([_textF_FirstPassWord.text isEqualToString:_textF_SecondPassWord.text]) {
                    NSDictionary *dicParameters = @{@"action":@"editpass",
                                                    @"username":USERNAME,
                                                    @"userpass":USERPASS,
                                                    @"oldpass":USERPASS,
                                                    @"newpass":_textF_SecondPassWord.text
                                                    };
                    [DataRequest POST_Parameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
                
                        if ([SAMKeychain deletePasswordForService:BundleId account:USERNAME])
                        {
                            [MessageHUG showSystemAlert:@"修改密码成功,稍后请从新登录" controller:self completion:^{
                                [MessageHUG restoreLoginViewController];
                            }];
                        }
                        
                    }];
                }else
                {
                    [MessageHUG showWarningAlert:@"两次密码不一致"];
                }
            }
        }];
    }else{
        [MessageHUG showWarningAlert:@"密码输入错误"];
    }
    
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location>=18){
        return NO;
    }
    return YES;
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
