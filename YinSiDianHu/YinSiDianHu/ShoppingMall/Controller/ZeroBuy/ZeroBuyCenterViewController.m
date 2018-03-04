//
//  ZeroBuyCenterViewController.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/21.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyCenterViewController.h"
#import "ZeroBuyMyCenterVC.h"

@interface ZeroBuyCenterViewController ()
@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation ZeroBuyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"我的0元购";
        [self createLeftButten];
        self.menuItemWidth = SCREEN_W/3;
        self.menuHeight = 45;
        self.menuViewStyle = WMMenuViewStyleDefault;
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        self.titleColorNormal = [Tools getUIColorFromString:@"4f4f4f"];
        self.titleColorSelected = [Tools getUIColorFromString:@"fc4d00"];
        self.titleSizeNormal = 13;
        self.menuBGColor = [UIColor whiteColor];
        self.titleSizeSelected = 13;
        
    }
    return self;
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

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return [self.titleArray count];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    ZeroBuyMyCenterVC *vc = [[ZeroBuyMyCenterVC alloc]init];
    vc.currentIndex = index;
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.titleArray objectAtIndex:index];
}



- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"全部",@"未开奖",@"中奖记录",nil];
    }
    return _titleArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
