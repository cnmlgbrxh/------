//
//  QQShoppingNewProductVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/8.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingNewProductVC.h"
#import "QQShoppingCollectionCell.h"
#import "QQShoppingProducDetailVC.h"
#import "QQShoppingMallModel.h"

@interface QQShoppingNewProductVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) QQBaseCollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation QQShoppingNewProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI {
    [self getData];
    self.title = @"新品上市";
    [self.view addSubview:self.collectionView];
}

- (void)getData {
    WS(wSelf);
    [[RSMBProgressHUDTool shareProgressHUDManager] showViewLoadingHUD:self.view showText:@"正在加载..."];
    NSString * urlStr = [NSString stringWithFormat:@"%@username=%@&new=1&pname=%@",shopping_searchProductURL,[UserManager shareManager].userName,@""];
    NSLog(@"%@",QQ_API_CON(urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        NSLog(@"%@",response);
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
        if (response[@"msg"]) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-4)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf getData];
            };
        }else{
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingMallModel class] json:response[@"list"]];
            [self.dataArray addObjectsFromArray:tempArr];
            if (self.dataArray.count == 0) {
                [[BSNoDataCustomView sharedInstance] showCustormViewToTargetView:self.view promptText:@"暂无相关数据哦~" customViewFrame:CGRectMake(0, 308, SCREEN_W, SCREEN_H-308)];
                [self.collectionView hiddenRefresh];
            }else{
                [[BSNoDataCustomView sharedInstance] hiddenNoDataView];
            }
            [self.collectionView reloadData];
            
        }
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
        if (error.code == -1009) {
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-4)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf getData];
            };
        }
    }];
}


#pragma mark ---- delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QQShoppingCollectionCellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(7, 7, 7, 7);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (SCREEN_W-21)/2;
    return CGSizeMake(width, 167*SCREEN_W/375+5+15+34+10+17);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingProducDetailVC *vc = [[QQShoppingProducDetailVC alloc]init];
    QQShoppingMallModel *model = self.dataArray[indexPath.row];
    vc.pid = model.productId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (QQBaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 7;
        _collectionView = [[QQBaseCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:QQShoppingCollectionCellClass bundle:nil] forCellWithReuseIdentifier:QQShoppingCollectionCellID];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
