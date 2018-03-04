//
//  CellCallHistory.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellCallHistory : UITableViewCell

@property (copy,nonatomic) NSString *strTitle;

@property (copy,nonatomic) NSString *strDetail;

@property (copy,nonatomic) NSString*strPlaceAttribution;

/**
 识别
 */
@property (strong,nonatomic) NSIndexPath *indexPath;

/**
 编辑通话记录的回掉
 */
@property (nonatomic,copy)void (^EditBlock)(NSInteger);

@end




//模糊查询结果cell
@interface CallShowCell : UITableViewCell
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *topLine;
@property (nonatomic,strong)UILabel *bottomLine;
@end
