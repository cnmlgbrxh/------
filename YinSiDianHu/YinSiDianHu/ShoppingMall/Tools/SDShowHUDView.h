//
//  SDShowHUDView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDShowHUDView : UIView
+(instancetype)sharedHUDView;
-(void)hidden;
-(void)showImage:(NSString *)imageName withTitle:(NSString *)title;
-(void)showLoading;
@end
