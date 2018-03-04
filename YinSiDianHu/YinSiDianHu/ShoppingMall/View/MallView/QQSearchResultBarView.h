//
//  QQSearchResultBarView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QQSearchResultBarViewID @"QQSearchResultBarViewID"
@interface QQSearchResultBarView : UIView
@property(nonatomic,copy)void(^shopping_searchResultBackBlick)();
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
