//
//  QQShoppingCollectionCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingCollectionCell.h"
@interface QQShoppingCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;
@end
@implementation QQShoppingCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(QQShoppingMallModel *)model {
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.productPic] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
    self.productNameLabel.text = model.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", model.productPrice];
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%@人购买",model.volume];
//    NSLog(@"%f %f",self.imageView.size.width,self.imageView.size.height);
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.productPic]]];
//    NSLog(@" 图片宽高-------- width:%f height: %f",image.size.width,image.size.height);
}
@end
