//
//  ZeroBuyPayOrderHeadCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/28.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyPayOrderHeadCell.h"

@implementation ZeroBuyPayOrderHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end





@interface ZeroBuyPayOrderHead()
@property (nonatomic,strong)UIView *bgView;;
@property (nonatomic,strong)UIView *titleBgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *explianLabel;
@end

@implementation ZeroBuyPayOrderHead
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.explianLabel];
    [self addSubview:self.titleBgView];
    [self.titleBgView addSubview:self.titleLabel];
    [self.titleBgView addSubview:self.priceLabel];
    [self setAutoLayout];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return _bgView;
}

- (UIView *)titleBgView {
    if (!_titleBgView) {
        _titleBgView = [[UIView alloc]init];
        _titleBgView.backgroundColor = [UIColor whiteColor];
    }
    return _titleBgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [Tools getUIColorFromString:@"303030"];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"SONY PlayStation VR 虚拟现实头戴设备";
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [Tools getUIColorFromString:@"303030"];
        _priceLabel.font = [UIFont systemFontOfSize:37];
        _priceLabel.text = @"￥240.00";
    }
    return _priceLabel;
}

- (UILabel *)explianLabel {
    if (!_explianLabel) {
        _explianLabel = [[UILabel alloc]init];
        _explianLabel.textColor = [Tools getUIColorFromString:@"b1b1b1"];
        _explianLabel.font = [UIFont systemFontOfSize:15];
        _explianLabel.text = @"充值方式";
    }
    return _explianLabel;
}

- (void)setAutoLayout {
    WS(wSelf);
    [self.titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(wSelf);
        make.height.mas_equalTo(100);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wSelf.titleBgView.mas_bottom);
        make.left.right.bottom.mas_equalTo(wSelf);
    }];
    
    [self.explianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(10);
        make.centerY.mas_equalTo(wSelf.bgView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.titleBgView).mas_offset(10);
        make.right.mas_equalTo(wSelf.titleBgView).mas_offset(-10);
        make.top.mas_equalTo(wSelf.titleBgView).mas_offset(19);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wSelf.titleBgView);
        make.top.mas_equalTo(wSelf.titleLabel.mas_bottom).mas_offset(15);
    }];
}
@end






