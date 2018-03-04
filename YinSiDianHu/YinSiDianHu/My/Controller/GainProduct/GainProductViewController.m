//
//  GainProductViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/28.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "GainProductViewController.h"
#import "DevelopmentingView.h"
@interface GainProductViewController ()

@end

@implementation GainProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DevelopmentingView *developmentingView = LoadViewWithNIB(@"DevelopmentingView");
    developmentingView.frame = self.view.frame;
    [self.view addSubview:developmentingView];
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
