//
//  ZeroBuyMyCenterVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/21.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyMyCenterVC.h"
#import "ZeroBuyAwardRecordCell.h"
#import "ZeroBuyNotAwardCell.h"

@interface ZeroBuyMyCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *exlainView;
@end

@implementation ZeroBuyMyCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentIndex == 1?0:5 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == 2) {
        ZeroBuyAwardRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyAwardRecordCellID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        if (indexPath.row != 0) {
            cell.viewTop.constant = 0;
        }
        return cell;
    }else{
        ZeroBuyNotAwardCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyNotAwardCellID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        if (indexPath.row != 0) {
            cell.viewTop.constant = 0;
        }
        if (indexPath.row %2==0) {
            cell.timeBGView.hidden = YES;
        }else{
            cell.numBGView.hidden = YES;
            cell.buyBtn.hidden = YES;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0?123:113;
}

- (void)createUI {
    self.title = @"我的0元购";
    NSLog(@"当前页面-------%ld",_currentIndex);
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.exlainView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"ZeroBuyAwardRecordCell" bundle:nil] forCellReuseIdentifier:ZeroBuyAwardRecordCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"ZeroBuyNotAwardCell" bundle:nil] forCellReuseIdentifier:ZeroBuyNotAwardCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

- (UIView *)exlainView {
    if (!_exlainView) {
        _exlainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _exlainView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_W-101)/2, 52, 101, 101)];
        imageView.image = QQIMAGE(@"zero_noRecord");
        [_exlainView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,imageView.height+imageView.y+10, SCREEN_W, 15)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"您还没有0元购记录哦！";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [Tools getUIColorFromString:@"cdcdcd"];
        [_exlainView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(imageView.x, label.y+label.height+18, 94, 29);
        btn.backgroundColor = [UIColor blackColor];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"前去逛逛" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [_exlainView addSubview:btn];
    }
    return _exlainView;
}

- (void)btnClick {
    NSLog(@"点击前去逛逛");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
