//
//  PurchasePackageView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PurchasePackageView.h"
#import "PurchasePackageCell.h"
#import "FootAlertButtonView.h"
#import "PayWayViewController.h"

@interface PurchasePackageView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *collectionView;

@end
@implementation PurchasePackageView{
    NSIndexPath *indexPathBefore;
    NSArray *arrData;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HOMECOLOR;

        arrData = @[@{@"300":@"三个月任意设置号码\n"},@{@"800":@"一年任意设置号码\n开通黄金会员"},@{@"2000":@"两年任意设置号码\n开通钻石会员"},@{@"5000":@"三年任意设置号码\n开通至尊会员"}];
        
        [self createUI];
    }
    return self;
}

-(void)createUI{
    // 瀑布流
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置大小
    flowLayout.itemSize = CGSizeMake(Scale(167), Scale(119));
    // 设置item间隔
    //设置每组的item（如果是垂直显示 行距。如果是水平方向显示 列距）
    flowLayout.minimumLineSpacing = Scale(11);
    // 设置 每组item（如果是垂直显示 列距。如果是水平方向显示 行距）
    //flowLayout.minimumInteritemSpacing = 1;
    flowLayout.sectionInset =UIEdgeInsetsMake(Scale(10),Scale(15), Scale(0), Scale(15));//上左下右
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.height-64) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = HOMECOLOR;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    // item注册
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PurchasePackageCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ID"];
    //注册尾视图
    [_collectionView registerNib:[UINib nibWithNibName:@"FootAlertButtonView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionViewFooter"];
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //所选
    PurchasePackageCell *cellBefore = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPathBefore];
    cellBefore.isSelect = NO;
    PurchasePackageCell *cellCurrent = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    cellCurrent.isSelect = YES;
    indexPathBefore = indexPath;
}
#pragma mark - UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionFooter) {
        FootAlertButtonView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionViewFooter" forIndexPath:indexPath];
        footView.BlockPayWay = ^{
            
            if (indexPathBefore == nil) {
                [MessageHUG showWarningAlert:@"请选择套餐"];
                return ;
            }
            
            //数据处理
            NSDictionary *dic = arrData[indexPathBefore.row];
            NSString *strPayAmount = [NSString stringWithFormat:@"%@",[dic.allKeys firstObject]];
            //回调支付成功显示的金额
            if (_BlockAmount)
            {
                self.BlockAmount(strPayAmount);
            }
            //支付界面
            PayWayViewController *paywayVC = [[PayWayViewController alloc]init];
            paywayVC.strAmount = strPayAmount;
            WeakSelf
            paywayVC.BlockClose = ^{
                PurchasePackageCell *cellCurrent = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPathBefore];
                cellCurrent.isSelect = NO;
                [weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPathBefore]];
                indexPathBefore = nil;
            };
            paywayVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            paywayVC.providesPresentationContextTransitionStyle = YES;
            paywayVC.definesPresentationContext = YES;
            paywayVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [_viewController.navigationController.tabBarController presentViewController:paywayVC animated:YES completion:nil];
        };
        footView.strAlert = @" 开通套餐后享受套餐级别有效期内任意设置号码等功能，但套餐充值的金额不可作为余额使用，以及购买其他物品。   ";
        footView.strButtonTitle = @"立即购买";
        return footView;
    }else{
        return nil;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_W , 185);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrData.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PurchasePackageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    //cell.tag = indexPath.row;
    cell.dicValue = arrData[indexPath.row];
    return cell;
}
@end
