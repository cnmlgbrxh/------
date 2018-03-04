//
//  ZeroBuyChooseNumView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZeroBuyChooseNumView : UIView
@property (weak, nonatomic) IBOutlet UIButton *greyView;
@property (nonatomic,strong)void(^zero_buyBtnClickBlock)();
@end
