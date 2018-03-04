//
//  QQShoppingHeadView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

#define  QQShoppingHeadViewIdentifier @"QQShoppingHeadViewIdentifier"
#define QQShoppingClassificationHeadViewID @"QQShoppingClassificationHeadViewID"


@interface QQShoppingHeadItemView : UIView
@property(nonatomic,copy)void(^shopping_headViewBtnClickBlock)(NSInteger tag);
@end

@interface QQShoppingHeadView : UICollectionReusableView
@property (nonatomic,strong) SDCycleScrollView   *cycleScrollView;
@property(nonatomic,copy)void(^shopping_shoppingBannerTapkBlock)(NSInteger index,NSString * pid);
@property (nonatomic,strong) QQShoppingHeadItemView *bgView;
@property(nonatomic,strong)NSArray *bannerArray;
@property(nonatomic,copy)void(^shopping_midImageViewClickBlock)(NSInteger tag);
@end


@interface QQShoppingClassificationHeadView : UICollectionReusableView
@property (nonatomic,strong)NSString *sectionTitle;
@end


