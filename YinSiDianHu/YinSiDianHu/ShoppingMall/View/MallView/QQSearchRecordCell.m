//
//  QQSearchRecordCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQSearchRecordCell.h"

@implementation QQSearchRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)deleteBtnClick:(id)sender {
    if (self.shopping_searchRecordDeleteBlock) {
        self.shopping_searchRecordDeleteBlock();
    }
}

@end
