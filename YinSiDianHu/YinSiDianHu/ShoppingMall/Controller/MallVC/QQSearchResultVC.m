//
//  QQSearchResultVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQSearchResultVC.h"
#import "QQSearchResultBarView.h"
#import "QQShoppingSearchResultHeadView.h"
#import "QQShoppingCollectionCell.h"
#import "QQShoppingProducDetailVC.h"
#import "QQShoppingClassificationVC.h"

@interface QQSearchResultVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) QQBaseCollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataArray;
//@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger currentIndex;//0:综合  1:销量  2:新品  3:价格
@property(nonatomic,assign) BOOL up;
@end

@implementation QQSearchResultVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.page = 1;
    self.currentIndex = 0;
    self.up = YES;
    [self requestURLStr];
}

- (void)requestURLStr {
    NSString *utf8Str =  [self.titleStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr;
    if (self.currentIndex == 0) {
        //综合
        urlStr = [NSString stringWithFormat:@"%@username=%@&pname=%@",shopping_searchProductURL,[UserManager shareManager].userName,utf8Str];
    }else if (self.currentIndex == 1) {
        //销量
        urlStr = [NSString stringWithFormat:@"%@username=%@&pname=%@&volume=%@",shopping_searchProductURL,[UserManager shareManager].userName,utf8Str,self.up?@"2":@"1"];
    }else if (self.currentIndex == 2) {
        //新品
        urlStr = [NSString stringWithFormat:@"%@username=%@&pname=%@&new=1",shopping_searchProductURL,[UserManager shareManager].userName,utf8Str];
    }else{
        //价格
        urlStr = [NSString stringWithFormat:@"%@username=%@&pname=%@&price=%@",shopping_searchProductURL,[UserManager shareManager].userName,utf8Str,self.up?@"2":@"1"];
    }
    [self getResultData:urlStr];
}

- (void)getResultData:(NSString *)urlStr {
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingMallModel class] json:response[@"list"]];
        [self.dataArray addObjectsFromArray:tempArr];
        if (self.dataArray.count == 0) {
            [self.collectionView hiddenRefresh];
            [[BSNoDataCustomView sharedInstance] showCustormViewToTargetView:self.view promptText:@"暂无相关数据哦~" customViewFrame:CGRectMake(0, 105, SCREEN_W, SCREEN_H-105)];
        }else{
            [[BSNoDataCustomView sharedInstance] hiddenNoDataView];
        }
        [self.collectionView reloadData];
        [self.collectionView endRefresh];
    } fail:^(NSError *error) {
        if (error.code == -1009) {
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 105, SCREEN_W, SCREEN_H-105)];
            WS(wSelf);
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf requestURLStr];
            };
        }
        [self.collectionView endRefresh];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
        [self.collectionView hiddenRefresh];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_W, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        QQShoppingSearchResultHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:QQShoppingSearchResultHeadViewID forIndexPath:indexPath];
        WS(wSelf);
        //点击销量
        view.shopping_salesBtnClickBlock = ^(BOOL up){
            wSelf.up = up;
            [wSelf commentSettingWithCurrentIndex:1];
        };
        //点击综合
        view.shopping_synthesizeBtnClickBlock = ^{
            [wSelf commentSettingWithCurrentIndex:0];
        };
        //点击新品
        view.shopping_productBtnClickBlock = ^{
            [wSelf commentSettingWithCurrentIndex:2];
        };
        //点击价格
        view.shopping_priceBtnClickBlock = ^(BOOL up){
            wSelf.up = up;
            [wSelf commentSettingWithCurrentIndex:3];
        };
        return view;
    }else{
        return nil;
    }
}

- (void)commentSettingWithCurrentIndex:(NSInteger)currentIndex {
    [self.dataArray removeAllObjects];
    self.currentIndex = currentIndex;
    [self requestURLStr];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingMallModel *model = self.dataArray[indexPath.row];
    QQShoppingProducDetailVC *vc = [[QQShoppingProducDetailVC alloc]init];
    vc.pid = model.productId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (QQBaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = (SCREEN_W-21)/2;
        CGFloat height = 10+17+10+34+15+QQAdapterSpacingValure(496/2)+5;
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 7;
        _collectionView = [[QQBaseCollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H-64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:QQShoppingCollectionCellClass bundle:nil] forCellWithReuseIdentifier:QQShoppingCollectionCellID];
        [_collectionView registerNib:[UINib nibWithNibName:QQShoppingSearchResultHeadViewClass bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:QQShoppingSearchResultHeadViewID];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return _collectionView;
}


- (void)createUI {
    QQSearchResultBarView *view = [[NSBundle mainBundle]loadNibNamed:@"QQSearchResultBarView" owner:self options:nil][0];
    view.frame = CGRectMake(0, 20, SCREEN_W, 44);
    WS(wSelf);
    view.shopping_searchResultBackBlick = ^{
        [wSelf back];
    };
    view.titleLabel.text = self.titleStr;
    [self.view addSubview:view];
    [self.view addSubview:self.collectionView];
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

- (void)back {
  if (self.status == 1) {
        WS(wSelf);
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[QQShoppingClassificationVC class]]) {
                QQShoppingClassificationVC *vc =(QQShoppingClassificationVC *)controller;
                [wSelf.navigationController popToViewController:vc animated:YES];
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end























