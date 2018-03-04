//
//  QQShoppingProductDetailModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingProductDetailModel : NSObject
/**
 *  商品id
 */
@property (nonatomic,strong)NSString *pid;
/**
 *  商品名称
 */
@property (nonatomic,strong)NSString *name;
/**
 *  商品本店价格
 */
@property (nonatomic,strong)NSString *price;
/**
 *  商品市场价格
 */
@property (nonatomic,strong)NSString *market;
/**
 *  商品库存
 */
@property (nonatomic,strong)NSString *amount;
/**
 *  商品缩略图
 */
@property (nonatomic,strong)NSString *pic;
/**
 *  商品大图
 */
@property (nonatomic,strong)NSString *img;
/**
 *  商品文字描述
 */
@property (nonatomic,strong)NSString *describe;
/**
 *  商品详情图片
 */
@property (nonatomic,strong)NSArray *details;

@property (nonatomic,strong)NSString *producting;
@end
