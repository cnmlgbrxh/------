//
//  CellProductZone.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/23.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellProductZone.h"

@interface CellProductZone ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UILabel *labProgress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeft;
@property (weak, nonatomic) IBOutlet UIProgressView *progressV;

@end
@implementation CellProductZone

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
