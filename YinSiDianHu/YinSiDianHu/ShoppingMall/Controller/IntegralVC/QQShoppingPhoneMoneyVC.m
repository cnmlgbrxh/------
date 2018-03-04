//
//  QQShoppingPhoneMoneyVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingPhoneMoneyVC.h"
#import "QQChangeRecordVC.h"
#import "QQIntegralMallVC.h"

@interface QQShoppingPhoneMoneyVC ()
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation QQShoppingPhoneMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI {
    self.title = @"积分商城";
    self.nextBtn.layer.cornerRadius = 3;
    self.nextBtn.layer.masksToBounds = YES;
    self.jifenLabel.attributedText = [Tools LabelStr:@"2000分" changeStr:@"2000" color:[Tools getUIColorFromString:@"ed4044"] font:[UIFont systemFontOfSize:17]];
}

// 开启倒计时效果
-(void)openCountdown{
    __block NSInteger time = 5;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue); dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{ if(time <= 0){
        //倒计时结束，关闭
        dispatch_source_cancel(_timer); dispatch_async(dispatch_get_main_queue(), ^{
            [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal]; [self.codeBtn setTitleColor:[Tools getUIColorFromString:@"4c99e1"] forState:UIControlStateNormal]; self.codeBtn.userInteractionEnabled = YES; }); }else{ int seconds = time % 60; dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.codeBtn setTitleColor:[Tools getUIColorFromString:@"979797"] forState:UIControlStateNormal]; self.codeBtn.userInteractionEnabled = NO; }); time--; } }); dispatch_resume(_timer); }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)codeBtnClick:(id)sender {
    [self openCountdown];
}

- (IBAction)nextBtnClick:(id)sender {
    if (self.phoneTextField.text.length == 0) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请输入手机号"];
        return;
    }
    
    if (![Tools isValidateMobile:self.phoneTextField.text]) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请输入正确的手机号"];
        return;
    }
    
    if (self.codeTextField.text.length == 0) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请输入验证码"];
        return;
    }
    
    WS(wSelf);
    [QQShoppingTools showAlertControllerWithTitle:@"兑换成功，请注意话费到账信息" message:@"" confirmTitle:nil cancleTitle:@"好" vc:self confirmBlock:^{
    } cancleBlock:^{
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            if ([controller isKindOfClass:[QQIntegralMallVC class]]) {
//                QQIntegralMallVC *vc =(QQIntegralMallVC *)controller;
//                [wSelf.navigationController popToViewController:vc animated:YES];
//            }
//        }
        QQChangeRecordVC *vc = [[QQChangeRecordVC alloc]init];
        vc.toRootVC = YES;
        [wSelf.navigationController pushViewController:vc animated:YES];
    }];
}

@end
