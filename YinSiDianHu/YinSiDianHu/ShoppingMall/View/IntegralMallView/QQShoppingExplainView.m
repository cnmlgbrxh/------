//
//  QQShoppingExplainView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingExplainView.h"
#import "QQShoppingTools.h"

@interface QQShoppingExplainView()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITextView *contentLabel;
@property(nonatomic,strong)UIButton *knowBtn;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,assign)CGFloat viewHeight;
@end

@implementation QQShoppingExplainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        [self createUI];
    }
    return self;
}

- (void)show {
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.bgView setFrame:CGRectMake(24, SCREEN_H, [UIScreen mainScreen].bounds.size.width-48, self.viewHeight)];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.bgView setFrame:CGRectMake(24, (SCREEN_H-self.viewHeight)/2, [UIScreen mainScreen].bounds.size.width-48, self.viewHeight)];
    } completion:^(BOOL finished) {
    }];
}

- (void)hide {
    [self.bgView setFrame:CGRectMake(24, (SCREEN_H-self.viewHeight)/2, [UIScreen mainScreen].bounds.size.width-48, self.viewHeight)];
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [UIColor clearColor];
        [self.bgView setFrame:CGRectMake(24, SCREEN_H, [UIScreen mainScreen].bounds.size.width-48, self.viewHeight)];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setExplainStr:(NSString *)explainStr {
    _explainStr = explainStr;
    self.contentLabel.text = explainStr;
}

- (void)tappedCancel {
    [self hide];
}

- (void)createUI {
    self.viewHeight = SCREEN_H-300;
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.knowBtn];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.contentLabel];
    [self setAutoLayout];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"积分说明";
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UITextView *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UITextView alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = [Tools getUIColorFromString:@"7a7a7a"];
    }
    return _contentLabel;
}

- (UIButton *)knowBtn {
    if (!_knowBtn) {
        _knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_knowBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [_knowBtn setTitleColor:[Tools getUIColorFromString:@"5fa2e7"] forState:UIControlStateNormal];
        _knowBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_knowBtn addTarget:self action:@selector(knowBtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _knowBtn;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = [Tools getUIColorFromString:@"dfdfdf"];
    }
    return _line;
}

- (void)setAutoLayout {
    WS(wSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(24);
        make.width.mas_equalTo(SCREEN_W-48);
        make.centerY.mas_equalTo(wSelf);
        make.height.mas_equalTo(wSelf.viewHeight);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(22);
        make.top.mas_equalTo(wSelf.bgView).mas_offset(30);
        make.height.mas_equalTo(18);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(22);
        make.right.mas_equalTo(wSelf.bgView).mas_offset(-22);
        make.top.mas_equalTo(wSelf.titleLabel.mas_bottom).mas_offset(19);
        make.bottom.mas_equalTo(wSelf.line.mas_top);
    }];
    
    [self.knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(wSelf.bgView);
        make.height.mas_equalTo(57);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(wSelf.bgView);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(wSelf.knowBtn.mas_top);
    }];
}

- (void)knowBtnclick {
    [self hide];
}

- (void)dealloc{
    NSLog(@"释放了");
}

@end










