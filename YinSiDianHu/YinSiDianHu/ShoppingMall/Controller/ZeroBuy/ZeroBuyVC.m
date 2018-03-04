//
//  ZeroBuyVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/21.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyVC.h"
#import "SDCycleScrollView.h"
#import "ZeroBuyHotCell.h"
#import "ZeroBuyWillStartCell.h"
#import "ZeroBuyStartModel.h"
#import "ZeroBuyCenterViewController.h"
#import "ZeroBuyDetailVC.h"

@interface ZeroBuyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)SDCycleScrollView   *cycleScrollView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,assign)BOOL isHot;
@property(nonatomic,strong)NSArray *timeArray;
@property(nonatomic,strong)NSMutableArray *endTimeArray;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation ZeroBuyVC
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setModelTime];
}

- (void)setModelTime {
    self.timeArray = @[@"1501496400",@"1504174800",@"1501582800",@"1504174800",@"1501582800",@"1504174800",@"1501582800",@"1504174800",@"1501582800"];
    for (int i = 0; i<self.timeArray.count; i++) {
        ZeroBuyStartModel *model = [[ZeroBuyStartModel alloc]init];
        model.endTime = self.timeArray[i];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval time=[self.timeArray[i] doubleValue];//如果时差问题加8小时 == 28800 sec  我没加
        NSDate *endDate_tomorrow=[NSDate dateWithTimeIntervalSince1970:time];
        
        NSDate *startDate = [NSDate date];
        NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
        
        model.interval = timeInterval;
        [self.endTimeArray addObject:model];
    }
    
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES ];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)timeChange {
        for (int i = 0; i<self.endTimeArray.count; i++) {
            ZeroBuyStartModel *model = self.endTimeArray[i];
            model.interval =model.interval>0?--model.interval:0;
        }
        [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.endTimeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHot) {
        ZeroBuyHotCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyHotCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ZeroBuyWillStartCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyWillStartCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZeroBuyStartModel *model = self.endTimeArray[indexPath.row];
        cell.timeInterval = model.interval;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 116;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    [self.headView addSubview:self.bgView];
    [self.bgView addSubview:self.leftBtn];
    [self.bgView addSubview:self.rightBtn];
    [self.bgView addSubview:self.line];
    [self setAutoLayout];
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZeroBuyDetailVC *vc = [[ZeroBuyDetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createUI {
    self.title = @"0元购";
    self.isHot = YES;
    [self createRightButtenWithTitle:nil orImage:@"zero_center"];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableHeaderView = self.cycleScrollView;
        [_tableView registerNib:[UINib nibWithNibName:@"ZeroBuyHotCell" bundle:nil] forCellReuseIdentifier:ZeroBuyHotCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"ZeroBuyWillStartCell" bundle:nil] forCellReuseIdentifier:ZeroBuyWillStartCellID];
    }
    return _tableView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView){
        _cycleScrollView = [ SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, 146) imageURLStringsGroup:nil];
        _cycleScrollView.placeholderImage = QQIMAGE(@"");
        _cycleScrollView.currentPageDotColor =[Tools getUIColorFromString:@"0xd22120"];
        _cycleScrollView.pageDotColor = WHITECOLOR;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.localizationImageNamesGroup = @[@"zero_banner"];
    }
    return _cycleScrollView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return _headView;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"热门" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[Tools getUIColorFromString:@"9c9c9c"] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"即将开奖" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[Tools getUIColorFromString:@"9c9c9c"] forState:UIControlStateNormal];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(52, 49, 72, 1)];
        _line.backgroundColor = [Tools getUIColorFromString:@"ed4044"];
    }
    return _line;
}

- (NSMutableArray *)endTimeArray {
    if (!_endTimeArray) {
        _endTimeArray = [[NSMutableArray alloc]init];
    }
    return _endTimeArray;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (void)setAutoLayout {
    WS(wSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(wSelf.headView);
        make.height.mas_equalTo(50);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(52);
        make.width.mas_equalTo(72);
        make.centerY.mas_equalTo(wSelf.bgView);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(wSelf.bgView);
        make.right.mas_equalTo(wSelf.bgView).mas_offset(-52);
        make.width.mas_equalTo(72);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)btnClick:(UIButton *)btn {
    [UIView animateWithDuration:0.3 animations:^{
        if (btn == self.rightBtn) {
            self.line.frame = CGRectMake(SCREEN_W-52-72, 49, 72, 1);
        }else{
            self.line.frame = CGRectMake(54, 49, 72, 1);
        }
    }];
    [self.tableView reloadData];
    self.isHot = !self.isHot;
}

- (void)rightBarButtenClick {
    ZeroBuyCenterViewController *vc = [[ZeroBuyCenterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
