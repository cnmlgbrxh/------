//
//  ContactDetailViewController.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "ContactDetailView.h"
@interface ContactDetailViewController ()

@end

@implementation ContactDetailViewController{
    ContactDetailView *contactDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}
-(void)setPerson:(LJPerson *)person{
    _person = person;
}
-(void)createUI{
    
    if (!contactDetailView) {
        contactDetailView = [[ContactDetailView alloc]initWithFrame:self.view.frame];
    }
    contactDetailView.person = _person;
    contactDetailView.viewController = self;
    [self.view addSubview:contactDetailView];
    
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
