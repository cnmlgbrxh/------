//
//  ContactRestrictedView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ContactRestrictedView.h"

@interface ContactRestrictedView ()

@end
@implementation ContactRestrictedView
- (IBAction)goOpen:(UIButton *)sender {
    
    
    //iOS系统版本 >= 10.0
    if (IOS_VERSION>=10)
    {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication] canOpenURL:url] ) {
            [[UIApplication sharedApplication] openURL:url options:@{}completionHandler:^(BOOL success) {
                
            }];
        }
    }else
    {
        NSURL *url = [NSURL URLWithString:@"prefs:root=Privacy&path=CONTACTS"];
        if( [[UIApplication sharedApplication] canOpenURL:url] ) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    
    
    //    if (IOS_VERSION>10) {
    //        NSString *urlString = @"Prefs:root=General&path=About";
    //
    //        NSURL*url=[NSURL URLWithString:urlString];
    //
    //        Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
    //
    //        [[LSApplicationWorkspace performSelector:@selector(defaultWorkspace)] performSelector:@selector(openSensitiveURL:withOptions:) withObject:url withObject:nil];
    //    }else{
    //        NSURL *url = [NSURL URLWithString:@"prefs:root=Privacy&path=CONTACTS"];
    //        BOOL isOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //        if (isOpen)
    //        {
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
    //    }
    //
    //    //ios系统版本 < 10.0
    

}



@end
