//
//  CellSetUp.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellSetUp.h"

@interface CellSetUp ()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeft1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeft2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTop;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@end

@implementation CellSetUp

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _layoutLeft1.constant = Scale(10);
    _layoutLeft2.constant = Scale(12);
    _layoutTop.constant = Scale(12);
}
-(void)setStrName:(NSString *)strName{
    _strName = strName;
    _labName.text = _strName;
    _imageV.image = [UIImage imageNamed:_strName];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
