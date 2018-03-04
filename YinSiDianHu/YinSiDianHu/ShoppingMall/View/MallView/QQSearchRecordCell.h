//
//  QQSearchRecordCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QQSearchRecordCellID @"QQSearchRecordCellID"
#define QQSearchRecordCellClass @"QQSearchRecordCell"
@interface QQSearchRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (nonatomic,copy)void(^shopping_searchRecordDeleteBlock)();
@end
