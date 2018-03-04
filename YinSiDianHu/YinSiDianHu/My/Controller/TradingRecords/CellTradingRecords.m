//
//  CellTradingRecords.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellTradingRecords.h"

@interface CellTradingRecords ()
@property (weak, nonatomic) IBOutlet UILabel *labAmount;
@property (weak, nonatomic) IBOutlet UILabel *labStats;
@property (weak, nonatomic) IBOutlet UILabel *labResult;
@property (weak, nonatomic) IBOutlet UILabel *labTime;

@end

@implementation CellTradingRecords

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //40b2ed
    //df5050 red
    
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
    NSString *str;
    if ([[_dicDetail objectForKey:@"con_total"] integerValue]>=0) {
        str = [NSString stringWithFormat:@"+%@",[_dicDetail objectForKey:@"con_total"]];
    }else{
        str = [NSString stringWithFormat:@"%@",[_dicDetail objectForKey:@"con_total"]];
    }
    _labAmount.text = str;
    _labTime.text = [_dicDetail objectForKey:@"con_data"];
    _labResult.text = @"成功";
    _labStats.text = [_dicDetail objectForKey:@"con_type"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
