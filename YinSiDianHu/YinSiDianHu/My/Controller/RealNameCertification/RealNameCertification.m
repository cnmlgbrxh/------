//
//  RealNameCertification.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "RealNameCertification.h"
#import "IDCardViewController.h"
@interface RealNameCertification ()

@property (weak, nonatomic) IBOutlet UITextField *tfRealName;
@property (weak, nonatomic) IBOutlet UITextField *tfCertification;

@end

@implementation RealNameCertification

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (IBAction)goCertification:(UIButton *)sender {
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"实名认证未通过" message:@"失败原因:证件信息与提交信息不符(有效期)或者证件整体模糊不符合上传规格。" preferredStyle:UIAlertControllerStyleAlert];
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"重新认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alertController addAction:defaultAction];
//    }
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
//    [alertController addAction:cancelAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    
//    if (_tfRealName.text.length == 0) {
//        [MessageHUG showAlert:@"请输入真实姓名" showAddedTo:self.view];
//        return;
//    }
//    if (![Tools isValidateId:_tfCertification.text]) {
//        [MessageHUG showAlert:@"身份证格式有误" showAddedTo:self.view];
//        return;
//    }
    
    //认证信息完成显示使用
    USERDEFAULT_setObject(_tfRealName.text, @"真实姓名");
    USERDEFAULT_setObject(_tfCertification.text, @"身份证号");
    IDCardViewController *iDCardViewController = [[IDCardViewController alloc] init];
    iDCardViewController.navTitle = @"实名认证";
    [self.navigationController pushViewController:iDCardViewController animated:YES];
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
