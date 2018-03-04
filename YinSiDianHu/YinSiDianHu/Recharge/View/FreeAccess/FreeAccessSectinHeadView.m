//
//  FreeAccessSectinHeadView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/23.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "FreeAccessSectinHeadView.h"

@interface FreeAccessSectinHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@end
@implementation FreeAccessSectinHeadView

-(void)setStrTitle:(NSString *)strTitle{
    _strTitle = strTitle;
    _labTitle.text = _strTitle;
}

@end
