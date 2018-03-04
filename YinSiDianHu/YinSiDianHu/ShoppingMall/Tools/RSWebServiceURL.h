//
//  RSWebServiceURL.h
//  park
//
//  Created by songdan on 16/9/23.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  QQ_API_CON(api) [NSString stringWithFormat:@"%@%@",QQDomainURL,api]
#define  Integ_API_CON(api) [NSString stringWithFormat:@"%@%@",QQIntegDomainURL,api]
#define  money_API_CON(api) [NSString stringWithFormat:@"%@%@",QQMoneyDomainURL,api]


/**
 *  普通商城域名
 */
UIKIT_EXTERN NSString *const QQDomainURL;
/**
 *  积分商城域名
 */
UIKIT_EXTERN NSString *const QQIntegDomainURL;
/**
 *  理财域名
 */
UIKIT_EXTERN NSString *const QQMoneyDomainURL;

//--------------理财-----------
/**
 *  理财商品列表
 */
UIKIT_EXTERN NSString *const money_productListURL;


//--------------积分商城-----------
/**
 *  积分商城列表
 */
UIKIT_EXTERN NSString *const integ_mallList;
/**
 *  积分商品列表轮播图
 */
UIKIT_EXTERN NSString *const integ_listBannerURL;
/**
 *  积分商品详情
 */
UIKIT_EXTERN NSString *const integ_produceDetailURL;
/**
 *  获取积分
 */
UIKIT_EXTERN NSString *const integ_getScoreURL;
/**
 *  积分兑换
 */
UIKIT_EXTERN NSString *const integ_changeGoolsURL;
/**
 *  兑换记录
 */
UIKIT_EXTERN NSString *const integ_changeRecordURL;

/**
 *  兑换记录详情
 */
UIKIT_EXTERN NSString *const integ_recordDetailURL;
/**
 *  确认收货
 */
UIKIT_EXTERN NSString *const integ_confimOrderURL;
/**
 *  积分说明
 */
UIKIT_EXTERN NSString *const integ_explainURL;
/**
 *  积分明细
 */
UIKIT_EXTERN NSString *const integ_jifenDetailURL;
//--------------普通商城-----------

/**
 *  商品列表轮播图
 */
UIKIT_EXTERN NSString *const shopping_listBannerURL;
/**
 *  商品列表
 */
UIKIT_EXTERN NSString *const QQProductSmallURL;
/**
 *  搜索商品
 */
UIKIT_EXTERN NSString *const shopping_searchProductURL;
/**
 *  商品详情
 */
UIKIT_EXTERN NSString *const shopping_productDetailURL;
/**
 *  添加收货地址
 */
UIKIT_EXTERN NSString *const shopping_addAddressURL;
/**
 *  收货地址列表
 */
UIKIT_EXTERN NSString *const shopping_addressListURL;
/**
 *  编辑收货地址
 */
UIKIT_EXTERN NSString *const shopping_editAddressURL;
/**
 *  删除收货地址
 */
UIKIT_EXTERN NSString *const shopping_deleteAddressURL;
/**
 *  加入购物车
 */
UIKIT_EXTERN NSString *const shopping_addCarURL;
/**
 *  我的购物车
 */
UIKIT_EXTERN NSString *const shopping_myCarURL;
/**
 *  购物车数量编辑
 */
UIKIT_EXTERN NSString *const shopping_carNumChangeURL;
/**
 *  删除购物车
 */
UIKIT_EXTERN NSString *const shopping_deleteCarURL;
/**
 *  配送方式
 */
UIKIT_EXTERN NSString *const shopping_deliveryURL;
/**
 *  结算页面
 */
UIKIT_EXTERN NSString *const shopping_accountURL;
/**
 *  支付宝支付 alipay
 */
UIKIT_EXTERN NSString *const shopping_alipayURL;
/**
 *  支付宝支付 alipay2
 */
UIKIT_EXTERN NSString *const shopping_alipay2URL;
/**
 *  微信支付
 */
UIKIT_EXTERN NSString *const shopping_wechatPayURL;
/**
 *  订单列表
 */
UIKIT_EXTERN NSString *const shopping_orderListURL;
/**
 *  取消订单
 */
UIKIT_EXTERN NSString *const shopping_cancleOrderURL;
/**
 *  订单详情
 */
UIKIT_EXTERN NSString *const shopping_orderDetailURL;
/**
 *  删除订单
 */
UIKIT_EXTERN NSString *const shopping_deleteOrderURL;
/**
 *  余额支付
 */
UIKIT_EXTERN NSString *const shopping_balancePayURL;
/**
 *  获取余额
 */
UIKIT_EXTERN NSString *const shopping_getBalanceURL;
/**
 *  确认收货
 */
UIKIT_EXTERN NSString *const shopping_confimOrder;
