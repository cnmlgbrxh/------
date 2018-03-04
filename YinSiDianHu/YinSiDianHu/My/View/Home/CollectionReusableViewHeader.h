//
//  CollectionReusableViewHeader.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableViewHeader : UICollectionReusableView

@property (weak,nonatomic) UIViewController *viewController;

@property (copy,nonatomic) NSDictionary *dicDetail;

@end
