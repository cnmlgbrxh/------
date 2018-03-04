//
//  QQMoneyMyEarningsVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyMyEarningsVC.h"
#import "QQMoneyConfirmHeadView.h"
#import "QQMoneyMyEarningsCell.h"
#import "QQMoneyMyEarningsRecordCell.h"
#import "QQMoneyMyEarningDetailVC.h"
#import "QQMoneyListCell.h"

@interface QQMoneyMyEarningsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)QQMoneyConfirmHeadView *headView;
@property(nonatomic,strong)NSArray *titleArray;
@end

@implementation QQMoneyMyEarningsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0?3:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QQMoneyMyEarningsCell  *cell = [tableView dequeueReusableCellWithIdentifier:QQMoneyMyEarningsCellID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.row = indexPath.row;
        return cell;
    }else{
        QQMoneyMyEarningsRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:QQMoneyMyEarningsRecordCellID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat h = [tableView fd_heightForCellWithIdentifier:QQMoneyMyEarningsCellID configuration:^(QQMoneyMyEarningsCell  *cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
        return h;
    }else{
        return 93;
    }
}

- (void)configureCell:(QQMoneyMyEarningsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.row = indexPath.row;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QQMoneyHeadView *view = [[QQMoneyHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 48)];
    view.titleLabel.text = self.titleArray[section];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QQMoneyMyEarningDetailVC *vc = [[QQMoneyMyEarningDetailVC alloc]initWithNibName:@"QQMoneyMyEarningDetailVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createUI {
    self.title = @"我的增益";
    self.titleArray = @[@"在期增益",@"增益记录"];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"QQMoneyMyEarningsCell" bundle:nil] forCellReuseIdentifier:QQMoneyMyEarningsCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"QQMoneyMyEarningsRecordCell" bundle:nil] forCellReuseIdentifier:QQMoneyMyEarningsRecordCellID];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        self.headView = [[NSBundle mainBundle]loadNibNamed:@"QQMoneyConfirmHeadView" owner:nil options:nil][0];
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, 160);
        self.headView.payStyle.hidden = YES;
        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
