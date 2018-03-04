//
//  QQAddCarNamePriceCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQAddCarNamePriceCell.h"

@interface QQAddCarNamePriceCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *hiddenBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSpace;

@end
@implementation QQAddCarNamePriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgViewWidth.constant = SCREEN_W;
    self.imageView.layer.cornerRadius = 3;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 0.5;
    self.imageView.layer.borderColor = [Tools getUIColorFromString:@"bababa"].CGColor;
    self.hiddenBtn.userInteractionEnabled = YES;
    self.bgView.userInteractionEnabled = YES;
    self.rightSpace.constant = 0;
}
- (IBAction)hiddenBtnClick:(id)sender {
    if (self.shopping_hiddenGrayViewBlock) {
        self.shopping_hiddenGrayViewBlock();
    }
}

- (void)setModel:(QQShoppingProductDetailModel *)model {
    _model = model;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
    self.nameLabel.text = model.name;
    self.priceLabel.text = model.price;
}

@end


@implementation QQAddCarHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,15 , SCREEN_W-37, 13)];
    self.titleLabel.text = @"颜色";
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [Tools getUIColorFromString:@"9e9e9e"];
    [self addSubview:self.titleLabel];
}
@end


@implementation QQAddCarPropertyCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.propertyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.propertyLabel.font = [UIFont systemFontOfSize:12];
    self.propertyLabel.layer.cornerRadius = 3;
    self.propertyLabel.layer.borderColor = [Tools getUIColorFromString:@"c5c5c5"].CGColor;
    self.propertyLabel.textColor = [Tools getUIColorFromString:@"2a2a2a"];
    self.propertyLabel.layer.borderWidth = 0.5;
    self.propertyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.propertyLabel];
}

@end


