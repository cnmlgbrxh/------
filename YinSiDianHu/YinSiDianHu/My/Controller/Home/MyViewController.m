//
//  MyViewController.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "MyViewController.h"
#import "MyView.h"

@interface MyViewController ()

@end

@implementation MyViewController{
    MyView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    
    //[self loadData];
    
    [self loadUI];
    
    [self Monitoring];
    
//    // 在init的时候监听状态栏改变的通知 UIApplicationDidChangeStatusBarFrameNotification
//    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(layoutControllerSubViews) name: UIApplicationDidChangeStatusBarFrameNotification object:nil];

    
    
    
}
-(void)Monitoring{
    [DataManager valueChangedForKey:@"刷新用户信息" reuseIdentifier:StringClass changed:^(id object, id oldObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WeakSelf
            //[weakSelf loadData];
        });
    }];
}
#pragma mark - 创建UI
-(void)loadUI{
    if (!view) {
        view = [[MyView alloc]initWithFrame:self.view.frame];
    }
    view.viewController = self;
    [self.view addSubview:view];
}
-(void)loadData{
    NSDictionary *dicParameters = @{@"action":@"getinfo",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS,
                                    @"version":APP_VERSION
                                    };
    [DataRequest POST_Parameters:dicParameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"q:%@",responseObject);
        [UserManager userInfoManager:responseObject];
        view.dicDetail = responseObject;
    }];
}
- (void)dealloc
{
    [DataManager resignCallbackWithReuseIdentifier:StringClass];
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
