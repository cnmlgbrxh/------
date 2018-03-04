//
//  QQMoneyConfimPayModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/16.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQMoneyConfimPayModel : NSObject
/**
 *  是否选中
 */
@property (nonatomic,assign)BOOL isSelect;
/**
 *  图片
 */
@property (nonatomic,strong)NSString *imageName;
/**
 *  大标题（支付宝支付
 */
@property (nonatomic,strong)NSString *titleName;
/**
 *  副标题
 */
@property (nonatomic,strong)NSString *detailName;
@end
