//
//  QQBaseVC.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/4.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingTools.h"
#import "RSWebServiceURL.h"
#import <HYBNetworking/HYBNetworking.h>
#import "BSNoDataCustomView.h"
#import "BSNoDataCustomView.h"
#import "YYModel.h"
#import "QQBaseCollectionView.h"
#import "UITableView+FDTemplateLayoutCell.h"

#define BARTITLEBUTTON(TITLE,SELECTOR) [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

@interface QQBaseVC : UIViewController
- (void)createRightButtenWithTitle:(NSString *)title orImage:(NSString *)imageStr;
@end
