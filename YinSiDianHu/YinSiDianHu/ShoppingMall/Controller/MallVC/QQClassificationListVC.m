//
//  QQClassificationListVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//分类

#import "QQClassificationListVC.h"
#import "QQSearchRecordVC.h"
#import "QQShoppingMallModel.h"
#import "QQSearchResultBarView.h"
#import "QQShoppingCollectionCell.h"
#import "QQShoppingSearchResultHeadView.h"
#import "QQShoppingProducDetailVC.h"

@interface QQClassificationListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation QQClassificationListVC
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
}

- (void)getData {
    [self.collectionView.mj_footer endRefreshing];
    NSArray *imageArr = @[@"shopping_cellIconLeft1",@"shopping_cellIconright1",@"shopping_cellIconLeft2",@"shopping_cellIconright2",@"shopping_cellIconLeft1",@"shopping_cellIconLeft1"];
    for (int i=0; i<imageArr.count; i++) {
        QQShoppingMallModel *model = [[QQShoppingMallModel alloc]init];
        model.image = imageArr[i];
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
    [self.collectionView.mj_footer endRefreshing];
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
        view.synthesizeBtn.selected = YES;
        return view;
    }else{
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingProducDetailVC *vc = [[QQShoppingProducDetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = (SCREEN_W-21)/2;
        CGFloat height = 10+17+10+34+15+QQAdapterSpacingValure(496/2)+5;
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 7;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H-64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:QQShoppingCollectionCellClass bundle:nil] forCellWithReuseIdentifier:QQShoppingCollectionCellID];
        [_collectionView registerNib:[UINib nibWithNibName:QQShoppingSearchResultHeadViewClass bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:QQShoppingSearchResultHeadViewID];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self getData];
        }];
    }
    return _collectionView;
}


- (void)createUI {
    [self getData];
    [self.view addSubview:self.topView];
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

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:QQIMAGE(@"shopping_arrow") forState:UIControlStateNormal];
        btn.frame = CGRectMake(10,12, 40, 40);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:btn];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+40+5,17, SCREEN_W-15-12-40-10, 32)];
        imageView.image = QQIMAGE(@"shopping_searchBar");
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchBtnClick)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        [_topView addSubview:imageView];
    }
    _topView.frame = CGRectMake(0, 10, SCREEN_W, 64);
    return _topView;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBtnClick {
    QQSearchRecordVC *vc = [[QQSearchRecordVC alloc]init];
    vc.status = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
