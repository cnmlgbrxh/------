//
//  QQShoppingCarModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/11.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingCarModel : NSObject
////个数
//@property (nonatomic,strong)NSString * num;
//@property (nonatomic,strong)NSString * price;
////cell是否付款
@property (nonatomic,assign)BOOL isPayment;



/**
 *  购物车id
 */
@property (nonatomic,strong)NSString *carId;
/**
 * 用户名
 */
@property (nonatomic,strong)NSString *username;
/**
 *  商品id
 */
@property (nonatomic,strong)NSString *pid;
/**
 * 商品名称
 */
@property (nonatomic,strong)NSString *productName;
/**
 * 商品价格
 */
@property (nonatomic,strong)NSString *productPrice;
/**
 * 商品缩略图
 */
@property (nonatomic,strong)NSString *productPic;
/**
 * 商品参数
 */
@property (nonatomic,strong)NSString *product_dp;
/**
 * 商品个数
 */
@property (nonatomic,strong)NSString *carNum;
@end
