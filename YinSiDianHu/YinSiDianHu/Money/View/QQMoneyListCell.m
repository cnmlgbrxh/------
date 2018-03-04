//
//  QQMoneyListCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyListCell.h"

@interface QQMoneyListCell()
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation QQMoneyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rightLabel.text = @"随时\n领取";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(QQMoneyListProductDetailModel *)model {
    _model = model;
    self.nameLabel.text = model.pro_name;
    NSString *temp = @"%";
    self.rateLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%.2f%@",[model.pro_rate floatValue],temp] changeStr:temp color:nil font:[UIFont systemFontOfSize:13]];
    self.priceLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%@元",model.pro_price] changeStr:@"元" color:nil font:[UIFont systemFontOfSize:13] ];
}

@end



@interface QQMoneyHeadView()
@property(nonatomic,strong)UIView *leftLine;
@end
@implementation QQMoneyHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [self addSubview:self.titleLabel];
    [self addSubview:self.leftLine];
    [self setAutolayout];
}

- (UIView *)leftLine {
    if (!_leftLine) {
        _leftLine = [[UIView alloc]init];
        _leftLine.backgroundColor = [Tools getUIColorFromString:@"58b7ee"];
    }
    return _leftLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"零钱体验";
    }
    return _titleLabel;
}

- (void)setAutolayout {
    WS(wSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(wSelf);
        make.left.mas_equalTo(18);
        make.height.mas_equalTo(16);
    }];
    
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.centerY.mas_equalTo(wSelf);
        make.width.mas_equalTo(2.5);
        make.height.mas_equalTo(wSelf.titleLabel.mas_height);
    }];
}
@end



@interface QQMoneyTableHeadView()
@end
@implementation QQMoneyTableHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}


- (void)createUI {
    self.headImage = [[UIImageView alloc]init];
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.headImage];
    WS(wSelf);
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(wSelf);
    }];
}

@end
