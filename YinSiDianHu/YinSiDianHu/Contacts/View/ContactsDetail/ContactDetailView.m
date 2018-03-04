//
//  ContactDetailView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ContactDetailView.h"
#import "CellIPhoneNumber.h"
#import "TalkingViewController.h"
#import "ContactModel.h"
#import "CallHistory.h"
#import "CallManager.h"
@interface ContactDetailView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ContactDetailView{
    UITableView *_tableView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return self;
}
-(void)setPerson:(LJPerson *)person{
    _person = person;
    [self creatUI];
}
#pragma mark - 创建UI
-(void)creatUI{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.height-64) style:UITableViewStylePlain];
    }
    _tableView.backgroundColor = WHITECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 64;
    [self addSubview:_tableView];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    CGFloat width = SCREEN_W/19*4.5;
    UIView *viewTableViewHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H/4)];
    
    UIImageView *imageVHeader = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_W-width)/2, 17.5, width, width)];
    if (_person.thumbnailImage) {
        imageVHeader.image = _person.thumbnailImage;
    }else{
        imageVHeader.image = [UIImage imageNamed:@"DefaultAvatar"];
    }
    
    imageVHeader.layer.cornerRadius = width/2;
    imageVHeader.layer.masksToBounds = YES;
    [viewTableViewHead addSubview:imageVHeader];
    
    UILabel *labName = [[UILabel alloc]init];
    labName.text = _person.fullName;
    labName.font = [UIFont systemFontOfSize:28];
    [labName sizeToFit];
    labName.origin = CGPointMake(0, imageVHeader.y+imageVHeader.height+9);
    labName.centerX = self.centerX;
    //labName.backgroundColor = [UIColor orangeColor];
    [viewTableViewHead addSubview:labName];
    
    viewTableViewHead.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = viewTableViewHead;
    
    if (_person.phones.count>0) {
        UIView *viewTableViewFoot = [[UIView alloc]initWithFrame:CGRectMake(16, 0, SCREEN_W-16, 0.3)];
        viewTableViewFoot.backgroundColor = COLOR(221, 220, 223);
        _tableView.tableFooterView = viewTableViewFoot;
    }
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *strIphoneNum = _person.phones[indexPath.row].phone;
    
    if (USERMANAGER.isEnhancedCall)
    {
        //[CallManager enhancedCall:_viewController iphone:strIphoneNum];
        [CallManager enhancedCall:_viewController iphone:strIphoneNum Status:^(BOOL authorization) {
        }];
    }else
    {
        ContactModel *contactModel = [[ContactModel alloc]init];
        contactModel.name = _person.fullName;
        contactModel.phoneNumber =strIphoneNum;
        [CallManager callbackViewController:_viewController ContactModel:contactModel iphone:strIphoneNum Status:^(BOOL authorization) {
            
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000000000000001;
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_person.phones count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellIPhoneNumber *cell = LoadViewWithNIB(@"CellIPhoneNumber");
    if (cell == nil) {
        cell = [[CellIPhoneNumber alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.phoneNumber = _person.phones[indexPath.row];
    return cell;
}
@end
