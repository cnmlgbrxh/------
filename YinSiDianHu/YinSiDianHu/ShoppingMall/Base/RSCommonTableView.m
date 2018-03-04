//
//  RSCommentTableView.m
//  park
//
//  Created by ZS on 16/9/28.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import "RSCommonTableView.h"
#import "MJRefresh.h"
#import "MJRefreshImageDIYHeader.h"


@interface RSCommonTableView ()
{
    NSInteger _currentPage;
}
@property(nonatomic ,copy) RSCommonTableViewLoadNewData commonTableViewLoadNewData;

@end
@implementation RSCommonTableView

- (instancetype)init{
    if (self = [super init]) {
        _currentPage = 1;
    }
    return self;
}

- (NSInteger)currentPage{
    if (_currentPage < 1) {
        _currentPage = 1;
    }
    return _currentPage;
}


- (void)nextPage{
    _currentPage++;
}

- (void)previousPage{
    if (_currentPage == 1) {
        _currentPage = 1;
    }else{
        _currentPage--;
    }
}

- (void)endRefreshing{
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
}

- (void)changeRefrestStatesNoData:(BOOL)isState
{
    if (isState) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mj_footer resetNoMoreData];
    }
}
- (void)addHeaderRefreshNewData:(void (^)(NSInteger))refreshNewData{
//    WS(wself);
    self.commonTableViewLoadNewData = refreshNewData;
    MJRefreshImageDIYHeader *header = [MJRefreshImageDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(actionLoadNewData)];
    
//    self.mj_header = [MJRefreshImageDIYHeader headerWithRefreshingBlock:^{
//        _currentPage = 1;
//        [wself changeRefrestStatesNoData:NO];
//        if (refreshNewData) {
//            refreshNewData(wself.currentPage);
//        }
//    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.stateLabel.textColor = COLOR(150, 150, 150);
    header.lastUpdatedTimeLabel.textColor =  COLOR(150, 150, 150);
    self.mj_header = header;
    self.mj_header.automaticallyChangeAlpha = YES;
}

- (void)actionLoadNewData{
    _currentPage = 1;
    if (self.commonTableViewLoadNewData) {
        self.commonTableViewLoadNewData(self.currentPage);
    }
}

- (void)addFooterRefreshMoreData:(void (^)(NSInteger))refreshMoreData{
     WS(wself);
    if (!self.mj_footer) {
        MJRefreshAutoNormalFooter *normalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (refreshMoreData) {
                refreshMoreData(wself.currentPage);
            }
        }];
        normalFooter.stateLabel.textColor = COLOR(150, 150, 150);
        [normalFooter setTitle:@"结束啦" forState:MJRefreshStateNoMoreData];
        self.mj_footer = normalFooter;
        self.mj_footer.automaticallyHidden = YES;
    }
}

- (void)tableViewDataBeginRefresh{
    [self.mj_header beginRefreshing];
}

- (NSMutableArray *)arrayMutableData{
    if (!_arrayMutableData) {
        _arrayMutableData = [NSMutableArray array];
    }
    return _arrayMutableData;
}

- (void)removeAllDataInArray{
    if (self.arrayMutableData.count != 0 && self.currentPage == 1) {
        [self.arrayMutableData removeAllObjects];
    }
}

- (void)hiddenFoot{
    if (self.mj_footer.hidden == NO) {
        self.mj_footer.hidden = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
