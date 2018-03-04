//
//  QQSearchResultVC.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseVC.h"

@interface QQSearchResultVC : QQBaseVC
@property (nonatomic,strong)NSString *titleStr;
@property(nonatomic,assign)NSInteger status;//0:root   1:分类页面 2:pop到上一层
@end
