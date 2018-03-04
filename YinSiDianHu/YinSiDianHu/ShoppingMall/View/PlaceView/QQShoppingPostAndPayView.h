//
//  QQShoppingPostAndPayView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQShoppingPostAndPayView : UIView
- (void)show;
@property(nonatomic,assign)BOOL isPost;
@property(nonatomic,assign)BOOL isBalance;
@property(nonatomic,copy)void(^shopping_postAndPayBlock)(NSString *stye,NSString *imageName);
@end
