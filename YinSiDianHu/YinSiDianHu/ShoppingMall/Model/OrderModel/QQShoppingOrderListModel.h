//
//  QQShoppingOrderListModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingOrderListModel : NSObject
/**
 * 订单id
 */
@property (nonatomic,strong)NSString *gid;
/**
 * 数量
 */
@property (nonatomic,strong)NSString *gnum;
/**
 * 时间
 */
@property (nonatomic,strong)NSString *gtime;
/**
 * 付款状态:0:未付款   1：已付款
 */
@property (nonatomic,strong)NSString *gstats;
/**
 * 发货状态 0:未发货 1：已发货
 */
@property (nonatomic,strong)NSString *is_delivery;
/**
 * 收货状态 0:未收货 1：已收货
 */
@property (nonatomic,strong)NSString *take_delivery;
/**
 * 订单状态 0:未取消 1：已取消
 */
@property (nonatomic,strong)NSString *is_abolish;
/**
 * 商品名称
 */
@property (nonatomic,strong)NSString *productName;
/**
 * 商品价格
 */
@property (nonatomic,strong)NSString *gprice;
/**
 * 商品缩略图
 */
@property (nonatomic,strong)NSString *productPic;
/**
 * 收货人
 */
@property (nonatomic,strong)NSString *gname;
/**
 * 电话
 */
@property (nonatomic,strong)NSString *gphone;
/**
 * 运费
 */
@property (nonatomic,strong)NSString *freight;
/**
 * 快递方式
 */
@property (nonatomic,strong)NSString *gdistribution;
/**
 * 订单编号
 */
@property (nonatomic,strong)NSString *gno;
/**
 * 商品参数
 */
@property (nonatomic,strong)NSString *product_dp;
@end
