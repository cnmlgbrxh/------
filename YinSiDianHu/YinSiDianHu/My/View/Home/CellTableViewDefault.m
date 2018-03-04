//
//  CellTableViewDefault.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellTableViewDefault.h"

@interface CellTableViewDefault ()
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labContent;

@end
@implementation CellTableViewDefault

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
    
    _labName.text = [_dicDetail.allKeys firstObject];
    _labContent.text = [_dicDetail.allValues firstObject];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
