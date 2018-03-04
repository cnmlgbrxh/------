//
//  CollectionViewCellFunction.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCellFunction : UICollectionViewCell

@property (copy,nonatomic) NSDictionary*dicValue;
@property (weak, nonatomic) IBOutlet UILabel *topLine;
@property (weak, nonatomic) IBOutlet UILabel *bottomLine;

@end
