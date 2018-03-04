//
//  ZeroBuyNotAwardCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZeroBuyNotAwardCellID @"ZeroBuyNotAwardCellID"
@interface ZeroBuyNotAwardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTop;
@property (weak, nonatomic) IBOutlet UIView *timeBGView;
@property (weak, nonatomic) IBOutlet UIView *numBGView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end
