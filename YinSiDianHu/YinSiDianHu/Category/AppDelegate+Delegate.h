//
//  AppDelegate+Delegate.h
//
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Delegate)<UIAlertViewDelegate>

- (void)loadLibsWithApplication:(UIApplication *)application WithOptions:(NSDictionary *)launchOptions;

@end
