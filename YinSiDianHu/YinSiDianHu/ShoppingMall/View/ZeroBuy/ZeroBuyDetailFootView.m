//
//  ZeroBuyDetailFootView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyDetailFootView.h"

@implementation ZeroBuyDetailFootView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end




@interface ZeroBuyDetailFirstFootView()
@property(nonatomic,strong)UIButton *joinBtn;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *explainLabel;
@property(nonatomic,strong)UILabel *line;
@end
@implementation ZeroBuyDetailFirstFootView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.line];
    [self addSubview:self.joinBtn];
    [self addSubview:self.priceLabel];
    [self addSubview:self.explainLabel];
    [self setAutoLayout];
}

- (UIButton *)joinBtn {
    if (!_joinBtn) {
        _joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinBtn.backgroundColor = [Tools getUIColorFromString:@"ed4044"];
        _joinBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_joinBtn setTitle:@"立即参与" forState:UIControlStateNormal];
        _joinBtn.layer.cornerRadius = 3;
        _joinBtn.layer.masksToBounds = YES;
        [_joinBtn addTarget:self action:@selector(joinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinBtn;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"￥10.00";
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor=[Tools getUIColorFromString:@"ed4044"];
    }
    return _priceLabel;
}

- (UILabel*)explainLabel{
    if (!_explainLabel) {
        _explainLabel=[[UILabel alloc]init];
        _explainLabel.text=@"一份";
        _explainLabel.font = [UIFont systemFontOfSize:13];
        _explainLabel.textColor=[Tools getUIColorFromString:@"303030"];
    }
    return _explainLabel;
}

- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor=[Tools getUIColorFromString:@"b9b9b9"];
    }
    return _line;
}

- (void)setAutoLayout {
    WS(wSelf);
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(wSelf);
        make.height.mas_equalTo(1);
    }];
    
    [self.joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf).mas_offset(-10);
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(34);
        make.centerY.mas_equalTo(wSelf);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.joinBtn.mas_left).mas_offset(-28);
        make.centerY.mas_equalTo(wSelf);
    }];
    
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.priceLabel.mas_left).mas_offset(-18);
        make.centerY.mas_equalTo(wSelf);
    }];
}

- (void)joinBtnClick {
    if (self.zero_firstBtnJoinBlock) {
        self.zero_firstBtnJoinBlock();
    }
    
}
@end
