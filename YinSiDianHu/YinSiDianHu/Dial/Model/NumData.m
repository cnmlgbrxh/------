//
//  NumData.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "NumData.h"

@implementation NumData

#pragma mark 从plist获取图片
+(NumData *)getData:(NSInteger)integer{
    NumData *data = [[NumData alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NumberList" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *_normalArr = [dic objectForKey:@"normalNum"];
    NSArray *_highlightArr  = [dic objectForKey:@"highlightNum"];
    NSArray *_numArr = [dic objectForKey:@"Num"];
    data.normal = _normalArr[integer];
    data.highlight = _highlightArr[integer];
    data.num = [_numArr[integer] integerValue];
    return data;
}

@end
