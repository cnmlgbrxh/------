//
//  ZeroBuyWillStartCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/21.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZeroBuyWillStartCellID @"ZeroBuyWillStartCellID"
@interface ZeroBuyWillStartCell : UITableViewCell
@property (strong,nonatomic) NSString *endTime;//截止时间的时间戳 2017.7.31 10:10:10
@property (assign,nonatomic) NSTimeInterval timeInterval;//时间差
@end
