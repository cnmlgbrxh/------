//
//  CallViewController.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CallViewController.h"
#import "LJContactManager.h"
#import "CallView.h"
#import "ContactsList.h"

@interface CallViewController ()


@end

@implementation CallViewController{
    CallView *callView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    
    [self loadData];
    
    [self loadUI];

}
-(void)loadData{
    
    ContactsList *list = [[ContactsList alloc]init];
    //获得通讯录，存储数据库
    [[LJContactManager sharedInstance] accessContactsComplection:^(BOOL succeed, NSArray *datas) {
        if ([list deleteAllData]) {
            if ([list insertContacts:datas]) {
                callView.arrContactsSave = datas;
            }
        }
    }];
}
#pragma mark - 判断键盘是否需要显示
-(void)setIsPhoneKeypad:(BOOL)isPhoneKeypad{
    _isPhoneKeypad = isPhoneKeypad;
    
    if (_isPhoneKeypad) {
        callView.strIsPhoneKeypad = @"动画隐藏";
    }else{
        callView.strIsPhoneKeypad = @"动画显示";
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    callView.strIsPhoneKeypad = @"显示";
}
#pragma mark - 创建UI
-(void)loadUI{
    if (!callView) {
        callView = [[CallView alloc]initWithFrame:self.view.frame];
    }
    callView.viewController = self;
    [self.view addSubview:callView];
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
