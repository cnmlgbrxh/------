//
//  CellSelectState.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/3.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellSelectState.h"

@interface CellSelectState ()

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *labName;

@end
@implementation CellSelectState

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setStrName:(NSString *)strName{
    _strName = strName;
    _labName.text = _strName;
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    _btn.selected = _isSelect;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
