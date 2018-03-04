//
//  LevelQueryViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "LevelQueryViewController.h"
#import <HYBNetworking/HYBNetworking.h>

@interface LevelQueryViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;


@property (weak, nonatomic) IBOutlet UITextField *textF_Number;

@property (weak, nonatomic) IBOutlet UILabel *labAlertMessage;

@end

@implementation LevelQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_textF_Number becomeFirstResponder];
    
    [self layout];
    
    [self setUpLabAlert:@"如果您设置失败可以点击查询按钮，来查询该号码所需要的级别。"];
}
-(void)layout{
    _layTop.constant = Sc(40);
    _layTop1.constant = Sc(40);
    _layBottom.constant = Sc(40);
    _layLeft.constant = Sc(60);
    _layRight.constant = Sc(60);
    _layHeight.constant = Sc(90);
}

- (IBAction)goSetUp:(UIButton *)sender {
    if ([self isSuccess]) {
        [self isChargeRequest];
    }
    
}
//是否收费
- (void)isChargeRequest {
    NSDictionary *dicParameters = @{@"action":@"setcall",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS,
                                    @"callerid":_textF_Number.text
                                    };
    [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject objectForKey:@"stats"]) {
            [self setUpLabAlert:[responseObject objectForKey:@"msg"]];
            return ;
        }
        if ([Tools isValidateNumber:[responseObject objectForKey:@"data"]]) {
            [MessageHUG showSystemAllAlert:[NSString stringWithFormat:@"设置此号码需要扣除余额%@元",[responseObject objectForKey:@"data"]] controller:self completion:^{
                [self setUpNumber];
            }];
        }else{
            [MessageHUG showSystemAllAlert:[responseObject objectForKey:@"data"] controller:self completion:^{
                [self setUpNumber];
            }];
        }
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[self.view viewWithTag:666666] removeFromSuperview];
    }];
}
-(void)setUpNumber{
    NSDictionary *dicParameters = @{@"action":@"setcallerid",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS,
                                    @"callerid":_textF_Number.text
                                    };
    [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"]){
            [MessageHUG showSystemAlert:[responseObject objectForKey:@"msg"] controller:self completion:^{
                WeakSelf
                [DataManager save:@"" forKey:@"刷新用户信息"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }else if ([[responseObject objectForKey:@"stats"] isEqualToString:@"errorlogin"])
        {
            [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"] animateWithDuration:4.5 completion:^{
                [MessageHUG restoreLoginViewController];
            }];
            
        }else
        {
            [self setUpLabAlert:[responseObject objectForKey:@"msg"]];
        }
        
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[self.view viewWithTag:666666] removeFromSuperview];
    }];

}
- (IBAction)levelQuery:(UIButton *)sender {
    if ([self isSuccess]){
        NSDictionary *dicParameters = @{@"action":@"checkphone",
                                        @"username":USERNAME,
                                        @"userpass":USERPASS,
                                        @"phone":_textF_Number.text
                                        };
        [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
            [self setUpLabAlert:[responseObject objectForKey:@"msg"]];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[self.view viewWithTag:666666] removeFromSuperview];
        }];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location>=18)
    {
        return NO;
    }
    return YES;
}
-(BOOL)isSuccess{
    [self.view endEditing:YES];
    
    if (![Tools isValidateNumber:_textF_Number.text]) {
        [self setUpLabAlert:@"请输入纯数字"];
        return NO;
    }
    
    if (_textF_Number.text.length>=11&&_textF_Number.text.length<=18) {
        return YES;
    }else{
        [self setUpLabAlert:@"需要11-18位数字"];
        return NO;
    }
}
-(void)setUpLabAlert:(NSString *)_strAlert{
    // 用label的attributedText属性来使用富文本
    _labAlertMessage.attributedText = [Tools setUpAlertMessage:_strAlert];
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
