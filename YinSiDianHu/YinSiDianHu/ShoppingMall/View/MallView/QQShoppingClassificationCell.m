//
//  QQShoppingClassificationCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingClassificationCell.h"
@interface QQShoppingClassificationCell()
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation QQShoppingClassificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.titleLabel.text = [dic allKeys][0];
//    [self.iconBtn setImage:QQIMAGE([dic allValues][0]) forState:UIControlStateNormal];
    self.imageView.image = QQIMAGE([dic allValues][0]);
}
@end


@interface QQShoppingActivityCell()
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIImageView *imageView;
@end
@implementation QQShoppingActivityCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imageView.image = QQIMAGE(imageName);
}

- (void)btnClick:(UIButton *)btn {
    if (self.shopping_ActivityBtnClickblock) {
        self.shopping_ActivityBtnClickblock(btn.tag);
    }
}
@end






