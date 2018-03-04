//
//  RequestFailedView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/21.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockRefreshData)();
@interface RequestFailedView : UIView

@property (nonatomic, copy) BlockRefreshData blockRefreshData;

@end
