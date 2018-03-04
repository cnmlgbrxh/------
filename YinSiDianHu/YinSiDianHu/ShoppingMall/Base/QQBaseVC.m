//
//  QQBaseVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/4.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseVC.h"
@interface QQBaseVC ()

@end

@implementation QQBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self createLeftButten];
    self.view.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
}

- (void)createLeftButten {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"shopping_arrow"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shopping_arrow"] forState:UIControlStateHighlighted];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.size = CGSizeMake(40, 30);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //        [button sizeToFit];
    // 让按钮的内容往左边偏移10
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)createRightButtenWithTitle:(NSString *)title  orImage:(NSString *)imageStr{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title.length > 0 && title!= nil) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[Tools getUIColorFromString:@"3b3b3b"] forState:UIControlStateNormal];
    }else{
        [button setImage:QQIMAGE(imageStr) forState:UIControlStateNormal];
    }
    button.size = CGSizeMake(40, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [button addTarget:self action:@selector(rightBarButtenClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)createUI {
}

- (void)rightBarButtenClick {
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"释放啦释放啦");
}


@end













