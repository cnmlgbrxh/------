//
//  QQMoneyPartChooseView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/16.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyPartChooseView.h"
@interface QQMoneyPartChooseView()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *numView;
@property(nonatomic,strong)UIButton *reduceBtn;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UILabel *leftLine;
@property(nonatomic,strong)UILabel *rightLine;
@property(nonatomic,strong)UILabel *numLabel;
@property(nonatomic,strong)UILabel *explainLabel;
@property(nonatomic,strong)UIButton *yesBtn;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,assign)NSInteger height;
@end

@implementation QQMoneyPartChooseView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.height = 230;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.numView];
    [self.numView addSubview:self.reduceBtn];
    [self.numView addSubview:self.addBtn];
    [self.numView addSubview:self.leftLine];
    [self.numView addSubview:self.rightLine];
    [self.numView addSubview:self.numLabel];
    [self.bgView addSubview:self.explainLabel];
    [self.bgView addSubview:self.yesBtn];
    [self.bgView addSubview:self.cancleBtn];
    [self setAutolayout];
}

- (void)show {
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    self.alpha = 0;
    self.bgView.frame  =CGRectMake(30, -SCREEN_H, SCREEN_W-60, self.height);
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1;
        self.bgView.frame = CGRectMake(30, (SCREEN_H-self.height)/2-40, SCREEN_W-60, self.height);
    }];
}

- (void)hide {
    self.alpha = 1;
    self.bgView.frame = CGRectMake(30, (SCREEN_H-self.height)/2-40, SCREEN_W-60, self.height);
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.bgView.frame  =CGRectMake(30, -SCREEN_H, SCREEN_W-60, self.height);
    }];
}

- (void)reduceBtnClick {
    if (![self.numLabel.text isEqualToString:@"1"]) {
        self.numLabel.text = [NSString stringWithFormat:@"%ld",[self.numLabel.text integerValue]-1];
        
    }
    [self.reduceBtn setImage:[self.numLabel.text isEqualToString:@"1"]?QQIMAGE(@"money_redice_normal"):QQIMAGE(@"money_reduce") forState:UIControlStateNormal];
}

- (void)addBtnClick {
    self.numLabel.text = [NSString stringWithFormat:@"%ld",[self.numLabel.text integerValue]+1];
    [self.reduceBtn setImage:QQIMAGE(@"money_reduce") forState:UIControlStateNormal];
}

- (void)yesBtnClick {
    if (self.money_chooseNumBlock) {
        self.money_chooseNumBlock([NSString stringWithFormat:@"%ld",[self.numLabel.text integerValue]*1000]);
    }
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"提示";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)numView {
    if (!_numView) {
        _numView = [[UIView alloc]init];
        _numView.layer.borderWidth  = 1;
        _numView.layer.borderColor = [UIColor colorWithHexString:@"cbcbcb"].CGColor;
        _numView.layer.cornerRadius = 3;
        _numView.layer.masksToBounds = YES;
    }
    return _numView;
}

- (UIButton *)reduceBtn {
    if (!_reduceBtn) {
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceBtn setImage:QQIMAGE(@"money_redice_normal") forState:UIControlStateNormal];
        [_reduceBtn addTarget:self action:@selector(reduceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceBtn;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:QQIMAGE(@"money_add") forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UILabel *)leftLine {
    if (!_leftLine) {
        _leftLine = [[UILabel alloc]init];
        _leftLine.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _leftLine;
}

- (UILabel *)rightLine {
    if (!_rightLine) {
        _rightLine = [[UILabel alloc]init];
        _rightLine.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
    }
    return _rightLine;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.text = @"1";
        _numLabel.textColor = [UIColor colorWithHexString:@"ed4044"];
        _numLabel.font = [UIFont systemFontOfSize:12];
        _numLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numLabel;
}

- (UILabel *)explainLabel {
    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc]init];
        _explainLabel.textColor = [UIColor colorWithHexString:@"434343"];
        _explainLabel.font = [UIFont systemFontOfSize:14];
        _explainLabel.text = @"*每份1000元，请选择投资份数";
    }
    return _explainLabel;
}

- (UIButton *)yesBtn {
    if (!_yesBtn) {
        _yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yesBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_yesBtn setTitleColor:[UIColor colorWithHexString:@"5fa2ef"] forState:UIControlStateNormal];
        _yesBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        [_yesBtn addTarget:self action:@selector(yesBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yesBtn;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor colorWithHexString:@"5fa2ef"] forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        _cancleBtn.userInteractionEnabled = NO;
    }
    return _cancleBtn;
}

- (void)setAutolayout {
    WS(wSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(wSelf.bgView);
        make.top.mas_equalTo(wSelf.bgView).mas_offset(20);
    }];
    
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(20);
        make.right.mas_equalTo(wSelf.bgView).mas_offset(-20);
        make.top.mas_equalTo(wSelf.titleLabel.mas_bottom).mas_offset(34);
        make.height.mas_equalTo(35);
    }];
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(wSelf.numView);
        make.width.mas_equalTo(58);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(wSelf.numView);
        make.width.mas_equalTo(58);
    }];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.reduceBtn.mas_right);
        make.top.bottom.mas_equalTo(wSelf.reduceBtn);
        make.width.mas_equalTo(0.5);
    }];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.addBtn.mas_left);
        make.top.bottom.mas_equalTo(wSelf.addBtn);
        make.width.mas_equalTo(0.5);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(wSelf.numView);
        make.left.mas_equalTo(wSelf.leftLine.mas_right);
        make.right.mas_equalTo(wSelf.rightLine.mas_left);
    }];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.numView.mas_left);
        make.top.mas_equalTo(wSelf.numView.mas_bottom).mas_offset(20);
    }];
    [self.yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.bgView).mas_offset(-30);
        make.height.width.mas_equalTo(40);
        make.top.mas_equalTo(wSelf.explainLabel.mas_bottom).mas_offset(30);
    }];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(30);
        make.height.width.mas_equalTo(40);
        make.top.mas_equalTo(wSelf.explainLabel.mas_bottom).mas_offset(30);    }];
}
@end
