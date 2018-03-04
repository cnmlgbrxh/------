//
//  LoadWebViewViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/28.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "LoadWebViewViewController.h"

@interface LoadWebViewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *web_View;

@end

@implementation LoadWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL* url = [NSURL URLWithString:URL_HEADER(_strUrl)];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_web_View loadRequest:request];//加载
    
    [DataRequest networkStatus:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            WeakSelf;
            [MessageHUG showSystemAlert:@"没有网络,稍后再来查看吧!" controller:self completion:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}
-(void)setStrUrl:(NSString *)strUrl{
    _strUrl = strUrl;
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
