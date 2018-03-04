//
//  CellSmallState.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellSmallState : UITableViewCell

@property (copy,nonatomic) NSDictionary *dicDetail;

@property (assign,nonatomic) BOOL isSelect;

@property (copy,nonatomic)void (^BlockSelect)(BOOL,NSInteger);

@end
