//
//  QQBaseCollectionVC.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQBaseCollectionView : UICollectionView
/**
 *  停止刷新
 */
- (void)endRefresh;
/**
 *  隐藏刷新的头、尾
 */
- (void)hiddenRefresh;
/**
 *  隐藏刷新的头
 */
- (void)hiddenRefreshHeader;
/**
 *  隐藏刷新的尾
 */
- (void)hiddenRefreshFooter;
@end
