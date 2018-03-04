//
//  QQIntegListModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/3.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQIntegListModel : NSObject
/**
 *  商品id
 */
@property (nonatomic,strong)NSString *productId;
/**
 *  商品名称
 */
@property (nonatomic,strong)NSString *productName;
/**
 *  商品图片
 */
@property (nonatomic,strong)NSString *productPic;
/**
 *  商品积分
 */
@property (nonatomic,strong)NSString *producting;
/**
 *商品购买人数
 */
@property (nonatomic,strong)NSString *volume;
/**
 *市场价
 */
@property (nonatomic,strong)NSString *productMarket;
/**
 *商品数量
 */
@property (nonatomic,strong)NSString *productAmount;
@end

