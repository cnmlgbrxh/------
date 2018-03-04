//
//  DeleagteViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/28.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "DeleagteViewController.h"
#import "UIBarButtonItem+BarButtonItem.h"

@interface DeleagteViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *web_View;

@end

@implementation DeleagteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"用户服务协议";
    
    NSURL* url = [NSURL URLWithString:URL_HEADER(_strUrl)];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_web_View loadRequest:request];//加载
    
    [self creatLeftBarBtn];
    
}
-(void)setStrUrl:(NSString *)strUrl{
    _strUrl = strUrl;
}
-(void)creatLeftBarBtn{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"shopping_arrow" highImage:@"shopping_arrow" target:self action:@selector(backClick)];
}
-(void)backClick{
    [self dismissViewControllerAnimated:NO completion:nil];
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
