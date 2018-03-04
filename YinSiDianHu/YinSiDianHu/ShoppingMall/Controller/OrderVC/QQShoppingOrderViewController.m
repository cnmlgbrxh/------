//
//  QQShoppingOrderViewController.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingOrderViewController.h"
#import "QQShoppingAllOrderVC.h"

@interface QQShoppingOrderViewController ()
@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation QQShoppingOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLeftButten];
    self.title = @"订单列表";
}

- (void)leftBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createLeftButten {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"shopping_arrow"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shopping_arrow"] forState:UIControlStateHighlighted];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.size = CGSizeMake(40, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [button addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return [self.titleArray count];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    QQShoppingAllOrderVC *vc = [[QQShoppingAllOrderVC alloc]init];
    vc.currentIndex = index;
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.titleArray objectAtIndex:index];
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"全部",@"待付款",@"待发货",@"已发货",@"已完成",@"已取消",nil];
    }
    return _titleArray;
}

- (instancetype)init {
    if (self = [super init]) {
        self.menuItemWidth = SCREEN_W/6;
        self.menuHeight = 45;
        self.menuViewStyle = WMMenuViewStyleDefault;
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        self.titleColorNormal = [Tools getUIColorFromString:@"4f4f4f"];
        self.titleColorSelected = [Tools getUIColorFromString:@"fc4d00"];
        self.titleSizeNormal = 13;
        self.menuBGColor = [UIColor whiteColor];
        self.titleSizeSelected = 13;
        self.cachePolicy = 0;
    }
    return self;
}
@end




