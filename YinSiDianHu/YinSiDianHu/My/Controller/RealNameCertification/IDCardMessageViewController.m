//
//  IDCardMessageViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "IDCardMessageViewController.h"

@interface IDCardMessageViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop2;

@property (weak, nonatomic) IBOutlet UILabel *labName;

@property (weak, nonatomic) IBOutlet UILabel *labID;

@end

@implementation IDCardMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self layout];
    
    _labName.text = USERDEFAULT_object(@"真实姓名");
    _labID.text = USERDEFAULT_object(@"身份证号");
    
    [USERDEFAULT removeObjectForKey:@"真实姓名"];
    [USERDEFAULT removeObjectForKey:@"身份证号"];
}
-(void)layout{
    _layTop.constant = Sc(20);
    _layTop1.constant = Sc(22);
    _layTop2.constant = Sc(22);
}

- (IBAction)complete:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
