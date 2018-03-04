//
//  AppDelegate.h
//  ShiZhiBao
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

