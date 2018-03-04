//
//  CellSelectPayWay.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellSelectPayWay.h"

@interface CellSelectPayWay ()
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labSubTitle;

@end

@implementation CellSelectPayWay

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setStrName:(NSString *)strName{
    _strName = strName;
    _labName.text = _strName;
    _imageV.image = [UIImage imageNamed:_strName];
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    _btnSelect.selected = _isSelect;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
