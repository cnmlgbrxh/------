//
//  QQShoppingConfirmModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingConfirmModel : NSObject
/**
 姓名
 */
@property(nonatomic,strong)NSString *name;
/**
 手机号
 */
@property(nonatomic,strong)NSString *phoneNum;
/**
 地址
 */
@property(nonatomic,strong)NSString *place;
/**
 详情地址：街道信息
 */
@property(nonatomic,strong)NSString *placeDetail;
/**
是否设为默认地址
 */
@property(nonatomic,assign)BOOL defPlace;//是否设为默认地址
@end
