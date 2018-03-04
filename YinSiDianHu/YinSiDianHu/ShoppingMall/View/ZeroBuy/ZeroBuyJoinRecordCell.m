//
//  ZeroBuyJoinRecordCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyJoinRecordCell.h"

@interface ZeroBuyJoinRecordCell()
@property (weak, nonatomic) IBOutlet UIView *awardNumBgView;
@property (weak, nonatomic) IBOutlet UIImageView *awardImageView;

@end

@implementation ZeroBuyJoinRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    self.awardImageView.hidden = currentIndex==1?YES:NO;
    self.awardNumBgView.hidden = currentIndex == 1?YES:NO;
}

@end
