//
//  QQShoppingProducDetailVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/8.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//商品详情

#import "QQShoppingProducDetailVC.h"
#import "QQShoppingProducDetailHeadView.h"
#import "QQShoppingCarVC.h"
#import "QQShoppingAddCarView.h"
#import "QQShoppingConfirmOrder.h"
#import "QQShoppingProductDetailModel.h"
#import "QQShoppingCarModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "QQShoppingAddressListModel.h"


@interface QQShoppingProducDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *carBtn;
@property(nonatomic,strong)UIButton *buyBtn;
@property(nonatomic,strong)UIButton *addCarBtn;
@property(nonatomic,strong)QQShoppingProductDetailModel *model;
@property(nonatomic,strong)QQShoppingProducDetailHeadView *headView;
@property(nonatomic,strong)NSMutableArray *imageURLArray;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)NSMutableArray *productArray;
@property(nonatomic,strong)NSMutableArray *keyArray;//放product_dp1，product_dp1，product_dp1
@end

@implementation QQShoppingProducDetailVC

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

- (void)buyRequestWithProduct:(NSString *)product_dp carNum:(NSString *)num {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&pid=%@&num=1",shopping_accountURL,[UserManager shareManager].userName,self.model.pid];
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        QQShoppingAddressListModel *adressModel = [QQShoppingAddressListModel yy_modelWithJSON:response[@"addr"]];
        
        NSLog(@"点击直接购买%@",response);
        QQShoppingCarModel *model = [[QQShoppingCarModel alloc]init];
        model.productPrice = self.model.price;
        model.pid = self.model.pid;
        model.productName = self.model.name;
        model.productPic = self.model.pic;
        model.product_dp = product_dp;
        model.carNum = num;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            QQShoppingConfirmOrder *vc = [[QQShoppingConfirmOrder alloc]init];
            vc.modelArray = @[model];
            vc.addressModel = adressModel;
            if (product_dp.length > 0 && product_dp != nil) {
                vc.product_dp = product_dp;
            }else{
                vc.product_dp = @"?";
            }
            vc.isCar = NO;
            [wSelf.navigationController pushViewController:vc animated:YES];
        });
    } fail:^(NSError *error) {
        
    }];
}

- (void)getData {
    self.keyArray = [[NSMutableArray alloc]initWithObjects:@"product_dp1",@"product_dp2",@"product_dp3",@"product_dp4",@"product_dp5", nil];
    self.model = [[QQShoppingProductDetailModel alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@&username=%@",shopping_productDetailURL,self.pid,[UserManager shareManager].userName];
    NSLog(@"商品详情-----%@",QQ_API_CON(urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        self.model = [QQShoppingProductDetailModel yy_modelWithJSON:response];
        NSLog(@"商品详情页数据 ----- %@",self.model);
        [[BSNoDataCustomView sharedInstance]hiddenNoDataView];
        if (self.model.pid) {
            self.headView.model = self.model;
            self.imageURLArray = [NSMutableArray arrayWithArray:self.model.details];
            NSString* product_dp1 = response[@"product_dp1"];
            NSString* product_dp2 = response[@"product_dp2"];
            NSString* product_dp3 = response[@"product_dp3"];
            NSString* product_dp4 = response[@"product_dp4"];
            NSString* product_dp5 = response[@"product_dp5"];
            [self stringLength:product_dp1 keyStr:@"product_dp1"];
            [self stringLength:product_dp2 keyStr:@"product_dp2"];
            [self stringLength:product_dp3 keyStr:@"product_dp3"];
            [self stringLength:product_dp4 keyStr:@"product_dp4"];
            [self stringLength:product_dp5 keyStr:@"product_dp5"];
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        if (error.code == -1009) {
            WS(wSelf);
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf getData];
            };
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)stringLength:(NSString *)str keyStr:(NSString *)keyStr{
    if (![str isMemberOfClass:[NSNull class]]) {
        if (str.length>0 && str != nil && str != NULL) {
            [self.productArray addObject:str];
        }
    }else{
        [self.keyArray removeObject:keyStr];
    }
}

- (NSMutableArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc]init];
    }
    return _imageArr;
}
#pragma mark --- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0?1:self.imageURLArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QQShoppingDetailDescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingDetailDescribeCellID];
        cell.describeLabel.text = self.model.describe;
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
    }
    QQShoppingProducDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingProducDetailCellID];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.urlStr = self.imageURLArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [[QQShoppingTools shareInstance] calculateRowHeight:self.model.describe fontSize:14 bgViewWidth:SCREEN_W-20];
    }else{
        return SCREEN_W*0.93;
    }
}

- (void)createUI {
    self.title = @"商品详情";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self setAutoLaout];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-60-64) style:UITableViewStylePlain];
        [_tableView registerClass:[QQShoppingProducDetailCell class] forCellReuseIdentifier:QQShoppingProducDetailCellID];
        [_tableView registerClass:[QQShoppingDetailDescribeCell class] forCellReuseIdentifier:QQShoppingDetailDescribeCellID];
        self.headView =  [[NSBundle mainBundle] loadNibNamed:@"QQShoppingProducDetailHeadView" owner:self options:nil][0];
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W*0.9+120+40);
        _tableView.tableHeaderView = self.headView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)imageURLArray {
    if (!_imageURLArray) {
        _imageURLArray = [[NSMutableArray alloc] init];
    }
    return _imageURLArray;
}

- (NSMutableArray *)productArray {
    if (!_productArray) {
        _productArray = [[NSMutableArray alloc]init];
    }
    return _productArray;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [Tools getUIColorFromString:@"f5f5f5"];
        self.carBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.carBtn setTitle:@"购物车" forState:UIControlStateNormal];
        [self.carBtn setImage:QQIMAGE(@"shopping_car") forState:UIControlStateNormal];
        [self.carBtn addTarget:self action:@selector(carBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.carBtn setTitleColor:[Tools getUIColorFromString:@"585656"] forState:UIControlStateNormal];
        self.carBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.carBtn setTitleEdgeInsets:UIEdgeInsetsMake(0 ,-20, -30,0)];
        [self.carBtn setImageEdgeInsets:UIEdgeInsetsMake(-20, 0, 0, -50)];
        [_bottomView addSubview:self.carBtn];
        
        self.addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setBtn:self.addCarBtn color:[Tools getUIColorFromString:@"ed4044"] title:@"加入购物车"];
        self.addCarBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.addCarBtn addTarget:self action:@selector(addCarBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.addCarBtn];
        
        self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setBtn:self.buyBtn color:[Tools getUIColorFromString:@"1f1f1f"] title:@"立即购买"];
        self.buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.buyBtn];
    }
    return _bottomView;
}

- (void)setAutoLaout {
    WS(wSelf);
    [wSelf.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(wSelf.view);
        make.height.mas_equalTo(60);
    }];
    
    [wSelf.carBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bottomView).mas_offset(30);
        make.top.mas_equalTo(wSelf.bottomView).mas_offset(8);
        make.bottom.mas_equalTo(wSelf.bottomView).mas_offset(-10);
    }];
    
    [wSelf.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.bottomView).mas_offset(-13);
        make.bottom.mas_equalTo(wSelf.bottomView).mas_equalTo(-9);
        make.height.mas_equalTo(43);
        make.width.mas_equalTo(105);
    }];
    
    [wSelf.addCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.buyBtn.mas_left).mas_equalTo(-8);
        make.bottom.mas_equalTo(wSelf.bottomView).mas_equalTo(-9);
        make.height.mas_equalTo(wSelf.buyBtn.mas_height);
        make.width.mas_equalTo(wSelf.buyBtn.mas_width);
    }];
    
}

- (void)setBtn:(UIButton *)btn color:(UIColor *)color title:(NSString *)title{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = color;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundColor:color];
}

- (void)buyBtnClick {
    QQShoppingAddCarView *view= [[QQShoppingAddCarView alloc]init];
    view.productArray = [self.productArray copy];
    view.model = self.model;
    view.pid = self.model.pid;
    view.keyArray = [self.keyArray copy];
    view.addCar = NO;
    WS(wSelf);
    __weak __typeof(&*view)weakView = view;
    //点击直接购买
    view.shopping_toConfirmOrderVCBlock = ^(NSString *product_dp,NSString *num ){
        [weakView hide];
        [wSelf buyRequestWithProduct:product_dp carNum:num];
    };
    [view show];
}

- (void)addCarBtnClick {
    QQShoppingAddCarView *view= [[QQShoppingAddCarView alloc]init];
    view.productArray = [self.productArray copy];
    view.model = self.model;
    view.pid = self.model.pid;
    view.keyArray = [self.keyArray copy];
    view.addCar = YES;
    [view show];
}

- (void)carBtnClick {
    QQShoppingCarVC *vc = [[QQShoppingCarVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
