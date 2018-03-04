//
//  SuperViewController.m
//  ShiZhiBao
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "SuperViewController.h"
#import "UIBarButtonItem+BarButtonItem.h"

@interface SuperViewController ()

@end

@implementation SuperViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR(246, 247, 248);
    
}
-(void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.title = _navTitle;
    [self creatLeftBarBtn];
}
-(void)creatLeftBarBtn{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"shopping_arrow" highImage:@"shopping_arrow" target:self action:@selector(backClick)];
}
-(void)creatRightBarBtnTitle:(NSString *)title{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:title location:RightBarButton target:self action:@selector(RightBarBtnClick)];
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)RightBarBtnClick{
    
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
