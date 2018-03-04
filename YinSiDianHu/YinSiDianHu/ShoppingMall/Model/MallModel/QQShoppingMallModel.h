//
//  QQShoppingMallModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingMallModel : NSObject
@property (nonatomic,strong)NSString *image;
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
 *  商品价格
 */
@property (nonatomic,strong)NSString *productPrice;
/**
 *商品购买人数
 */
@property (nonatomic,strong)NSString *volume;
@end
