//
//  ContactView.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/23.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ContactView.h"
#import "ContactsSearchResultController.h"
#import "LJPerson.h"
#import "ContactDetailViewController.h"
@interface ContactView ()<UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UISearchController *searchController;

@property (strong,nonatomic) UITableView *tableView;

@property (nonatomic, retain) UIRefreshControl * refreshControl;

@end

@implementation ContactView{
    ContactsSearchResultController *searchResultC;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        [self creatUI];
    }
    return self;
}
-(void)setIntHeight:(NSInteger)intHeight{
    _intHeight = intHeight;
    CGRect frameTableView = _tableView.frame;
    frameTableView.size.height = frameTableView.size.height + _intHeight;
    _tableView.frame = frameTableView;
}
-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
}
-(void)setKeys:(NSArray *)keys{
    _keys = keys;
    [_tableView reloadData];
}
#pragma mark - 创建UI
-(void)creatUI{
    
    searchResultC = [[ContactsSearchResultController alloc]init];
    WeakSelf
    searchResultC.block=^(){
        [weakSelf.searchController.searchBar resignFirstResponder];
    };
    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultC];
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.searchResultsUpdater = self;
    
    _searchController.searchBar.frame = CGRectMake(self.x, 0, SCREEN_W, 44);
    _searchController.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
    
    /// 去除 searchBar 上下两条黑线
    UIImageView *barImageView = [[[_searchController.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor =  [UIColor groupTableViewBackgroundColor].CGColor;
    barImageView.layer.borderWidth = 1;
    
    
    [self addSubview:_searchController.searchBar];
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.x,_searchController.searchBar.height, SCREEN_W, self.height-160) style:UITableViewStylePlain];
    }
    _tableView.backgroundColor = WHITECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 47;
    //索引字体颜色
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self addSubview:_tableView];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [UIColor lightGrayColor];
    [_refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
}
#pragma mark - 刷新数据
-(void)refreshAction
{
    if (_block) {
        self.block();
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_refreshControl endRefreshing]; //结束刷新
    });
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContactDetailViewController *detailVC = [[ContactDetailViewController alloc]init];
    detailVC.navTitle = @"";
    LJSectionPerson *sectionModel = _dataSource[indexPath.section];
    detailVC.person =sectionModel.persons[indexPath.row];
    [_viewController.navigationController pushViewController:detailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000000000000001;
}
#pragma mark 自定组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LJSectionPerson *sectionModel = self.dataSource[section];
    UILabel *lab = [[UILabel alloc]init];
    lab.text = [NSString stringWithFormat:@"   %@", sectionModel.key];
    lab.textColor = [UIColor blackColor];
    //[UIFont fontWithName:@"Helvetica" size:17.0]
    lab.font = [UIFont systemFontOfSize:17];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return lab;
}
#pragma mark 返回索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _keys;
}
#pragma mark 返回每个索引的内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    LJSectionPerson *sectionModel = self.dataSource[section];
    return sectionModel.key;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LJSectionPerson *sectionModel = _dataSource[section];
    return sectionModel.persons.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    LJSectionPerson *sectionModel = _dataSource[indexPath.section];
    LJPerson *personModel = sectionModel.persons[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",personModel.fullName];
    LJPhone *phoneModel = personModel.phones.firstObject;
    cell.detailTextLabel.text = phoneModel.phone;
    
    return cell;
}
#pragma mark - 💉 👀 UISearchResultsUpdating 👀
#pragma mark - 👀 这里主要处理实时搜索的配置 👀 💤
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    searchResultC.strSearchResults = searchController.searchBar.text;
    searchResultC.viewController = _viewController;
}
@end
