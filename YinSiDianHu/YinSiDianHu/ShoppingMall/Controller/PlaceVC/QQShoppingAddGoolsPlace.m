//
//  QQShoppingAddGoolsPlace.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingAddGoolsPlace.h"
#import "FYLCityPickView.h"
#import "ReactiveCocoa.h"

@interface QQShoppingAddGoolsPlace ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *placeTextField;
@property (weak, nonatomic) IBOutlet UITextField *placeDetailTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UISwitch *commenSwitch;
@property (nonatomic,strong) NSString *nameUtf8;
@property (nonatomic,strong) NSString *placeUtf8;
@property (nonatomic,strong) NSString *placeDetailUtf8;
@property(nonatomic,strong)QQShoppingAddressListModel *tempModel;
@end

@implementation QQShoppingAddGoolsPlace

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saveBtn.layer.cornerRadius = 3;
    self.saveBtn.layer.masksToBounds = YES;
    self.title = self.model?@"修改收货地址":@"添加收货地址";
    self.nameTextField.text = self.model.cname;
    self.phoneTextField.text = self.model.cphone;
    self.placeTextField.text = self.model.czone;
    self.placeDetailTextField.text = self.model.caddr;
    [self.commenSwitch setOn:[self.model.is_common isEqualToString:@"1"]?YES:NO];
    [self arcText];
    [self.commenSwitch addTarget:self action:@selector(swicthAction) forControlEvents:UIControlEventValueChanged];
}

- (void)swicthAction {
    self.model.is_common = [self.model.is_common isEqualToString:@"1"]?@"0":@"1";
}

- (void)arcText {
    WS(wSelf);
    self.tempModel = [[QQShoppingAddressListModel alloc]init];
self.tempModel.is_common = @"0";
    [[self.nameTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
        UITextField *textF = (UITextField *)x;
        wSelf.model.cname = textF.text;
        wSelf.tempModel.cname = textF.text;
    }];
    [[self.placeTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
        UITextField *textF = (UITextField *)x;
        wSelf.model.czone = textF.text;
        wSelf.tempModel.czone = textF.text;
    }];
    [[self.placeDetailTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
        UITextField *textF = (UITextField *)x;
        wSelf.model.caddr = textF.text;
        wSelf.tempModel.caddr = textF.text;
    }];
    [[self.phoneTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
        UITextField *textF = (UITextField *)x;
        wSelf.model.cphone = textF.text;
        wSelf.tempModel.cphone = textF.text;
        if (textF.text.length == 11) {
            if (![Tools isValidateMobile:textF.text] ) {
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请输入正确的手机号！"];
            }
        }
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 11) {
        if ([string isEqualToString:@""]) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)choosePlaceBtnClick:(id)sender {
    [self.view endEditing:YES];
    WS(wSelf);
    [FYLCityPickView showPickViewWithComplete:^(NSArray *arr) {
        wSelf.model.czone = [NSString stringWithFormat:@"%@%@%@",arr[0],arr[1],arr[2]];
        wSelf.tempModel.czone = [NSString stringWithFormat:@"%@%@%@",arr[0],arr[1],arr[2]];
        wSelf.placeTextField.text= [NSString stringWithFormat:@"%@%@%@",arr[0],arr[1],arr[2]];
    }];
    
}

- (IBAction)saveBtnClick:(id)sender {
    if (self.nameTextField.text.length ==0 ) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请输入姓名"];
        return;
    }
    if (self.phoneTextField.text.length ==0 || ![Tools isValidateMobile:self.phoneTextField.text]) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请输入正确的手机号"];
        return;
    }
    if (self.placeTextField.text.length ==0 ) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请选择所在地区"];
        return;
    }
    if (self.placeDetailTextField.text.length ==0 ) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请输入详细地址"];
        return;
    }
    [self setCustomStr];
    if (self.model) {
        [self editAddressRequest];
    }else{
        [self postAddressRequest];
    }
}

- (void)setCustomStr {
    [[RSMBProgressHUDTool shareProgressHUDManager] showViewLoadingHUD:self.view showText:@""];
    self.nameUtf8 =  [self.nameTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.placeUtf8 =  [self.placeTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.placeDetailUtf8 =  [self.placeDetailTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (void)editAddressRequest {
    NSString *str = [NSString stringWithFormat:@"%@username=%@&aid=%@&name=%@&phone=%@&zone=%@&addr=%@&common=%@",shopping_editAddressURL,[UserManager shareManager].userName,self.model.aid,self.nameUtf8,self.model.cphone,self.placeUtf8,self.placeDetailUtf8,self.commenSwitch.isOn?@"1":@"0"];
    WS(wSelf);
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        NSLog(@"设置默认地址 ------%@",response);
        if ([response[@"stats"] isEqualToString:@"ok"]) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"收货地址修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (wSelf.shopping_editPlaceBlock) {
                    wSelf.model.is_common = self.commenSwitch.isOn?@"1":@"0";
                    wSelf.shopping_editPlaceBlock(self.model);
                }
                [wSelf.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] hiddenHUD];
    } fail:^(NSError *error) {
        NSLog(@"设置默认地址错误 ------ %@",error);
        [[RSMBProgressHUDTool shareProgressHUDManager] hiddenHUD];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}


- (void)postAddressRequest {
    self.tempModel.is_common = self.commenSwitch.isOn?@"1":@"0";
    NSString *str = [NSString stringWithFormat:@"%@username=%@&name=%@&zone=%@&addr=%@&phone=%@&common=%@",shopping_addAddressURL,[UserManager shareManager].userName,self.nameUtf8,self.placeUtf8,self.placeDetailUtf8,self.phoneTextField.text,self.commenSwitch.isOn?@"1":@"0"];
//    NSLog(@"添加收货地址url  ----- %@",QQ_API_CON(str));
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
//        NSLog(@"添加收货地址 ------ %@",response);
        if ([response[@"stats"] isEqualToString:@"ok"]) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"收货地址添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.shopping_addPlaceBlock) {
                    self.shopping_addPlaceBlock(self.tempModel);
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
        }
    } fail:^(NSError *error) {
//        NSLog(@"添加收货地址 ------ %@",error);
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

@end
