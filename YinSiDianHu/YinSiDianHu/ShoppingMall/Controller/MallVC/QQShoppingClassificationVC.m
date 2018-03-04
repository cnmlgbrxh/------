//
//  QQShoppingClassificationVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//商品分类

#import "QQShoppingClassificationVC.h"
#import "QQShoppingClassificationCell.h"
#import "QQShoppingHeadView.h"
#import "QQClassificationListVC.h"
#import "QQClassificationListVC.h"
#import "QQIntegralMallVC.h"

@interface QQShoppingClassificationVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation QQShoppingClassificationVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI {
    self.title = @"分类";
    self.view.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [self.view addSubview:self.collectionView];
}

#pragma mark ---- delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 1?self.dataArray.count:2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==1) {
        QQShoppingClassificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QQShoppingClassificationCellID forIndexPath:indexPath];
        cell.dic = self.dataArray[indexPath.row];
        return cell;
    }
    QQShoppingActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QQShoppingActivityCellID forIndexPath:indexPath];
    cell.imageName = indexPath.row == 0?@"shopping_fenleiLeft":@"shopping_fenleiRight";
    cell.shopping_ActivityBtnClickblock = ^(NSInteger tag) {
    };
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_W, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return section==0?CGSizeMake(0, 0):CGSizeMake(SCREEN_W, 300);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return section == 0?UIEdgeInsetsMake(0,10, 15, 10):UIEdgeInsetsMake(0, 10, 10, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    QQShoppingClassificationHeadView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:QQShoppingClassificationHeadViewID forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader) {
        head.sectionTitle = indexPath.section == 0?@"活动":@"分类";
        head.backgroundColor = [UIColor whiteColor];
    }else{
        head.sectionTitle = @"";
        head.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    }
    return head;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake((SCREEN_W-30)/2, QQAdapterSpacingValure(80));
    }
    NSInteger width = (SCREEN_W-50)/4;
    return CGSizeMake(width, 120);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        QQClassificationListVC *vc = [[QQClassificationListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (indexPath.row == 1) {
            QQIntegralMallVC *vc = [[QQIntegralMallVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)headViewBtnClick:(NSInteger)tag {
    if (tag == 10) {
        QQShoppingClassificationVC *vc = [[QQShoppingClassificationVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:QQShoppingClassificationCellClass bundle:nil] forCellWithReuseIdentifier:QQShoppingClassificationCellID];
        [_collectionView registerClass:[QQShoppingActivityCell class] forCellWithReuseIdentifier:QQShoppingActivityCellID];
        [_collectionView registerClass:[QQShoppingClassificationHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:QQShoppingClassificationHeadViewID];
        [_collectionView registerClass:[QQShoppingClassificationHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:QQShoppingClassificationHeadViewID];
        
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor =[UIColor whiteColor];
    }
    return _collectionView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@{@"手机平板":@"shopping_iphone"},
                       @{@"电脑办公":@"shopping_mac"},
                       @{@"数码影音":@"shopping_erji"},
                       @{@"女性时尚":@"shopping_women"},
                       @{@"美食天地":@"shopping_foot"},
                       @{@"潮流新品":@"shopping_yifu"},
                       @{@"其他商品":@"shopping_other"}];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
