//
//  ContactViewController.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/23.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactView.h"
#import "LJContactManager.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "ContactRestrictedView.h"
@interface ContactViewController ()

@end

@implementation ContactViewController{
    ContactView *contactView;
    NSInteger intHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WHITECOLOR;
    
    //搜索制定控制器
    self.definesPresentationContext = YES;
    
    //判断通讯录是否获取授权
    [[LJContactManager sharedInstance] _authorizationStatus:^(BOOL authorization) {
        if (authorization)
        {
            [self createUI];
            [self creatRightBarBtnTitle:@"添加"];
        }else{
            ContactRestrictedView *contactRestrictedView=LoadViewWithNIB(@"ContactRestrictedView");
            contactRestrictedView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
            [self.view addSubview:contactRestrictedView];
        }
    }];
    [self loadData];
}
-(void)setNavTitle:(NSString *)navTitle{
    [super setNavTitle:navTitle];
    intHeight = 54;
}
-(void)loadData{
    
    //监听通讯录变化
    [LJContactManager sharedInstance].sectionContactChangeHanlder = ^(BOOL succeed, NSArray<LJSectionPerson *> *newSectionContacts, NSArray<NSString *> *keys) {
        contactView.dataSource = newSectionContacts;
        contactView.keys = keys;
        DELog(@"监听变化");
    };
    //获取通讯录
    [[LJContactManager sharedInstance] accessSectionContactsComplection:^(BOOL succeed, NSArray<LJSectionPerson *> *contacts, NSArray<NSString *> *keys) {
        
        contactView.dataSource = contacts;
        contactView.keys = keys;
    }];
}
-(void)createUI{
    
    if (!contactView) {
        contactView = [[ContactView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.view.height)];
    }
    //刷新数据
    WeakSelf
    contactView.block = ^{
        [weakSelf loadData];
    };
    if (intHeight != 0) {
        contactView.intHeight = intHeight;
    }
    contactView.viewController = self;
    [self.view addSubview:contactView];
    
}

-(void)backClick
{
    if (_BlockNotice) {
        self.BlockNotice();
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 创建联系人
-(void)RightBarBtnClick{
    [[LJContactManager sharedInstance] createNewContactWithPhoneNum:@""controller:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
