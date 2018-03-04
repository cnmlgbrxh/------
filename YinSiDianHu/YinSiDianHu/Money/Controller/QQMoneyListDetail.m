//
//  QQMoneyListDetail.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyListDetail.h"
#import "QQMoneyDetailHeadView.h"
#import "QQMoneyListDetailModel.h"
#import "QQMoneyDetaiSecondTitleView.h"
#import "QQMoneyConfimPayVC.h"
#import "QQMoneyPartChooseView.h"

@interface QQMoneyListDetail ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)QQMoneyDetailHeadView *headView;
@end

@implementation QQMoneyListDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getListData];
}

- (void)getListData {
    NSArray *imageArray = @[@"money_detail_ introduce",@"money_detail_people",@"money_detail_safe",@"money_detail_explan",@"money_detail_compack",@"money_detail_ protocol",@"money_detail_question"];
    NSArray *titleArray = @[@"产品介绍",@"已投标人数",@"安全保障",@"购买说明",@"产品合同",@"相关协议",@"常见问题"];
    for (int i = 0; i<titleArray.count; i++) {
        QQMoneyListDetailModel *model = [[QQMoneyListDetailModel alloc]init];
        model.imageName = imageArray[i];
        model.title = titleArray[i];
        model.rightTitle = @"money_detail_downArror";
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        QQMoneyListDetailModel *model = self.dataArray[section-1];
        if (section == 1 && [model.rightTitle isEqualToString:@"money_detail_upArror"]) {
            return 1;
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQMoneyListDetailModel *model = self.dataArray[indexPath.section];
    if (indexPath.section == 0) {
        QQMoneyDetailHeadView *view = [tableView dequeueReusableCellWithIdentifier:QQMoneyDetailHeadViewID];
        return view;
    }else if (indexPath.section == 1 && [model.rightTitle isEqualToString:@"money_detail_upArror"]) {
        QQMoneyDetailExplain *cell = [tableView dequeueReusableCellWithIdentifier:QQMoneyDetailExplainID];
        cell.titleLabel.text = @"吃测试测试大地府泡温泉认为奇瑞请问如此苗侨伟UR犬瘟热七日内吃测试测试大地府泡温泉认为奇瑞请问如此苗侨伟UR犬瘟热七日内";
        return cell;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat h = [tableView fd_heightForCellWithIdentifier:QQMoneyDetailHeadViewID configuration:^(QQMoneyDetailHeadView  *cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
        return h;

    }else{
        QQMoneyListDetailModel *model = self.dataArray[indexPath.section];
        if (indexPath.section == 1 && [model.rightTitle isEqualToString:@"money_detail_upArror"]) {
            CGFloat height = [[QQShoppingTools shareInstance] calculateRowHeight:@"吃测试测试大地府泡温泉认为奇瑞请问如此苗侨伟UR犬瘟热七日内吃测试测试大地府泡温泉认为奇瑞请问如此苗侨伟UR犬瘟热七日内" fontSize:14 bgViewWidth:SCREEN_W-20];
            return height+40;
        }else{
            return 0;
        }
    }
}

- (void)configureCell:(QQMoneyDetailHeadView *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.model;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        QQMoneyDetaiSecondTitleView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"QQMoneyDetaiSecondTitleViewID"];
        QQMoneyListDetailModel *model  = self.dataArray[section-1];
        if (section == 1) {
            model.rightTitle = @"2000";
        }
        view.model = model;
        view.money_detailShowMoreBlock = ^(NSString *rightTitle) {
            model.rightTitle = rightTitle;
            NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:section];
            [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0?0:57;
}

- (void)createUI {
    self.title = self.model.pro_name;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nextBtn];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
//        self.headView = [[NSBundle mainBundle]loadNibNamed:@"QQMoneyDetailHeadView" owner:nil options:nil][0];
//        self.headView.model = self.model;
//        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        [_tableView registerNib:[UINib nibWithNibName:@"QQMoneyDetaiSecondTitleView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"QQMoneyDetaiSecondTitleViewID"];
        [_tableView registerClass:[QQMoneyDetailExplain class] forCellReuseIdentifier:QQMoneyDetailExplainID];
        [_tableView registerNib:[UINib nibWithNibName:@"QQMoneyDetailHeadView" bundle:nil] forCellReuseIdentifier:QQMoneyDetailHeadViewID];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    }
    return _tableView;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setBackgroundColor:[UIColor blackColor]];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"立即投资" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _nextBtn.frame = CGRectMake(0, SCREEN_H-50-64, SCREEN_W, 50);
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)nextBtnClick {
    WS(wSelf);
    QQMoneyPartChooseView *view = [[QQMoneyPartChooseView alloc]init];
    __weak __typeof(&*view)wView = view;
    view.money_chooseNumBlock = ^(NSString *price) {
        [wView hide];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            QQMoneyConfimPayVC *vc = [[QQMoneyConfimPayVC alloc]init];
            vc.title = wSelf.title;
            [wSelf.navigationController pushViewController:vc animated:YES];
        });
    };
    [view show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
