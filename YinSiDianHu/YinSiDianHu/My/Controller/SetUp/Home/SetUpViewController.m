//
//  SetUpViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpView.h"
@interface SetUpViewController ()

@end

@implementation SetUpViewController{
    SetUpView *setUpView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUI];
}
#pragma mark - 创建UI
-(void)loadUI{
    if (!setUpView) {
        setUpView = [[SetUpView alloc]initWithFrame:self.view.frame];
    }
    setUpView.viewController = self;
    [self.view addSubview:setUpView];
}
-(void)backClick{
    [super backClick];
    if (_BlockBack) {
        self.BlockBack();
    }
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
