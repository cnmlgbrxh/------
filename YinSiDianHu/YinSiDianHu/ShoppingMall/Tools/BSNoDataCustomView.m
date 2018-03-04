//
//  BSNoDataCustomView.m
//  BensonApp
//
//  Created by 宋丹 on 16/11/15.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import "BSNoDataCustomView.h"
@interface BSNoDataCustomView()
@property(nonatomic,strong) UIButton *noDataBtn;
@property(nonatomic,strong) UILabel *noDataLabel;
@property(nonatomic,strong) NSString *promptText;
@property(nonatomic,strong) UIButton *reloadBtn;
@end
@implementation BSNoDataCustomView

+(instancetype)sharedInstance {
    static BSNoDataCustomView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[BSNoDataCustomView alloc]init];
    });
    return view;
}

-(void)showCustomViewAddToTargetView:(UIView *)targetView customViewFrame:(CGRect)rect promptText:(NSString *)promptText image:(NSString *)imageName {
    if (targetView == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    }else{
        [targetView addSubview:self];
    }
    if (promptText && promptText.length>0) {
        self.promptText = promptText;
    }
    if (rect.size.width) {
        self.frame = rect;
    }else{
        self.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H-64);
        self.frame = targetView.bounds;
    }
    [self createReloadUI];
    self.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [self.noDataBtn setImage:QQIMAGE(imageName) forState:UIControlStateNormal];
}

- (void)showViewAddToTargetView:(UIView*)targetView customViewFrame:(CGRect)rect promptText:(NSString *)promptText image:(BOOL)isWait{
    if (promptText && promptText.length>0) {
        self.promptText = promptText;
    }
    if (rect.size.width) {
        self.frame = rect;
    }else{
        self.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H-64);
        self.frame = targetView.bounds;
    }
    self.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [targetView addSubview:self];
    if (isWait) {
        [self createReloadUI];
    }else{
        [self createUI];
    }
    [self.noDataBtn setImage:QQIMAGE(@"comment_ prompt") forState:UIControlStateNormal];
}

-(void)showCustormViewToTargetView:(UIView *)targetView promptText:(NSString *)promptText customViewFrame:(CGRect)rect {
    [self showViewAddToTargetView:targetView customViewFrame:rect promptText:promptText image:NO];
}

-(void)showReloadViewToTargetView:(UIView *)targetView customViewFrame:(CGRect)rect {
[self showViewAddToTargetView:targetView customViewFrame:rect promptText:@"您的网络好像不太给力，请稍后再试" image:YES];
}

-(void)showCustormViewToTargetView:(UIView *)targetView promptText:(NSString *)promptText {
    [self showViewAddToTargetView:targetView customViewFrame:targetView.bounds promptText:promptText image:NO];
}

-(void)showCustormViewToTargetView:(UIView *)targetView {
    [self showCustormViewToTargetView:targetView promptText:@"暂无相关数据哦~"];
}

- (void)setPromptText:(NSString *)promptText {
    _promptText = promptText;
    self.noDataLabel.text = promptText;
}

- (void)createUI {
    [self addSubview:self.noDataLabel];
    [self addSubview:self.noDataBtn];
    [self setLayout];
}

- (void)createReloadUI {
    [self addSubview:self.noDataLabel];
    [self addSubview:self.noDataBtn];
    [self addSubview:self.reloadBtn];
    [self setLayout];
    [self setReloadLayout];
}

- (void)setLayout {
    WS(wSelf);
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.right.mas_equalTo(wSelf).mas_offset(-10);
        make.centerY.mas_equalTo(wSelf).mas_offset(0);
    }];
    
    [self.noDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.right.mas_equalTo(wSelf).mas_offset(-10);
        make.bottom.mas_equalTo(wSelf.noDataLabel.mas_top).mas_offset(-30);
    }];
}

- (void)setReloadLayout {
    WS(wSelf);
    [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(wSelf.noDataLabel.mas_bottom).mas_offset(50);
        make.centerX.mas_equalTo(wSelf);
    }];
}

- (UIButton *)noDataBtn {
    if (!_noDataBtn) {
        _noDataBtn = [[UIButton alloc]init];
        [_noDataBtn setImage:QQIMAGE(@"comment_ prompt") forState:UIControlStateNormal];
        _noDataBtn.userInteractionEnabled = NO;
        [_noDataBtn setTitleColor:[Tools getUIColorFromString:@"666666"] forState:UIControlStateNormal];
    }
    return _noDataBtn;
}

- (UILabel *)noDataLabel {
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc]init];
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        _noDataLabel.text = @"哎呀，还没有相关数据~";
        _noDataLabel.textColor = [Tools getUIColorFromString:@"2a2a2a"];
        _noDataLabel.font = [UIFont systemFontOfSize:15];
    }
    return _noDataLabel;
}

- (UIButton*)reloadBtn {
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        _reloadBtn.layer.cornerRadius = 3;
        _reloadBtn.layer.masksToBounds = YES;
        [_reloadBtn setTitleColor:[Tools getUIColorFromString:@"87c0e9"] forState:UIControlStateNormal];
        _reloadBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _reloadBtn.layer.borderColor = [Tools getUIColorFromString:@"87c0e0"].CGColor;
        _reloadBtn.layer.borderWidth = 1;
        [_reloadBtn addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}

- (void)hiddenNoDataView {
    [self removeFromSuperview];
}

- (void)refreshData {
    if (self.BSNoDataCustomViewBlock) {
        self.BSNoDataCustomViewBlock();
    }
}

@end





























