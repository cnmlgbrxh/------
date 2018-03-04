//
//  QQMoneyConfimPayVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyConfimPayVC.h"
#import "QQMoneyConfirmHeadView.h"
#import "QQMoneyConfirmCell.h"
#import "QQMoneyConfimPayModel.h"


@interface QQMoneyConfimPayVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSIndexPath *seletedIndexP;
@property(nonatomic,strong)QQMoneyConfirmHeadView *headView;
@end

@implementation QQMoneyConfimPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPayList];
}

- (void)getPayList {
    NSArray *nameArray = @[@"微信支付",@"支付宝支付",@"银行卡支付"];
    for (int i = 0; i<nameArray.count; i++) {
        QQMoneyConfimPayModel *model = [[QQMoneyConfimPayModel alloc]init];
        model.imageName = nameArray[i];
        model.titleName = nameArray[i];
        if (i == 0) {
            model.isSelect = YES;
            model.detailName = @"微信钱包";
        }else{
            model.isSelect = NO;
            model.detailName = @"快捷支付";
        }
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQMoneyConfirmCell *cell = [tableView dequeueReusableCellWithIdentifier:QQMoneyConfirmCellID];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        self.seletedIndexP = indexPath;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath != self.seletedIndexP) {
        QQMoneyConfirmCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        QQMoneyConfimPayModel *model = self.dataArray[indexPath.row];
        model.isSelect = YES;
        cell.model = model;
        
        
        QQMoneyConfirmCell *norCell = [tableView cellForRowAtIndexPath:self.seletedIndexP];
        QQMoneyConfimPayModel *model1 = self.dataArray[self.seletedIndexP.row];
        model1.isSelect = NO;
        norCell.model = model1;
        self.seletedIndexP = indexPath;
    }
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nextBtn];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 63;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        self.headView = [[NSBundle mainBundle]loadNibNamed:@"QQMoneyConfirmHeadView" owner:nil options:nil][0];
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, 215);
        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        [_tableView registerNib:[UINib nibWithNibName:@"QQMoneyConfirmCell" bundle:nil] forCellReuseIdentifier:QQMoneyConfirmCellID];
    }
    return _tableView;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setBackgroundColor:[UIColor blackColor]];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"确认投资" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _nextBtn.frame = CGRectMake(0, SCREEN_H-50-64, SCREEN_W, 50);
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (void)nextBtnClick {
    if (self.seletedIndexP.row == 0) {
        NSLog(@"吊起微信支付");
    }else if (self.seletedIndexP.row == 1) {
        NSLog(@"吊起支付宝支付");
    }else{
        NSLog(@"吊起银行卡支付");
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
