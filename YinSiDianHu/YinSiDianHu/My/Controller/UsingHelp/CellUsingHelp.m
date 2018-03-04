//
//  CellUsingHelp.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/26.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellUsingHelp.h"

@interface CellUsingHelp ()

@property (weak, nonatomic) IBOutlet UILabel *labName;

@end

@implementation CellUsingHelp

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setStrName:(NSString *)strName{
    _strName = strName;
    _labName.text = _strName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
