//
//  PurchaseNumberView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PurchaseNumberView.h"
#import "CellPurchaseNumber.h"
#import "PurchaseNumberDetailViewController.h"
@interface PurchaseNumberView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSIndexPath *indexPathBefore;

@end

@implementation PurchaseNumberView{
    UITableView *_tableView;
    
    NSArray *arrSectionHead;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        [self creatUI];
        
    }
    return self;
}
-(void)setArrData:(NSArray *)arrData{
    _arrData = arrData;
    if ([_arrData[0] count] == 0&&[_arrData[1] count] == 0) {
        [[BSNoDataCustomView sharedInstance]showCustormViewToTargetView:self];
        return;
    }
    arrSectionHead = @[@"座机号",@"手机号"];
    if ([_arrData[0] count] == 0) {
        arrSectionHead = @[@"手机号"];
        _arrData = [NSArray arrayWithObject:_arrData[1]];
    }else if ([_arrData[1] count] == 0)
    {
        arrSectionHead = @[@"座机号"];
        _arrData = [NSArray arrayWithObject:_arrData[0]];
    }
    
    [_tableView reloadData];
}
#pragma mark - 创建UI
-(void)creatUI{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.height-69) style:UITableViewStylePlain];
    }
    _tableView.backgroundColor = HOMECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 88;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //_tableView.separatorColor = [UIColor clearColor];
    [self addSubview:_tableView];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.tableFooterView = [UIView new];
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PurchaseNumberDetailViewController *detaiVC = [[PurchaseNumberDetailViewController alloc] init];
    detaiVC.dicDetail = _arrData[indexPath.section][indexPath.row];
    WeakSelf
    detaiVC.BlockSuccess = ^{
        weakSelf.
        indexPathBefore = nil;
        if (weakSelf.BlockSuccess) {
            weakSelf.BlockSuccess();
        }
    };
    [_viewController.navigationController pushViewController:detaiVC animated:YES];
    
    CellPurchaseNumber *cellBefore = (CellPurchaseNumber *)[self viewWithTag:(_indexPathBefore.section+1)*10000+(_indexPathBefore.row+1)];
    cellBefore.isSelect = NO;
    CellPurchaseNumber *cellCurrent = (CellPurchaseNumber *)[self viewWithTag:(indexPath.section+1)*10000+(indexPath.row+1)];
    cellCurrent.isSelect = YES;
    _indexPathBefore = indexPath;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000000000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000000000000001;
}
#pragma mark 自定组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel *lab = [[UILabel alloc]init];
//    lab.text = [NSString stringWithFormat:@"   %@",arrSectionHead[section]];
//    lab.textColor = [Tools getUIColorFromString:@"a2a2a2"];
//    lab.font = [UIFont systemFontOfSize:14];
//    lab.backgroundColor = HOMECOLOR;
    _viewController.title = arrSectionHead[section];
    return nil;
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrData[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellPurchaseNumber *cell = LoadViewWithNIB(@"CellPurchaseNumber");
    if (cell == nil) {
        cell = [[CellPurchaseNumber alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.tag = (indexPath.section+1)*10000+(indexPath.row+1);
    cell.dicDetail = _arrData[indexPath.section][indexPath.row];
    if ([indexPath isEqual:_indexPathBefore]) {
        cell.isSelect = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
