//
//  UploadPhoto.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UploadPhoto : UIView

+ (instancetype)sharedClient;

-(void)choosePhotoForViewController:(UIViewController *)viewController getPhoto:(void (^)(UIImage *selectImage, NSDictionary *responseObject))photo;

@end
