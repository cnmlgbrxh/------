//
//  ZeroBuyConfirmOrderPriceCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/28.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>


#define ZeroBuyConfirmOrderPriceCellID @"ZeroBuyConfirmOrderPriceCellID"
@interface ZeroBuyConfirmOrderPriceCell : UITableViewCell
@property (nonatomic,copy)void(^zero_confirmPriceBlock)(NSString *price);
@end
