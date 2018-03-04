//
//  HelpFeedbackViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "HelpFeedbackViewController.h"
#import "PlaceholderTextView.h"
@interface HelpFeedbackViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *text_Iphone;
@property (weak, nonatomic) IBOutlet UITextField *textF_QQ;


@end

@implementation HelpFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textView.placeholder = @"请输入您对我们的宝贵意见";
    self.textView.placeholderColor = ColorHex(0x919191);
    [self.textView becomeFirstResponder];
    
}
-(void)layout{
    _layTop.constant = Sc(64);
    _layTop1.constant = Sc(64);
    _layLeft.constant = Sc(123);
    _layHeight.constant = Sc(90);
    _layoutWidth.constant = Scale(13);
}
- (IBAction)commit:(UIButton *)sender {
    if (_textView.text.length==0||[Tools isEmpty:_textView.text]) {
        [MessageHUG showWarningAlert:@"请输入反馈内容"];
        return;
    }else if (![Tools isValidateMobile:_text_Iphone.text])
    {
        [MessageHUG showWarningAlert:@"手机号码有误"];
        return;
    }
    if (![Tools isValidateNumber:_textF_QQ.text]&&_textF_QQ.text.length>0) {
        [MessageHUG showWarningAlert:@"QQ号码有误"];
        return;
    }
    NSDictionary *dicParameters = @{@"action":@"countus",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS,
                                    @"ans":_textView.text,
                                    @"qq":_textF_QQ.text,
                                    @"phone":_text_Iphone.text
                                    };
    [DataRequest POST_Parameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
        WeakSelf;
        [MessageHUG showSystemAlert:[responseObject objectForKey:@"msg"] controller:self completion:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location>=11&&[textField isEqual:_text_Iphone]) {
        return NO;
    }
    return YES;
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
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
