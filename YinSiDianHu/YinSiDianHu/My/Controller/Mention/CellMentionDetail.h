//
//  CellMentionDetail.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellMentionDetail : UITableViewCell

@property (copy,nonatomic) NSDictionary *dicDetail;

@property (assign,nonatomic) BOOL isBecomeFirstResponder;

/**
 回调的名称和内容
 */
@property (copy,nonatomic)void (^Block)(NSString *,NSString *);

@end
