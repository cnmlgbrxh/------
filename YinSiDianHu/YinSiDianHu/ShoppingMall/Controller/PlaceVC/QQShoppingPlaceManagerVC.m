//
//  QQShoppingPlaceManagerVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingPlaceManagerVC.h"
#import "QQShoppingPlaceManagerCell.h"
#import "QQShoppingAddGoolsPlace.h"
@interface QQShoppingPlaceManagerVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton *addPlaceBtn;
@end

@implementation QQShoppingPlaceManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRequestData];
}

- (void)getRequestData {
    WS(wSelf);
    NSString *url = [NSString stringWithFormat:@"%@username=%@",shopping_addressListURL,[UserManager shareManager].userName];
    NSLog(@"收货地址列表 ------ %@",QQ_API_CON(url));
    [HYBNetworking getWithUrl:QQ_API_CON(url) refreshCache:YES success:^(id response) {
        [wSelf.dataArray removeAllObjects];
        NSLog(@"收货地址列表 ------ %@",response);
        [[BSNoDataCustomView sharedInstance] hiddenNoDataView];
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingAddressListModel class] json:response];
        [wSelf.dataArray addObjectsFromArray:tempArr];
        [wSelf.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"收货地址列表 ------ %@",error);
        if (error.code == -1009) {
            WS(wSelf);
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-4)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf.dataArray removeAllObjects];
                [wSelf getRequestData];
            };
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)deleteAddressRequest:(QQShoppingAddressListModel *)model {
    WS(wSelf);
    NSString *str = [NSString stringWithFormat:@"%@username=%@&aid=%@",shopping_deleteAddressURL,[UserManager shareManager].userName,model.aid];
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        NSLog(@"删除收货地址-------%@",response);
        if ([response[@"stats"] isEqualToString:@"ok"]) {
            [wSelf getRequestData];
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
        }
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingPlaceManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingPlaceManagerCellID];
    QQShoppingAddressListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WS(wSelf);
    cell.shopping_editPlaceBlock = ^{
        QQShoppingAddGoolsPlace *vc = [[QQShoppingAddGoolsPlace alloc]initWithNibName:@"QQShoppingAddGoolsPlace" bundle:[NSBundle mainBundle]];
        vc.model = model;
        vc.shopping_editPlaceBlock = ^(QQShoppingAddressListModel *vcmodel) {
            [wSelf getRequestData];
        };
        [wSelf.navigationController pushViewController:vc animated:YES];
    };
    
    cell.shopping_delPlaceBlock = ^{
        [QQShoppingTools showAlertControllerWithTitle:@"" message:@"确定要删除该地址吗?" confirmTitle:@"删除" cancleTitle:@"取消" vc:wSelf confirmBlock:^{
            [wSelf deleteAddressRequest:model];
        } cancleBlock:^{
        }];
    };
    
    cell.shopping_defultPlaceBlock = ^{
        [wSelf editAddressRequest:model];
    };
    return cell;
}

- (void)editAddressRequest:(QQShoppingAddressListModel *)model {
    NSString *nameUtf8 =  [model.cname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *placeUtf8 =  [model.czone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *placeDetailUtf8 =  [model.caddr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSString stringWithFormat:@"%@username=%@&aid=%@&name=%@&phone=%@&zone=%@&addr=%@&common=1",shopping_editAddressURL,[UserManager shareManager].userName,model.aid,nameUtf8,model.cphone,placeUtf8,placeDetailUtf8];
    WS(wSelf);
    NSLog(@"收货地址列表 ---- %@",QQ_API_CON(str));
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        NSLog(@"设置默认地址 ------%@",response);
        if ([response[@"stats"] isEqualToString:@"ok"]) {
            [wSelf getRequestData];
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] hiddenHUD];
    } fail:^(NSError *error) {
        NSLog(@"设置默认地址错误 ------ %@",error);
        [[RSMBProgressHUDTool shareProgressHUDManager] hiddenHUD];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingAddressListModel *model = self.dataArray[indexPath.row];
    if (self.shopping_goolsPlaceBlock) {
        self.shopping_goolsPlaceBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createUI {
    self.title = @"收货地址";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addPlaceBtn];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-55-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 140;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"QQShoppingPlaceManagerCell" bundle:nil] forCellReuseIdentifier:QQShoppingPlaceManagerCellID];
        _tableView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UIButton *)addPlaceBtn {
    if (!_addPlaceBtn) {
        _addPlaceBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
        _addPlaceBtn.frame = CGRectMake(0, SCREEN_H-55-64, SCREEN_W, 55);
        _addPlaceBtn.backgroundColor = [UIColor blackColor];
        [_addPlaceBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        [_addPlaceBtn setImage:QQIMAGE(@"shopping_placeManagerAdd") forState:UIControlStateNormal];
        _addPlaceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [_addPlaceBtn addTarget:self action:@selector(addPlaceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPlaceBtn;
}

- (void)addPlaceBtnClick {
    WS(wSelf);
    QQShoppingAddGoolsPlace *vc = [[QQShoppingAddGoolsPlace alloc]init];
    vc.shopping_addPlaceBlock = ^(QQShoppingAddressListModel *model) {
        [wSelf getRequestData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
