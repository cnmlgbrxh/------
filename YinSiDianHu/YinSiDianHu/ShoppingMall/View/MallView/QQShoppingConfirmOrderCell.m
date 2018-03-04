//
//  QQShoppingConfirmOrderCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingConfirmOrderCell.h"


@interface QQShoppingConfirmOrderCell()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *product_pd;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
@implementation QQShoppingConfirmOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(QQShoppingCarModel *)model {
    _model = model;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.productPic] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
    self.productName.text = model.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.productPrice];
    self.numLabel.text = [NSString stringWithFormat:@"x %@",model.carNum];
    if ([model.product_dp containsString:@"?"]) {
        NSArray *arr = [model.product_dp componentsSeparatedByString:@"?"];
        self.product_pd.text = arr[1];
    }else{
        self.product_pd.text = model.product_dp;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end


@interface QQShoppingConfirmExplineCell()
@property(nonatomic,strong)UILabel *label;

@end
@implementation QQShoppingConfirmExplineCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_W-30, self.height)];
        self.label.text = @"*请仔细确认订单内容无误";
        self.label.textColor = [Tools getUIColorFromString:@"d97a2b"];
        self.label.font = [UIFont systemFontOfSize:11];
        [self addSubview:self.label];
    }
    return self;
}
@end


@interface QQShoppingConfirmChooseStyle()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UIButton *arrowBtn;
@end
@implementation QQShoppingConfirmChooseStyle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.leftLabel];
    [self.bgView addSubview:self.arrowBtn];
    [self.bgView addSubview:self.rightBtn];
    [self setAutolayout];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.text = @"配送方式";
        _leftLabel.textColor = [Tools getUIColorFromString:@"a9a9a9"];
        _leftLabel.font = [UIFont systemFontOfSize:15];
    }
    return _leftLabel;
}

- (UIButton *)arrowBtn {
    if (!_arrowBtn) {
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arrowBtn setImage:QQIMAGE(@"shopping_orderRightArrow") forState:UIControlStateNormal];
        _arrowBtn.userInteractionEnabled = NO;
    }
    return _arrowBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"圆通￥10.00" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[Tools getUIColorFromString:@"4d4d4d"] forState:UIControlStateNormal];
        _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        [_rightBtn setImage:QQIMAGE(@"shopping_wechat") forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightBtn.userInteractionEnabled = NO;
    }
    return _rightBtn;
}

- (void)setAutolayout {
    WS(wSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(wSelf);
        make.top.mas_equalTo(wSelf).mas_offset(7);
    }];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_equalTo(15);
        make.centerY.mas_equalTo(wSelf.bgView);
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.bgView).mas_offset(-15);
        make.centerY.mas_equalTo(wSelf.bgView);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.arrowBtn.mas_left).mas_offset(-8);
        make.centerY.mas_equalTo(wSelf.bgView);
    }];
}

- (void)setModel:(QQShoppingConfirmStyleModel *)model {
    _model = model;
    self.leftLabel.text = model.styleKey;
    [self.rightBtn setTitle:model.styleValue forState:UIControlStateNormal];
    [self.rightBtn setImage:QQIMAGE(model.imageName) forState:UIControlStateNormal];
}
@end

