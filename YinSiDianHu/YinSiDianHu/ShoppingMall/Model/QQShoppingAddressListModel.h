//
//  QQShoppingAddressListModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingAddressListModel : NSObject
/**
 *  地址id
 */
@property (nonatomic,strong)NSString *aid;
/**
 *  详细地址
 */
@property (nonatomic,strong)NSString *caddr;
/**
 *  收货人-姓名
 */
@property (nonatomic,strong)NSString *cname;
/**
 *  收货人-电话
 */
@property (nonatomic,strong)NSString *cphone;
/**
 *  收货人-邮编
 */
@property (nonatomic,strong)NSString *cpostcode;
/**
 *  收货人-配送地区
 */
@property (nonatomic,strong)NSString *czone;
/**
 *  默认地址？ 0:不是  1：是
*/
@property (nonatomic,strong)NSString *is_common;
/**
 *  用户名
 */
@property (nonatomic,strong)NSString *username;
@end
