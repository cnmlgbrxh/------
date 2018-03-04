//
//  QQMoneyListVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyListVC.h"
#import "QQMoneyListCell.h"
#import "QQMoneyListSecondCell.h"
#import "QQMoneyListDetail.h"
#import "QQMoneyListModel.h"

@interface QQMoneyListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)QQMoneyListModel *model;
@property(nonatomic,strong)QQMoneyTableHeadView *headView;
@end

@implementation QQMoneyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

- (void)getData {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@",money_productListURL,[UserManager shareManager].userName];
    NSLog(@"理财列表----%@",money_API_CON(urlStr));
    [HYBNetworking getWithUrl:money_API_CON(urlStr) refreshCache:YES success:^(id response) {
        if (response) {
            wSelf.model = [QQMoneyListModel yy_modelWithJSON:response];
            
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQMoneyListProductDetailModel class] json:response[@"matters"]];
            wSelf.model.matters = tempArr;
            
            NSDictionary *dic = response[@"ty"];
            wSelf.model.ty = [QQMoneyListProductDetailModel yy_modelWithDictionary:dic];
            [wSelf.headView.headImage sd_setImageWithURL:[NSURL URLWithString:wSelf.model.img] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
            [wSelf.tableView reloadData];
            [wSelf.tableView.mj_header endRefreshing];
        }
    } fail:^(NSError *error) {
        if (error.code == -1009) {
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-4)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf getData];
            };
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ==0 ?1:self.model.matters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QQMoneyListCell *cell = [tableView dequeueReusableCellWithIdentifier:QQMoneyListCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model.ty;
        return cell;
    }else{
        QQMoneyListSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:QQMoneyListSecondCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model.matters[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0?112:138;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QQMoneyHeadView *view = [[QQMoneyHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 48)];
    view.titleLabel.text = self.titleArray[section];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0?48:41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    QQMoneyListDetail *vc = [[QQMoneyListDetail alloc]init];
//    if (indexPath.section == 0) {
//        self.model.ty.isExperience = YES;
//        vc.model = self.model.ty;
//    }else{
//        NSArray *arr = self.model.matters;
//        vc.model = arr[indexPath.row];
//    }
//    [self.navigationController pushViewController:vc animated:YES];
//    
}

- (void)createUI {
    self.title = @"增益产品";
    self.titleArray = @[@"零钱体验",@"产品专区"];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"QQMoneyListCell" bundle:nil] forCellReuseIdentifier:QQMoneyListCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"QQMoneyListSecondCell" bundle:nil] forCellReuseIdentifier:QQMoneyListSecondCellID];
        self.headView = [[QQMoneyTableHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 126*QQAdapter)];
        _tableView.tableHeaderView = self.headView;
        WS(wSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [wSelf getData];
        }];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
