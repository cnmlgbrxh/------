//
//  ContactsSearchResultController.h
//  YinSiDianHu
//
//  Created by Apple on 2017/6/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJPerson.h"
@interface ContactsSearchResultController : UIViewController

@property (nonatomic,weak) UIViewController *viewController;
///搜索内容
@property(nonatomic, copy) NSString *strSearchResults;
///回调移除搜索器第一响应
@property (copy,nonatomic)void (^block)();

/**
 根据关键字搜索联系人

 @param strSearch 关键字
 @return 结果数组
 */
//-(NSArray<LJPerson *> *)getPersonDatas:(NSString *)strSearch;

@end
