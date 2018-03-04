//
//  QQShoppingIntegralHeadView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QQShoppingIntegralHeadViewID @"QQShoppingIntegralHeadViewID"
@interface QQShoppingIntegralHeadView : UICollectionReusableView
@property(nonatomic,copy)void(^shopping_changeRecordBlock)();
@property(nonatomic,copy)void(^shopping_canUseBlock)();
@property(nonatomic,strong)NSArray *bannerArray;
@property(nonatomic,copy)void(^integ_BannerTapkBlock)(NSInteger index,NSString * pid);
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end
