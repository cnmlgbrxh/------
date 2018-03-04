//
//  RechargeView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 17/7/3.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "RechargeView.h"
#import "BalanceRechargeView.h"
#import "PurchasePackageView.h"
#import "FreeAccessView.h"
#import "DevelopmentingView.h"
@interface RechargeView ()

@property (strong,nonatomic) BalanceRechargeView *balanceRechargeView;//余额充值
@property (strong,nonatomic) PurchasePackageView *purchasePackageView;//购买套餐
@property (strong,nonatomic) FreeAccessView *freeAccessView;//免费获取

@end
@implementation RechargeView{
    UIView *viewLine;//选项卡下面的黑线条
    UIButton *btnCurrent;
    NSArray *arrList;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HOMECOLOR;
        
    }
    return self;
}
-(void)setViewController:(UIViewController *)viewController{
    _viewController = viewController;
    [self createRechargeHeadView];
}
-(void)setIntArc4random:(NSInteger)intArc4random{
    _intArc4random = intArc4random;
    if (_intArc4random == 0) {
        [self addSubview:self.balanceRechargeView];
    }else{
        [self addSubview:self.purchasePackageView];
    }
    btnCurrent.selected = NO;
    UIButton *sender = [self viewWithTag:1000+_intArc4random];
    sender.selected = YES;
    btnCurrent = sender;
    [UIView animateWithDuration:0.3 animations:^{
        viewLine.frame = CGRectMake(sender.x, 54, SCREEN_W/arrList.count, 1);
    }];
}
#pragma mark - 点击选项按钮
-(void)btnListClick:(UIButton *)sender{
    
    if ([btnCurrent isEqual:sender]) {
        return;
    }

    if ([sender.currentTitle isEqualToString:@"余额充值"])
    {
        self.balanceRechargeView.isActive = YES;
        [self addSubview:self.balanceRechargeView];
    }else if ([sender.currentTitle isEqualToString:@"购买套餐"])
    {
        self.balanceRechargeView.isActive = NO;
        [self addSubview:self.purchasePackageView];
    }else if ([sender.currentTitle isEqualToString:@"免费获取"])
    {
        self.balanceRechargeView.isActive = NO;
        
        DevelopmentingView *developmentingView = LoadViewWithNIB(@"DevelopmentingView");
        developmentingView.frame = CGRectMake(0, 55, SCREEN_W, self.height-55);
        [self addSubview:developmentingView];
        //[self addSubview:self.freeAccessView];
    }
    
    btnCurrent.selected = NO;
    sender.selected = YES;
    btnCurrent = sender;
    [UIView animateWithDuration:0.3 animations:^{
        viewLine.frame = CGRectMake(sender.x, 54, SCREEN_W/arrList.count, 1);
    }];
    
}
#pragma mark - 创建选项按钮
-(void)createRechargeHeadView{
    UIView *rechargeHeadView = [[UIView alloc]init];
    rechargeHeadView.backgroundColor = WHITECOLOR;
    
    if ([USERMANAGER.level isEqualToString:@"super"]) {
        arrList = @[@"余额充值",@"购买套餐",@"免费获取"];
    }else{
        arrList = @[@"余额充值",@"免费获取"];
    }
    
    for (NSInteger idx = 0; idx!=arrList.count ; idx++)
    {
        UIButton *btnList = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W/arrList.count*idx, 0, SCREEN_W/arrList.count, 55)];
        [btnList setTitle:arrList[idx] forState:UIControlStateNormal];
        [btnList setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btnList setTitleColor:ColorHex(0x9c9c9c) forState:UIControlStateNormal];
        btnList.titleLabel.font = [UIFont systemFontOfSize:15];
        btnList.tag = 1000+idx;
        if (idx == 0) {
            btnList.selected = YES;
            btnCurrent = btnList;
            [self addSubview:self.balanceRechargeView];
        }
        [btnList addTarget:self action:@selector(btnListClick:) forControlEvents:UIControlEventTouchUpInside];
        [rechargeHeadView addSubview:btnList];
    }
    viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 54, SCREEN_W/arrList.count, 1)];
    viewLine.backgroundColor = BLACKCOLOR;
    [rechargeHeadView addSubview:viewLine];
    [self addSubview:rechargeHeadView];
    
    [rechargeHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(55);
    }];
}
#pragma mark - 懒加载
-(PurchasePackageView *)purchasePackageView{
    if (!_purchasePackageView) {
        _purchasePackageView = [[PurchasePackageView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_W, self.height-55)];
        _purchasePackageView.viewController = _viewController;
        WeakSelf;
        _purchasePackageView.BlockAmount = ^(NSString *str) {
            if (weakSelf.BlockAmount) {
                weakSelf.BlockAmount(str);
            }
        };
    }
    return _purchasePackageView;
}
-(BalanceRechargeView *)balanceRechargeView{
    if (!_balanceRechargeView) {
        _balanceRechargeView = [[BalanceRechargeView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_W, self.height-55)];
        _balanceRechargeView.viewController = _viewController;
        WeakSelf;
        _balanceRechargeView.BlockAmount = ^(NSString *str) {
            if (weakSelf.BlockAmount) {
                weakSelf.BlockAmount(str);
            }
        };
    }
    return _balanceRechargeView;
}
-(FreeAccessView *)freeAccessView{
    if (!_freeAccessView) {
        _freeAccessView = [[FreeAccessView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_W, self.height-55)];
        _freeAccessView.viewController = _viewController;
    }
    return _freeAccessView;
}
@end
