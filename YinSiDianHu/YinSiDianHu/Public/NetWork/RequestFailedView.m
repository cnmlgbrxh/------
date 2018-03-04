//
//  RequestFailedView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/21.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "RequestFailedView.h"

@implementation RequestFailedView

- (IBAction)reloadClick:(UIButton *)sender {
    if (_blockRefreshData) {
        self.blockRefreshData();
    }
}

@end
