//
//  RSWebServiceURL.m
//  park
//
//  Created by songdan on 16/9/23.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import "RSWebServiceURL.h"

#pragma mark-域名
/**
 *  域名好进行更换     http://ystel.rrtel.com/test/store.php?
 */
/**
 *  http://218.93.127.11主机的
 */
/**
 *  qqtel.dciig.com/store.php
    qqtel.dciig.com/interface.php
    http://money.rrtel.com/index.php/Store/index
 */

//NSString *const QQDomainURL= @"http://money.rrtel.com/index.php/Store/index?";



//NSString *const QQDomainURL= @"http://qqtel.dciig.com/store.php?";
//NSString *const QQIntegDomainURL = @"http://qqtel.dciig.com/integ.php?action=";


NSString *const QQDomainURL= @"http://int.qiqutel.com/store.php?";
NSString *const QQIntegDomainURL = @"http://int.qiqutel.com/integ.php?action=";
NSString *const QQMoneyDomainURL = @"http://int.qiqutel.com/interface_lc.php?action=";


//-------------理财----------------------------
NSString *const money_productListURL = @"product_list&";




//-------------积分商城----------------------------
NSString *const integ_mallList = @"product&";

NSString *const integ_listBannerURL = @"integ_ad&";

NSString *const integ_produceDetailURL = @"product_details&";

NSString *const integ_getScoreURL = @"product&";

NSString *const integ_changeGoolsURL = @"jfpay&";

NSString *const integ_changeRecordURL = @"order&";

NSString *const integ_recordDetailURL = @"ord_details&";

NSString *const integ_confimOrderURL = @"affirm_order&";

NSString *const integ_explainURL = @"explain&";

NSString *const integ_jifenDetailURL = @"paylog&";
//---------普通商城-----------------

NSString *const QQProductSmallURL = @"action=product&";

NSString *const shopping_searchProductURL = @"action=search&";

NSString *const shopping_listBannerURL = @"action=shop_ad&";

NSString *const shopping_productDetailURL = @"action=product_details&pid=";

NSString *const shopping_addAddressURL = @"action=add_addr&";

NSString *const shopping_addressListURL = @"action=address&";

NSString *const shopping_editAddressURL = @"action=edit_addr&";

NSString *const shopping_deleteAddressURL = @"action=del_addr&";

NSString *const shopping_addCarURL = @"action=shop_car&";

NSString *const shopping_myCarURL = @"action=my_car&";

NSString *const shopping_carNumChangeURL = @"action=edit_car&";

NSString *const shopping_deleteCarURL = @"action=del_car&";

NSString *const shopping_deliveryURL = @"action=delivery&";

NSString *const shopping_accountURL = @"action=account&";

NSString *const shopping_alipayURL = @"action=alipay&";

NSString *const shopping_alipay2URL = @"action=alipay2&";

NSString *const shopping_wechatPayURL = @"action=wxpay&";

NSString *const shopping_orderListURL = @"action=order&";

NSString *const shopping_cancleOrderURL = @"action=abolish&";

NSString *const shopping_orderDetailURL = @"action=ord_details&";

NSString *const shopping_deleteOrderURL = @"action=edit_order&";

NSString *const shopping_goolsSendURL = @"action=getOrderTracesByJson";

NSString *const shopping_balancePayURL = @"action=yepay&";

NSString *const shopping_getBalanceURL = @"action=getinfo&";

NSString *const shopping_confimOrder = @"action=affirm_order&";
