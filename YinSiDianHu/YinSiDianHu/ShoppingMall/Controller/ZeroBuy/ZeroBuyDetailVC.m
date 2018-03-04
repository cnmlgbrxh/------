//
//  ZeroBuyDetailVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyDetailVC.h"
#import "ZeroBuyDetailHeadCell.h"
#import "ZeroBuyDetailFootView.h"
#import "ZeroBuyJoinRecordCell.h"
#import "ZeroBuyChooseNumView.h"
#import "ZeroBuyConfirmVC.h"

@interface ZeroBuyDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ZeroBuyDetailHeadCell *headView;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)ZeroBuyDetailFirstFootView *firstFootView;
@property(nonatomic,assign)NSInteger currentIndex;//0:图文详情  1:参与记录 2:往期中奖
@end

@implementation ZeroBuyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == 0) {
        if (indexPath.row == 0) {
            ZeroBuyDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyDetailTitleCellID];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            cell.titleLabel.text = self.titleStr;
            return cell;
        }else{
            ZeroBuyDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyDetailImageCellID];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            return cell;
        }
    }else  {
        ZeroBuyJoinRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyJoinRecordCellID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.currentIndex = self.currentIndex;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == 0) {
        CGFloat height = [[QQShoppingTools shareInstance] calculateRowHeight:self.titleStr fontSize:14 bgViewWidth:SCREEN_W-20];
        return indexPath.row == 0?height:SCREEN_W*0.5;
    }else {
        return self.currentIndex == 1?85:115;
    }
}

- (void)createUI {
    self.title = @"我的0元购";
    self.titleStr = @"中国电信、中国联通、中国移动。中国电信、中国联通、中国移动。中国电信、中国联通、中国移动。中国电信、中国联通、中国移动。中国电信、中国联通、中国移动。中国电信、中国联通、中国移动。中国电信、中国联通、中国移动。中国电信、中国联通、中国移动。";
    self.currentIndex = 0;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footView];
    [self.view addSubview:self.firstFootView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-54-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        ;
        _tableView.dataSource = self;
        self.headView = [[NSBundle mainBundle]loadNibNamed:@"ZeroBuyDetailHeadCell" owner:nil options:nil][0];
        WS(wSelf);
        self.headView.zero_imageDetailBlock = ^(NSInteger currentIndex){
            [wSelf setFootViewHidden:currentIndex];
        };
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, 432);
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        [_tableView registerClass:[ZeroBuyDetailTitleCell class] forCellReuseIdentifier:ZeroBuyDetailTitleCellID];
        [_tableView registerClass:[ZeroBuyDetailImageCell class] forCellReuseIdentifier:ZeroBuyDetailImageCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"ZeroBuyJoinRecordCell" bundle:nil] forCellReuseIdentifier:ZeroBuyJoinRecordCellID];
    }
    return _tableView;
}

- (void)setFootViewHidden:(NSInteger)currentIndex {
    self.currentIndex = currentIndex;
    self.firstFootView.hidden = currentIndex==1?YES:NO;
    self.footView.hidden = currentIndex==1?NO:YES;
    [self.tableView reloadData];
}

- (UIView *)footView {
    if (!_footView) {
        _footView = [[NSBundle mainBundle]loadNibNamed:@"ZeroBuyDetailFootView" owner:nil options:nil][0];
        _footView.frame = CGRectMake(0, SCREEN_H-55-64, SCREEN_W, 55);
        _footView.hidden = YES;
    }
    return _footView;
}

- (ZeroBuyDetailFirstFootView *)firstFootView {
    if (!_firstFootView) {
        _firstFootView = [[ZeroBuyDetailFirstFootView alloc]initWithFrame:CGRectMake(0, SCREEN_H-55-64, SCREEN_W, 55)];
        WS(wSelf);
        _firstFootView.zero_firstBtnJoinBlock = ^{
            ZeroBuyChooseNumView *view = [[NSBundle mainBundle]loadNibNamed:@"ZeroBuyChooseNumView" owner:nil options:nil][0];
            view.backgroundColor = [UIColor clearColor];
            view.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H);
            [wSelf.view addSubview:view];
            view.greyView.frame = CGRectMake(0, -SCREEN_H, SCREEN_W, view.greyView.height);
            view.greyView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                view.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H-64);
                view.greyView.frame = CGRectMake(0,0, SCREEN_W, view.greyView.height);
                view.greyView.alpha = 0.5;
            } completion:^(BOOL finished) {
            }];
            view.zero_buyBtnClickBlock = ^{
                ZeroBuyConfirmVC *vc = [[ZeroBuyConfirmVC alloc]init];
                [wSelf.navigationController pushViewController:vc animated:YES];
            };
        };
    }
    return _firstFootView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
