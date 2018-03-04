//
//  CollectionViewCellFunction.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CollectionViewCellFunction.h"

@interface CollectionViewCellFunction ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDetail;


@end

@implementation CollectionViewCellFunction

-(void)setDicValue:(NSDictionary *)dicValue{
    _dicValue = dicValue;
    
    _imageV.image = [UIImage imageNamed:[_dicValue.allKeys firstObject]];
    _labTitle.text = [_dicValue.allKeys firstObject];
    _labDetail.text = [_dicValue.allValues firstObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
