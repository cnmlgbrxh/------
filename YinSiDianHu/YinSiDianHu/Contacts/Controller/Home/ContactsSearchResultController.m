//
//  ContactsSearchResultController.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ContactsSearchResultController.h"
#import "ContactDetailViewController.h"
#import "LJContactManager.h"
#import "Tools.h"
@interface ContactsSearchResultController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataSource;

/** 👀 搜索结果 👀 */
@property(nonatomic, copy) NSArray *searchResults;

@end

@implementation ContactsSearchResultController{
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadData];
    
    [self creatUI];
    
}
#pragma mark - 谓词筛选数据
-(void)setStrSearchResults:(NSString *)strSearchResults{
    _strSearchResults = strSearchResults;
    
    self.searchResults = [self getPersonDatas:_strSearchResults];
    [_tableView reloadData];
}
-(NSArray<LJPerson *> *)getPersonDatas:(NSString *)strSearch{
    
    //获取字符串中的数字
    NSString *strNumFromStr = [Tools getNumberFromString:strSearch];
    NSMutableArray *arrm = [NSMutableArray array];
    //nspredicate "*b*m*l*"
    //姓名塞选
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"fullName CONTAINS[cd] %@ or pinyinName CONTAINS[cd] %@ or pinyinName LIKE[cd] '*%@*'",_strSearchResults,_strSearchResults,_strSearchResults];
    [arrm addObjectsFromArray:[self.dataSource filteredArrayUsingPredicate:preicate]];
    
    if (strNumFromStr.length>0)
    {//数字筛选
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"phone CONTAINS[c] %@",strNumFromStr];
        
        for (LJPerson *person in self.dataSource)
        {
            NSArray *arr = [person.phones filteredArrayUsingPredicate:preicate];
            if (arr.count>0)
            {
                [arrm addObject:person];
            }
        }
    }
    return arrm;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ContactDetailViewController *detailVC = [[ContactDetailViewController alloc]init];
    detailVC.person =_searchResults[indexPath.row];
    [_viewController.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    LJPerson *personModel = self.searchResults[indexPath.row];
    
    cell.textLabel.text = personModel.fullName;
    
    LJPhone *phoneModel = personModel.phones.firstObject;
    cell.detailTextLabel.text = phoneModel.phone;
    
    return cell;
}
#pragma mark - 创建UI
-(void)creatUI{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, self.view.height-40) style:UITableViewStylePlain];
    }
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 47;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [UIView new];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
}
#pragma mark - 加载数据
-(void)loadData{
    
    //监听通讯录变化
    [LJContactManager sharedInstance].contactChangeHanlder = ^(BOOL succeed, NSArray<LJPerson *> *newContacts) {
        self.dataSource = newContacts;
    };
    
    [[LJContactManager sharedInstance] accessContactsComplection:^(BOOL succeed, NSArray *datas) {
        
        self.dataSource = datas;
        
//        for (LJPerson *person in datas)
//        {
//            NSLog(@"名字列表：fullName = %@, firstName = %@, lastName = %@", person.fullName, person.familyName, person.givenName);
//            
//            for (LJPhone *model in person.phones)
//            {
//                NSLog(@"号码：phone = %@, label = %@", model.phone,model.label);
//            }
//            
//            for (LJEmail *model in person.emails)
//            {
//                NSLog(@"电子邮件：email = %@, label = %@", model.email, model.label);
//            }
//            
//            for (LJAddress *model in person.addresses)
//            {
//                NSLog(@"地址：address = %@, label = %@", model.city, model.label);
//            }
//            for (LJMessage *model in person.messages)
//            {
//                NSLog(@"即时通讯：service = %@, userName = %@", model.service, model.userName);
//            }
//            
//            NSLog(@"生日：brithdayDate = %@",person.birthday.brithdayDate);
//            
//            for (LJSocialProfile *model in person.socials)
//            {
//                NSLog(@"社交：service = %@, username = %@, urlString = %@", model.service, model.username, model.urlString);
//            }
//            
//            for (LJContactRelation *model in person.relations)
//            {
//                NSLog(@"关联人：label = %@, name = %@", model.label, model.name);
//            }
//            
//            for (LJUrlAddress *model in person.urls)
//            {
//                NSLog(@"URL：label = %@, urlString = %@", model.label,model.urlString);
//            }
//            
//            NSLog(@"---------------------*******------------------------------------");
//        }
    }];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_block) {
        self.block();
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
