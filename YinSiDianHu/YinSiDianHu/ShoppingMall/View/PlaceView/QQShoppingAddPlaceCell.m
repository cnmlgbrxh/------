//
//  QQShoppingAddPlaceCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingAddPlaceCell.h"
#import "ReactiveCocoa.h"


@implementation QQShoppingAddPlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end




@interface QQShoppingAddPlaceNomalCell()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *keyLabel;
@property(nonatomic,strong)UILabel *line;
@end
@implementation QQShoppingAddPlaceNomalCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.keyLabel];
    [self.bgView addSubview:self.valueLabel];
    [self.bgView addSubview:self.line];
    [self setAutolayout];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)keyLabel {
    if (!_keyLabel) {
        _keyLabel = [[UILabel alloc]init];
        _keyLabel.font = [UIFont systemFontOfSize:14];
        _keyLabel.textColor = [Tools getUIColorFromString:@"838383"];
    }
    return _keyLabel;
}

- (UITextField *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UITextField alloc]init];
        _valueLabel.borderStyle = UITextBorderStyleNone;
        _valueLabel.font = [UIFont systemFontOfSize:14];
        _valueLabel.textColor = [Tools getUIColorFromString:@"838383"];
        WS(wSelf);
        [[_valueLabel rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
            if (wSelf.shopping_confirmTextFieldBlcok) {
                wSelf.shopping_confirmTextFieldBlcok(_valueLabel.text);
            }
        }];
    }
    return _valueLabel;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = [Tools getUIColorFromString:@"d9d9d9"];
    }
    return _line;
}

- (void)setAutolayout {
    WS(wSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(wSelf);
    }];
    
    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(15);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(wSelf.bgView.centerY);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.keyLabel.mas_right).mas_equalTo(17);
        make.width.mas_equalTo(200);
        make.centerY.mas_equalTo(wSelf.bgView.centerY);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(15);
        make.right.mas_equalTo(wSelf.bgView).mas_offset(-15);
        make.bottom.mas_equalTo(wSelf.bgView);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setModel:(QQShoppingConfirmStyleModel *)model {
    _model = model;
    self.keyLabel.text = model.styleKey;
    if (model.styleValue.length > 0 && model.styleValue != nil) {
        self.valueLabel.text = model.styleValue;
    }else{
    }
}
@end





