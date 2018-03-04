//
//  QQBaseCollectionVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseCollectionView.h"

@implementation QQBaseCollectionView

- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
}

- (void)hiddenRefresh {
    self.mj_header.hidden = YES;
    self.mj_footer.hidden = YES;
}

- (void)hiddenRefreshHeader {
    self.mj_header.hidden = YES;
}

- (void)hiddenRefreshFooter {
    self.mj_footer.hidden = YES;
}
@end
