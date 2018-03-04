//
//  QQSearchRecordVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQSearchRecordVC.h"
#import "QQSearchRecordCell.h"
#import "UIImage+image.h"
#import "QQSearchResultVC.h"

@interface QQSearchRecordVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation QQSearchRecordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.searchBar) {
        [self.searchBar becomeFirstResponder];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.dataArray = [NSMutableArray arrayWithArray:[[QQShoppingTools shareInstance] getCacheRecord]];
}

#pragma mark ---- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQSearchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:QQSearchRecordCellID];
    cell.titleLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    if (self.dataArray.count-1 == indexPath.row) {
        cell.line.hidden = YES;
    }else{
        cell.line.hidden = NO;
    }
    WS(wSelf);
    cell.shopping_searchRecordDeleteBlock = ^(){
        [wSelf.dataArray removeObjectAtIndex:indexPath.row];
        [[QQShoppingTools shareInstance] cacheRecord:wSelf.dataArray];
        [wSelf.tableView reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 35)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 100, 35)];
    label.text = @"最近搜索";
    label.textColor = [Tools getUIColorFromString:@"b3b3b3"];
    label.font = [UIFont systemFontOfSize:13];
    [view addSubview:label];
    view.backgroundColor = [UIColor clearColor];
    if (self.dataArray.count == 0) {
        view.hidden = YES;
    }else{
        view.hidden = NO;
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"清除所有搜索记录" forState:UIControlStateNormal];
    [btn setTitleColor:[Tools getUIColorFromString:@"b3b3b3"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteAllBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    if (self.dataArray.count == 0) {
        btn.hidden = YES;
    }else{
        btn.hidden = NO;
    }
    return btn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.dataArray.count>0?40:0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QQSearchRecordCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    QQSearchResultVC *vc = [[QQSearchResultVC alloc]init];
    vc.titleStr = cell.titleLabel.text;
//    vc.status = self.status;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---- searchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (![self.dataArray containsObject:searchBar.text]) {
        [self.dataArray addObject:searchBar.text];
        [[QQShoppingTools shareInstance] cacheRecord:self.dataArray];
    }
    [self.tableView reloadData];
    QQSearchResultVC *vc = [[QQSearchResultVC alloc]init];
    vc.titleStr = searchBar.text;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---- UI
- (void)createUI {
    self.view.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [self.view addSubview:self.topView];
    [self setLayout];
    [self.view addSubview:self.tableView];
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
        self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.cancleBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:self.cancleBtn];
        
        self.searchBar = [[UISearchBar alloc]init];
        self.searchBar.placeholder = @"搜索";
        [self.searchBar setBackgroundImage:[UIImage createImageWithColor:[Tools getUIColorFromString:@"f7f7f7"]  ]];
        [self.searchBar setBackgroundColor:[UIColor clearColor]];
        [self.searchBar setSearchFieldBackgroundImage:QQIMAGE(@"shopping_search_bg") forState:UIControlStateNormal];
        self.searchBar.delegate = self;
        [_topView addSubview:self.searchBar];
    }
    return _topView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:QQSearchRecordCellClass bundle:nil] forCellReuseIdentifier:QQSearchRecordCellID];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)setLayout {
    WS(wSelf);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.view).mas_offset(10);
        make.height.mas_equalTo(64);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.topView).mas_offset(-15);
        make.centerY.equalTo(wSelf.topView);
        make.width.mas_equalTo(40);
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.topView).mas_offset(10);
        make.centerY.mas_equalTo(wSelf.topView);
        make.right.mas_equalTo(wSelf.cancleBtn.mas_left).mas_offset(0);
    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteAllBtnClick {
    [self.dataArray removeAllObjects];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:searchRecordKey];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog( @"释放啦释放啦");
}
@end
