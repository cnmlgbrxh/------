//
//  QQMoneyListDetailModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQMoneyListDetailModel : NSObject
/**
 *  左边图片
 */
@property (nonatomic,strong)NSString *imageName;
/**
 *  中间文字（如：产品介绍
 */
@property (nonatomic,strong)NSString *title;
/**
 *  右边是箭头还是字
 */
@property (nonatomic,strong)NSString *rightTitle;
@end
