//
//  PurchaseNumberViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PurchaseNumberViewController.h"
#import "PurchaseNumberView.h"
@interface PurchaseNumberViewController ()

@end

@implementation PurchaseNumberViewController{
    PurchaseNumberView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadData];
    
    [self loadUI];
}
#pragma mark - 创建UI
-(void)loadUI{
    if (!view) {
        view = [[PurchaseNumberView alloc]initWithFrame:self.view.frame];
    }
    view.viewController = self;
    WeakSelf
    view.BlockSuccess = ^{
        [weakSelf loadData];
    };
    [self.view addSubview:view];
}
-(void)loadData{
    NSDictionary *dicParameters = @{@"action":@"didnumber",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS
                                    };
    [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *arrm1 = [NSMutableArray array];
        NSMutableArray *arrm2 = [NSMutableArray array];
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *strNumber = [obj objectForKey:@"name"];
            if ([[strNumber substringToIndex:1] integerValue]==0||[[strNumber substringToIndex:1] integerValue]==4) {
                [arrm1 addObject:obj];
                if (arrm1.count>0) {
                    self.title = @"座机号";
                }
            }else{
                [arrm2 addObject:obj];
            }
            
        }];
        view.arrData = @[arrm1,arrm2];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
