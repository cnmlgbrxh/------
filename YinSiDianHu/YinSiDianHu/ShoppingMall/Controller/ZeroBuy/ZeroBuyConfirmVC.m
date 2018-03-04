//
//  ZeroBuyConfirmVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyConfirmVC.h"
#import "QQConfirmOrderHeadView.h"
#import "QQShoppingPlaceManagerVC.h"
#import "ZeroBuyConfirmOrderDetailCell.h"
#import "ZeroBuyConfirmOrderPriceCell.h"
#import "ZeroBuyPayOrderVC.h"

@interface ZeroBuyConfirmVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) QQConfirmOrderHeadView *headView;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UILabel *leftLabel;
@end

@implementation ZeroBuyConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)geDefaultAddress {
    NSString *url = [NSString stringWithFormat:@"%@username=%@",shopping_addressListURL,[UserManager shareManager].userName];
    WS(wSelf);
    [HYBNetworking getWithUrl:QQ_API_CON(url) refreshCache:YES success:^(id response) {
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingAddressListModel class] json:response];
        for (QQShoppingAddressListModel *model in tempArr) {
            if ([model.is_common isEqualToString:@"1"]) {
                wSelf.headView.hiddenTapLabel = YES;
                wSelf.headView.model = model;
            }
        }
    } fail:^(NSError *error) {
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZeroBuyConfirmOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyConfirmOrderDetailCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ZeroBuyConfirmOrderPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:ZeroBuyConfirmOrderPriceCellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.zero_confirmPriceBlock = ^(NSString *price) {
            
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0?96:133;
}

- (void)createUI {
    self.title = @"确认订单";
    [self geDefaultAddress];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footView];
}

- (QQConfirmOrderHeadView *)headView {
    if (!_headView) {
        self.headView = [[NSBundle mainBundle]loadNibNamed:@"QQConfirmOrderHeadView" owner:self options:nil][0];
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, 148);
        self.headView.hiddenTapLabel = NO;
        self.headView.orderNumView.hidden = NO;
        self.headView.orderNumViewHeight.constant = 43;
        self.headView.orderNumLabel.text = @"3245";
        self.headView.orderNumKeyLabel.text = @"参与期号";
        self.headView.orderNumView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        WS(wSelf);
        self.headView.shopping_addPlaceBlock = ^{
            QQShoppingPlaceManagerVC *vc = [[QQShoppingPlaceManagerVC alloc]init];
            vc.shopping_goolsPlaceBlock = ^(QQShoppingAddressListModel *model) {
                wSelf.headView.hiddenTapLabel = YES;
                wSelf.headView.model = model;
            };
            [wSelf.navigationController pushViewController:vc animated:YES];
        };

    }
    return _headView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-55) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
        _tableView.tableHeaderView = self.headView;
        [_tableView registerNib:[UINib nibWithNibName:@"ZeroBuyConfirmOrderDetailCell" bundle:nil] forCellReuseIdentifier:ZeroBuyConfirmOrderDetailCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"ZeroBuyConfirmOrderPriceCell" bundle:nil] forCellReuseIdentifier:ZeroBuyConfirmOrderPriceCellID];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return _tableView;
}

- (UIView *)footView {
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H-64-55, SCREEN_W, 55)];
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, 55)];
        self.leftLabel.textAlignment = NSTextAlignmentCenter;
        self.leftLabel.font = [UIFont systemFontOfSize:16];
        self.leftLabel.backgroundColor = [UIColor whiteColor];
        self.leftLabel.text = @"还需支付：￥240";
        [_footView addSubview:self.leftLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_W/2, 0, SCREEN_W/2, 55);
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitle:@"立即购买" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:btn];
    }
    return _footView;
}

- (void)btnClick {
    ZeroBuyPayOrderVC *vc = [[ZeroBuyPayOrderVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
