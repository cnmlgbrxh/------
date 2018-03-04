//
//  NumData.h
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumData : NSObject

@property (nonatomic,copy) NSString *normal;
@property (nonatomic,copy) NSString *highlight;
@property (nonatomic,assign) NSInteger num;
+(NumData *)getData:(NSInteger)integer;

@end
