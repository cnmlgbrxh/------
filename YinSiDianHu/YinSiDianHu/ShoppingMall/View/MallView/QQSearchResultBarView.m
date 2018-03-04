//
//  QQSearchResultBarView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQSearchResultBarView.h"

@implementation QQSearchResultBarView

- (IBAction)backBtnClick:(id)sender {
    if (self.shopping_searchResultBackBlick) {
        self.shopping_searchResultBackBlick();
    }
}

@end
