//
//  QQShoppingSendStyleModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQShoppingSendStyleModel : NSObject
/**
 *  快递名
 */
@property (nonatomic,strong)NSString *dname;
/**
 *  描述
 */
@property (nonatomic,strong)NSString *sendDescription;
/**
 *  快递id
 */
@property (nonatomic,strong)NSString *sendID;
@end
