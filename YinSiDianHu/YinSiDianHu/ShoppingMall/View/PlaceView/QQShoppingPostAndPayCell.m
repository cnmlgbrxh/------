//
//  QQShoppingPostAndPayCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingPostAndPayCell.h"

@implementation QQShoppingPostAndPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



@interface QQShoppingPostAndPayHeadCell()
@property(nonatomic,strong)UIButton *hiddenBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@end
@implementation QQShoppingPostAndPayHeadCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.hiddenBtn];
    [self addSubview:self.titleLabel];
    [self setAutoLayout];
}

- (UIButton *)hiddenBtn {
    if (!_hiddenBtn) {
        _hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hiddenBtn setImage:QQIMAGE(@"shopping_addCarDelete") forState:UIControlStateNormal];
        [_hiddenBtn addTarget:self action:@selector(payHiddenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"配送方式";
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setAutoLayout {
    WS(wSelf);
    [self.hiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.centerY.mas_equalTo(wSelf);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(wSelf);
        make.centerY.mas_equalTo(wSelf);
    }];
}

- (void)payHiddenBtnClick {
    if (self.shopping_payHeadViewBlock) {
        self.shopping_payHeadViewBlock();
    }
}
@end
