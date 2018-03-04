//
//  QQShoppingIntegralModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingIntegralModel : NSObject
/**
 *  需要的积分
 */
@property (nonatomic,strong)NSString *integralPrice;

/**
 *  剩余的商品数
 */
@property (nonatomic,strong)NSString *numCount;
@property (nonatomic,strong)NSString *imageName;
/**
 *  是否售完
 */
@property (nonatomic,assign)BOOL isSellAll;
@end
