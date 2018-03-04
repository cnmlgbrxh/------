//
//  QQShoppingOrderDetailModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/26.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingOrderDetailModel : NSObject
/**
 * 地址
 */
@property (nonatomic,strong)NSString *address;
/**
 * 快递方式
 */
@property (nonatomic,strong)NSString *distribution;
/**
 * 运费
 */
@property (nonatomic,strong)NSString *freight;
/**
 * 数量
 */
@property (nonatomic,strong)NSString *num;
/**
 * 订单编号
 */
@property (nonatomic,strong)NSString *ordno;
/**
 * 收件人姓名
 */
@property (nonatomic,strong)NSString *owner;
/**
 * 支付方式：移动支付宝
 */
@property (nonatomic,strong)NSString *payment;
/**
 * 收件人姓名
 */
@property (nonatomic,strong)NSString *phone;
/**
 * 商品缩略图
 */
@property (nonatomic,strong)NSString *pic;
/**
 * 商品id
 */
@property (nonatomic,strong)NSString *pid;
/**
 * 商品名称
 */
@property (nonatomic,strong)NSString *pname;
/**
 * 邮编
 */
@property (nonatomic,strong)NSString *postcode;
/**
 * 商品价格
 */
@property (nonatomic,strong)NSString *price;
/**
 * 订单状态：待付款
 */
@property (nonatomic,strong)NSString *status;
/**
 * 购买时间
 */
@property (nonatomic,strong)NSString *time;

@property (nonatomic,strong)NSString *product_dp;

@property (nonatomic,strong)NSString *districode;

@end
