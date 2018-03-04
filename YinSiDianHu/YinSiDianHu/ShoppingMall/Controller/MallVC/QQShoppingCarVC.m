//
//  QQShoppingCarVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/11.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingCarVC.h"
#import "QQShoppingCarCell.h"
#import "QQShoppingCarModel.h"
#import "QQShoppingConfirmOrder.h"

@interface QQShoppingCarVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)QQShoppingCarFootView *bgView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger numCount;//商品总数量
@property(nonatomic,assign)CGFloat priceCount;//总价钱
@property(nonatomic,strong)NSString *rightBarStr;
@property(nonatomic,strong)NSMutableArray *modelArray;//要删除的model
@property(nonatomic,strong)UIView *exlainView;//暂无数据
@end

@implementation QQShoppingCarVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self getRequestData];
}

- (void)caluteNumAndPrice {
    self.bgView.numCount = 0;
    self.bgView.priceCount =0;
    for (QQShoppingCarModel *model in self.modelArray) {
        self.bgView.numCount+=[model.carNum integerValue];
        self.bgView.priceCount += [model.carNum integerValue]*[model.productPrice floatValue];
    }
}

- (void)accountRequest {
    NSString *carIDStr=@"";
    for (int i = 0; i<self.modelArray.count; i++) {
        QQShoppingCarModel *model = self.modelArray[i];
        if (i == 0) {
            carIDStr = [carIDStr stringByAppendingString:model.carId];
        }else{
            carIDStr = [carIDStr stringByAppendingString:[NSString stringWithFormat:@",%@",model.carId]];
        }
    }
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&cid=%@",shopping_accountURL,[UserManager shareManager].userName,carIDStr];
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        NSLog(@"点击去结算 ---- %@",response);
        QQShoppingAddressListModel *adressModel = [QQShoppingAddressListModel yy_modelWithJSON:response[@"addr"]];
        QQShoppingConfirmOrder *vc = [[QQShoppingConfirmOrder alloc]init];
        vc.modelArray = wSelf.modelArray;
        vc.addressModel = adressModel;
        vc.isCar = YES;
        vc.product_dp=@"?";
        [wSelf.navigationController pushViewController:vc animated:YES];
    } fail:^(NSError *error) {
        
    }];
}

- (void)getRequestData {
    [self.dataArray removeAllObjects];
    [self.modelArray removeAllObjects];
    WS(wSelf);
    NSString *str = [NSString stringWithFormat:@"%@username=%@",shopping_myCarURL,[UserManager shareManager].userName];
    //NSLog(@" 购物车----   %@",QQ_API_CON(str));
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        // NSLog(@"我的购物车-------%@",response);
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingCarModel class] json:response];
        for (QQShoppingCarModel *model in tempArr) {
            model.isPayment = YES;
        }
        [wSelf.dataArray addObjectsFromArray:tempArr];
        [wSelf.modelArray addObjectsFromArray:tempArr];
        [wSelf caluteNumAndPrice];
        if (wSelf.dataArray.count == 0) {
            wSelf.exlainView.hidden = NO;
        }else{
            wSelf.exlainView.hidden = YES;
        }
        [wSelf.tableView reloadData];
    } fail:^(NSError *error) {
        if (error.code == -1009) {
            WS(wSelf);
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-4)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf getRequestData];
            };
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)carNumChangeCarID:(NSString *)carID  productNum:(NSInteger)num model:(QQShoppingCarModel *)model{
    [[RSMBProgressHUDTool shareProgressHUDManager]showViewLoadingHUD:self.view showText:@""];
    WS(wSelf);
    NSString *str = [NSString stringWithFormat:@"%@username=%@&cid[%@]=%ld",shopping_carNumChangeURL,[UserManager shareManager].userName,carID,num];
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        NSLog(@"数量改变 ---- %@",response);
        if (response[@"stats"]) {
            model.carNum = [NSString stringWithFormat:@"%ld",num];
            if ([wSelf.modelArray containsObject:model]) {
                [wSelf.modelArray removeObject:model];
                [wSelf.modelArray addObject:model];
                [wSelf caluteNumAndPrice];
            }
            [wSelf.tableView reloadData];
        }
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
    }];
}

- (void)deleteCar:(QQShoppingCarModel *)model {
    NSString *carIDStr=@"";
    if (model == nil) {
        for (int i = 0; i<self.modelArray.count; i++) {
            QQShoppingCarModel *seletedModel = self.modelArray[i];
            if (i == 0) {
                carIDStr = [carIDStr stringByAppendingString:seletedModel.carId];
            }else{
                carIDStr = [carIDStr stringByAppendingString:[NSString stringWithFormat:@",%@",seletedModel.carId]];
            }
        }
    }else{
        carIDStr = model.carId;
    }
    NSLog(@"删除购物车id  ====  %@",carIDStr);
    WS(wSelf);
    NSString *str = [NSString stringWithFormat:@"%@username=%@&cid=%@",shopping_deleteCarURL,[UserManager shareManager].userName,carIDStr];
    NSLog(@"%@",QQ_API_CON(str));
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        NSLog(@"删除购物车 ------- %@",response);
        if (model == nil) {
            if (wSelf.dataArray.count == wSelf.modelArray.count) {
                [wSelf.bgView.btn setImage:QQIMAGE(@"shopping_Unchecked") forState:UIControlStateNormal];
            }
            [wSelf.dataArray removeObjectsInArray:wSelf.modelArray];
            [wSelf.modelArray removeAllObjects];
            [wSelf.tableView reloadData];
        }else{
            [wSelf.dataArray removeObject:model];
            if ([wSelf.modelArray containsObject:model]) {
                [wSelf.modelArray removeObject:model];
            }
            if (wSelf.modelArray.count==0) {
                [wSelf.bgView.btn setImage:QQIMAGE(@"shopping_Unchecked") forState:UIControlStateNormal];
            }
            if ([wSelf.rightBarStr isEqualToString:@"编辑"]) {
                [wSelf caluteNumAndPrice];
            }
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"删除成功"];
        if (wSelf.dataArray.count == 0 ) {
            wSelf.exlainView.hidden = NO;
        }
        [wSelf.tableView reloadData];
        
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

#pragma mark ---- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingCarCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QQShoppingCarModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    if (self.dataArray.count == self.modelArray.count) {
        [self.bgView.btn setImage:QQIMAGE(@"shopping_Checked") forState:UIControlStateNormal];
    }
    
    WS(wSelf);
    __weak __typeof(&*cell)wCell = cell;
    cell.shopping_carNumChangeBlock = ^(BOOL isAdd){
        [wSelf carNumChangeCarID:model.carId productNum:isAdd?[model.carNum integerValue]+1:[model.carNum integerValue]-1 model:model];
    };
    
    cell.shopping_carLeftSectedBlock = ^{
        if (model.isPayment) {
            //选中的情况下 左侧选中和全选中按钮  全部为未选中状态，价格和数量减少
            [wCell.selectedBtn setImage:QQIMAGE(@"shopping_Unchecked") forState:UIControlStateNormal];
            model.isPayment = NO;
            [wSelf.bgView.btn setImage:QQIMAGE(@"shopping_Unchecked") forState:UIControlStateNormal];
            if ([wSelf.modelArray containsObject:model]) {
                [wSelf.modelArray removeObject:model];
                if ([wSelf.rightBarStr isEqualToString:@"编辑"]) {
                    [wSelf caluteNumAndPrice];
                }
            }
        }else{
            //未选中的情况下 选中的model加入选中数组中 价格数量增加  如果数据源和选中数据个数相同，全选按钮为选中
            [wSelf.modelArray addObject:model];
            if ([wSelf.rightBarStr isEqualToString:@"编辑"]) {
                [wSelf caluteNumAndPrice];
            }
            if (wSelf.modelArray.count == wSelf.dataArray.count) {
                [wSelf.bgView.btn setImage:QQIMAGE(@"shopping_Checked") forState:UIControlStateNormal];
            }
            [wCell.selectedBtn setImage:QQIMAGE(@"shopping_Checked") forState:UIControlStateNormal];
            model.isPayment = YES;        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 122;
}

- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.isEditing) {
        return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(wSelf);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [QQShoppingTools showAlertControllerWithTitle:@"" message:@"确认要删除这个宝贝吗！" confirmTitle:@"删除" cancleTitle:@"取消" vc:wSelf confirmBlock:^{
            QQShoppingCarModel *model = wSelf.dataArray[indexPath.row];
            [wSelf deleteCar:model];
        } cancleBlock:^{
        }];
    }
}

#pragma mark ---- UI
- (void)createUI {
    self.view.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    self.title = @"购物车";
    self.rightBarStr = @"编辑";
    [self createRightButtenWithTitle:self.rightBarStr orImage:nil];
    self.numCount = 0;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgView];
    [self setAutoLaout];
    [self.view addSubview:self.exlainView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [_tableView registerNib:[UINib nibWithNibName:@"QQShoppingCarCell" bundle:nil] forCellReuseIdentifier:QQShoppingCarCellID];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIView *)exlainView {
    if (!_exlainView) {
        _exlainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _exlainView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake(0, 60, SCREEN_W, 101);
        [imageBtn setImage:QQIMAGE(@"zero_noRecord") forState:UIControlStateNormal];
        imageBtn.userInteractionEnabled = YES;
        [_exlainView addSubview:imageBtn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,imageBtn.height+imageBtn.y+10+15, SCREEN_W, 15)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"购物车太空啦、赶快去选购吧~";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [Tools getUIColorFromString:@"cdcdcd"];
        [_exlainView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((SCREEN_W-94)/2, label.y+label.height+18+15, 94, 29);
        btn.backgroundColor = [UIColor blackColor];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"前去逛逛" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [_exlainView addSubview:btn];
    }
    return _exlainView;
}

- (QQShoppingCarFootView *)bgView {
    if (!_bgView) {
        _bgView = [[QQShoppingCarFootView alloc]init];
        WS(wSelf);
        __weak __typeof(&*_bgView)wbgView = _bgView;
        _bgView.shopping_allSelectedBlock = ^{
            //  有0,1,2-> 点击后全选 否则取消
            if ( wSelf.modelArray.count!=wSelf.dataArray.count) {
                [wbgView.btn setImage:QQIMAGE(@"shopping_Checked") forState:UIControlStateNormal];
                for (int i = 0; i<wSelf.dataArray.count; i++) {
                    QQShoppingCarModel *model = wSelf.dataArray[i];
                    model.isPayment = YES;
                    if (![wSelf.modelArray containsObject:model]) {
                        [wSelf.modelArray addObject:model];
                        [wSelf caluteNumAndPrice];
                    }
                }
                [wSelf.tableView reloadData];
            }else{
                //如果已经全部选中，全部取消掉。数量和价钱全部为0
                [wbgView.btn setImage:QQIMAGE(@"shopping_Unchecked") forState:UIControlStateNormal];
                for (int i = 0; i<wSelf.dataArray.count; i++) {
                    QQShoppingCarModel *model = wSelf.dataArray[i];
                    model.isPayment = NO;
                    if ([wSelf.modelArray containsObject:model]) {
                        [wSelf.modelArray removeObject:model];
                    }
                }
                if ([wSelf.rightBarStr isEqualToString:@"编辑"]) {
                    [wSelf caluteNumAndPrice];
                }
                [wSelf.tableView reloadData];
            }
        };
        
        //去结算
        _bgView.shopping_nextBtnBlock = ^{
            if (wSelf.modelArray.count == 0) {
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"请先选择物品"];
                return ;
            }
            [wSelf accountRequest];
        };
        
        //删除选中
        _bgView.shopping_deleteBtnBlock = ^{
            if (wSelf.modelArray.count == 0) {
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请先选择商品"];
                return ;
            }
            [QQShoppingTools showAlertControllerWithTitle:@"" message:@"是否从购物车删除本商品！" confirmTitle:@"删除" cancleTitle:@"取消" vc:wSelf confirmBlock:^{
                [wSelf deleteCar:nil];
            } cancleBlock:^{
            }];
        };
    }
    return _bgView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)setAutoLaout {
    WS(wSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(wSelf.view);
        make.bottom.mas_equalTo(wSelf.view).mas_offset(-57);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(wSelf.view);
        make.height.mas_equalTo(57);
    }];
}

- (void)rightBarButtenClick {
    [self.tableView endEditing:YES];
    //改变按钮的字和背景  隐藏数量
    if ([self.rightBarStr isEqualToString:@"编辑"]) {
        self.bgView.chargesLabel.hidden = YES;
        self.bgView.countLabel.hidden = YES;
        self.bgView.nextBtn.hidden = YES;
        self.bgView.deleteBtn.hidden = NO;
        self.bgView.nextBtn.userInteractionEnabled = NO;
        self.bgView.deleteBtn.userInteractionEnabled = YES;
    }else{
        self.bgView.nextBtn.hidden = NO;
        self.bgView.deleteBtn.hidden = YES;
        self.bgView.nextBtn.userInteractionEnabled = YES;
        self.bgView.deleteBtn.userInteractionEnabled = NO;
        self.bgView.chargesLabel.hidden = NO;
        self.bgView.countLabel.hidden = NO;
        [self caluteNumAndPrice];
    }
    [self.tableView reloadData];
    self.rightBarStr =[self.rightBarStr isEqualToString:@"编辑"]? @"完成":@"编辑";
    [self createRightButtenWithTitle:self.rightBarStr orImage:nil];
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"购物车页面释放啦");
}

@end







