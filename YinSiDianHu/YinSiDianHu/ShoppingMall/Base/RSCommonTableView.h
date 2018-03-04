//
//  RSCommentTableView.h
//  park
//
//  Created by ZS on 16/9/28.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RSCommonTableViewLoadNewData)(NSInteger);
@interface RSCommonTableView : UITableView

/**
 *  上一页
 */
- (void)previousPage;
//当前页面
@property(nonatomic ,assign) NSInteger currentPage;
/**
 *  下一页
 */
- (void)nextPage;

//下拉刷新
-(void)addHeaderRefreshNewData:(void(^)(NSInteger currentPage))refreshNewData;
//上拉加载更多
-(void)addFooterRefreshMoreData:(void(^)(NSInteger currentPage))refreshMoreData;;
//停止刷新
-(void)endRefreshing;

//进行自动刷新的
- (void)tableViewDataBeginRefresh;

//改变显示文字的刷新状态
- (void)changeRefrestStatesNoData:(BOOL)isState;
/**
 *  数据源
 */
@property(nonatomic ,strong) NSMutableArray  *arrayMutableData;

- (void)removeAllDataInArray;


- (void)hiddenFoot;



@property(nonatomic ,assign) BOOL refreshStates;

@end
