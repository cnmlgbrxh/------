//
//  ZeroBuyDetailHeadCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZeroBuyDetailHeadCellID @"ZeroBuyDetailHeadCellID"
#define ZeroBuyDetailTitleCellID @"ZeroBuyDetailTitleCellID"
#define ZeroBuyDetailImageCellID @"ZeroBuyDetailImageCellID"
@interface ZeroBuyDetailHeadCell : UITableViewCell
@property(nonatomic,copy)void(^zero_imageDetailBlock)(NSInteger currentIndex);
@end


@interface ZeroBuyDetailTitleCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@end

@interface ZeroBuyDetailImageCell : UITableViewCell

@end
