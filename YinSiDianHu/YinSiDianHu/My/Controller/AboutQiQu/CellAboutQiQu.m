//
//  CellAboutQiQu.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellAboutQiQu.h"

@interface CellAboutQiQu ()
@property (weak, nonatomic) IBOutlet UILabel *labName;

@property (weak, nonatomic) IBOutlet UILabel *labContent;

@end
@implementation CellAboutQiQu

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setStrName:(NSString *)strName{
    _strName = strName;
    _labName.text = _strName;
    if ([_strName isEqualToString:@"检查更新"]) {
        _labContent.text = @"已是最新版本";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
