//
//  TabBarController.m
//  ShiZhiBao
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "TabBarController.h"
#import "CallViewController.h"
#import "ContactViewController.h"
#import "QQShoppingMallVC.h"
#import "RechargeViewController.h"
#import "MyViewController.h"
#import "NavigationViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (IOS_VERSION >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UIView *viewTabbar = [[UIView alloc]initWithFrame:self.tabBar.bounds];
    viewTabbar.backgroundColor = [UIColor blackColor];
    [[UITabBar appearance] insertSubview:viewTabbar atIndex:0];
    
    //监听键盘
    [self ListeningkeyboardChange];
    
    [self initTabbar];
}
#pragma mark - 监听
-(void)ListeningkeyboardChange{
    [DataManager valueChangedForKey:@"隐藏键盘了" reuseIdentifier:StringClass changed:^(id object, id oldObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UITabBarItem *item = self.tabBar.items[0];
            item.title = @"收起";
            [self tabBar:self.tabBar didSelectItem:item];
        });
    }];
}
#pragma mark - 初始化
-(void)initTabbar{
    
    [self addChildViewController:[[CallViewController alloc]init] WithTitle:@"收起" withImage:@"展开" withSelectedImage:@"展开"];
    
    [self addChildViewController:[[ContactViewController alloc]init] WithTitle:@"通讯录" withImage:@"通讯录" withSelectedImage:@"通讯录se"];
    
    [self addChildViewController:[[QQShoppingMallVC alloc]init] WithTitle:@"商城" withImage:@"商城" withSelectedImage:@"商城se"];
    
    [self addChildViewController:[[RechargeViewController alloc]init] WithTitle:@"充值" withImage:@"充值" withSelectedImage:@"充值se"];
    
    [self addChildViewController:[[MyViewController alloc]init] WithTitle:@"个人中心" withImage:@"我" withSelectedImage:@"我se"];
    
}
#pragma mark - 初始化加载Tabbar
- (void)addChildViewController:(UIViewController *)childVC WithTitle:(NSString *)title withImage:(NSString *)image withSelectedImage:(NSString *)selectedImage{
    
    childVC.title = title;
    UIImage *myImage = [UIImage imageNamed:image];
    childVC.tabBarItem.image =[myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选中图标
    UIImage *selImage = [UIImage imageNamed:selectedImage];
    
    childVC.tabBarItem.selectedImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [childVC.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}
#pragma mark - 改变TabBarItem的方法
-(void)changeTabBarItem:(NSInteger)intNum WithTitle:(NSString *)title withImage:(NSString *)strImage withSelectedImage:(NSString *)strSelectedImage{
    if (title)
    {
        [self.tabBar.items[intNum] setTitle:title];
    }
    if (strImage)
    {
        [self.tabBar.items[intNum] setImage:[UIImage imageNamed:strImage]];
    }
    if (strSelectedImage)
    {
        [self.tabBar.items[intNum] setSelectedImage:[UIImage imageNamed:strSelectedImage]];
    }
}
#pragma mark - UITabBarDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if([item.title isEqualToString:@"展开"]||[item.title isEqualToString:@"拨打"])
    {
        if ([item.title isEqualToString:@"展开"]) {
            //显示键盘
            CallViewController *callVC=[self.childViewControllers[0].childViewControllers firstObject];
            callVC.isPhoneKeypad = NO;
        }
        
        [item setTitle:@"收起"];
        item.selectedImage = [[UIImage imageNamed:@"展开"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.rightBarButtonItem = nil;
    }else if ([item.title isEqualToString:@"收起"])
    {
        [item setTitle:@"展开"];
        item.selectedImage = [[UIImage imageNamed:@"收起"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //隐藏键盘
        CallViewController *callVC = [self.childViewControllers[0].childViewControllers firstObject];
        callVC.isPhoneKeypad = YES;
    }else{
        [self changeTabBarItem:0 WithTitle:@"拨打" withImage:@"拨打" withSelectedImage:nil];
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
