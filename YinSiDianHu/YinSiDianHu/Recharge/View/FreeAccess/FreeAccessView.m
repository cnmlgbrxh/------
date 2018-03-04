//
//  FreeAccessView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "FreeAccessView.h"
#import "CellFreeAccess.h"
#import "CellProductZone.h"
#import "FreeAccessSectinHeadView.h"
@interface FreeAccessView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation FreeAccessView{
    UITableView *_tableView;
    NSArray *arrData;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HOMECOLOR;
        arrData = @[@[@""],@[@"",@"",@"",@"",@"",@"",@""]];
        [self createUI];
    }
    return self;
}
-(void)createUI{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.x,0, SCREEN_W, self.height-55-49) style:UITableViewStyleGrouped];
    }
    _tableView.backgroundColor = HOMECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 135;
    [self addSubview:_tableView];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    UIImageView *imageV_Head = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, Scale(126))];
    imageV_Head.image = [UIImage imageNamed:@"理财banner"];
    _tableView.tableHeaderView = imageV_Head;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 10;
    }else{
        return 0.000000000000001;
    }
    
}
#pragma mark 自定组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FreeAccessSectinHeadView *sectinHeadView = LoadViewWithNIB(@"FreeAccessSectinHeadView");
    sectinHeadView.strTitle = @"新手体验";
    return sectinHeadView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arrData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrData[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        CellFreeAccess *cell = LoadViewWithNIB(@"CellFreeAccess");
        if (cell == nil) {
            cell = [[CellFreeAccess alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellFreeAccess"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        CellProductZone *cell = LoadViewWithNIB(@"CellProductZone");
        if (cell == nil) {
            cell = [[CellProductZone alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellProductZone"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
@end
