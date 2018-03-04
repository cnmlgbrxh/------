//
//  QQChangeRecordModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQChangeRecordModel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *imageName;
@property (nonatomic,strong)NSString *goolsStatus;//0:待发货 1：已发货
@end
