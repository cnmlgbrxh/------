//
//  ZeroBuyPayOrderHeadCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/28.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>


#define ZeroBuyPayOrderHeadCellID @"ZeroBuyPayOrderHeadCellID"
#define ZeroBuyPayOrderHeadID @"ZeroBuyPayOrderHeadID"
@interface ZeroBuyPayOrderHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;
@property (weak, nonatomic) IBOutlet UILabel *payTitle;

@end


@interface ZeroBuyPayOrderHead : UITableViewCell

@end
