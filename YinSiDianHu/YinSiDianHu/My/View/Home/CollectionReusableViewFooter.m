//
//  CollectionReusableViewFooter.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CollectionReusableViewFooter.h"
#import "TabBarController.h"
@interface CollectionReusableViewFooter ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;

@end

@implementation CollectionReusableViewFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self layout];
}
-(void)layout{
    _layTop.constant = Sc(36);
    _layLeft.constant = Sc(123);
    _layHeight.constant = Sc(90);
}
- (IBAction)exitLogin:(UIButton *)sender {
    UIAlertController *alertConroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出当前账号?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [MessageHUG restoreLoginViewController];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alertConroller addAction:action1];
    [alertConroller addAction:action2];
    [_viewController presentViewController:alertConroller animated:YES completion:^{

    }];
    
}
@end
