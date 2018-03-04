//
//  ZeroBuyPayOrderVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/28.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyPayOrderVC.h"
#import "ZeroBuyPayOrderHeadCell.h"
#import "ZeroBuyPayStyleModel.h"

@interface ZeroBuyPayOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArary;
@end

@implementation ZeroBuyPayOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

- (void)getData {
    NSArray *titleArr = @[@"微信支付",@"支付宝支付",@"银行卡"];
    NSArray *imageArr = @[@"shopping_wechat",@"shopping_zfb",@"zero_unionPay"];
    for (int i = 0; i<titleArr.count; i++) {
        ZeroBuyPayStyleModel *model = [[ZeroBuyPayStyleModel alloc]init];
        model.payName = titleArr[i];
        model.payImage = imageArr[i];
        [self.dataArary addObject:model];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArary.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZeroBuyPayOrderHead *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyPayOrderHeadID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
    }else{
        ZeroBuyPayOrderHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyPayOrderHeadCellID];
        ZeroBuyPayStyleModel *model = self.dataArary[indexPath.row-1];
        cell.payTitle.text = model.payName;
        cell.payImageView.image = QQIMAGE(model.payImage);
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0?148:62;
}

- (void)createUI {
    self.title = @"支付订单";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        [_tableView registerNib:[UINib nibWithNibName:@"ZeroBuyPayOrderHeadCell" bundle:nil] forCellReuseIdentifier:ZeroBuyPayOrderHeadCellID];
        [_tableView registerClass:[ZeroBuyPayOrderHead class] forCellReuseIdentifier:ZeroBuyPayOrderHeadID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataArary {
    if (!_dataArary) {
        _dataArary = [[NSMutableArray alloc]init];
    }
    return _dataArary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
