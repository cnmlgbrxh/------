//
//  QQIntegralMallVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/4.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQIntegralMallVC.h"
#import "QQShoppingIntegralHeadView.h"
#import "QQShoppingIntegralCell.h"
#import "QQShoppingExplainView.h"
#import "QQShoppingIntegralDetailVC.h"
#import "QQChangeRecordVC.h"
#import "QQShoppingIntegralListVC.h"
#import "QQShoppingBannerModel.h"
#import "QQIntegListModel.h"
#import "QQShoppingMallVC.h"

@interface QQIntegralMallVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *bannerArray;
@property(nonatomic,strong)QQShoppingIntegralHeadView *head;
@property(nonatomic,strong)NSString *poindt;//积分
@end

@implementation QQIntegralMallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self getBanner];
    [self createUI];
}

- (void)getExplainRequest {
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@",integ_explainURL,[UserManager shareManager].userName];
    NSLog(@"%@",Integ_API_CON(urlStr));
    [HYBNetworking getWithUrl:Integ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        NSString *utlStr = response[@"data"];
            QQShoppingExplainView *view = [[QQShoppingExplainView alloc]init];
        view.explainStr = utlStr.length>0?utlStr:@"用户在软件内充值，并确定为有效订单后，根据充值的金额，可以获得积分（消费满1元得1分积分）。充值额只计算订单实际支付金额，优惠金额等不计算在内 。获得的积分可在软件的积分商城内兑换等值的商品。";
            [view show];
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)getBanner {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@",integ_listBannerURL,[UserManager shareManager].userName];
    [HYBNetworking getWithUrl:Integ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingBannerModel class] json:response];
        [wSelf.bannerArray addObjectsFromArray:tempArr];
        wSelf.head.bannerArray = tempArr;
        [wSelf.collectionView reloadData];
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)getData {
    WS(wSelf);
    [[RSMBProgressHUDTool shareProgressHUDManager]showViewLoadingHUD:self.view showText:@""];
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@",integ_mallList,[UserManager shareManager].userName];
    NSLog(@"%@",Integ_API_CON(urlStr));
    [HYBNetworking getWithUrl:Integ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQIntegListModel class] json:response[@"list"]];
        wSelf.head.countLabel.text = response[@"point"];
        wSelf.head.countLabel.attributedText =  [Tools LabelStr:[NSString stringWithFormat:@"%@ 分",response[@"point"]]changeStr:@"分" color:[Tools getUIColorFromString:@"444444" ] font:[UIFont systemFontOfSize:15]];
        wSelf.poindt = response[@"point"];
        [wSelf.dataArray addObjectsFromArray:tempArr];
        if (wSelf.dataArray.count == 0) {
            [[BSNoDataCustomView sharedInstance] showCustormViewToTargetView:self.view promptText:@"暂无相关数据哦~" customViewFrame:CGRectMake(0, 308, SCREEN_W, SCREEN_H-308)];
        }else{
            [[BSNoDataCustomView sharedInstance] hiddenNoDataView];
        }
        [wSelf.collectionView.mj_header endRefreshing];
        [wSelf.collectionView reloadData];
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
        [wSelf.collectionView.mj_header endRefreshing];
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingIntegralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QQShoppingIntegralCellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_W, 139+141*SCREEN_W/375);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake( 7, 7, 7, 7);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_W-21)/2, 85+SCREEN_W*0.376);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WS(wSelf);
    if (kind == UICollectionElementKindSectionHeader) {
        self.head= [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:QQShoppingIntegralHeadViewID forIndexPath:indexPath];
        self.head.shopping_changeRecordBlock = ^(){
            QQChangeRecordVC *vc = [[QQChangeRecordVC alloc]init];
            [wSelf.navigationController pushViewController:vc animated:YES];
        };
        self.head.shopping_canUseBlock = ^(){
            QQShoppingIntegralListVC *vc = [[QQShoppingIntegralListVC alloc]init];
            [wSelf.navigationController pushViewController:vc animated:YES];
        };
        
        self.head.integ_BannerTapkBlock = ^(NSInteger index, NSString *pid) {
            QQShoppingIntegralDetailVC *vc = [[QQShoppingIntegralDetailVC alloc]init];
            vc.model.productId = pid;
            vc.pid = pid;
            vc.score= self.poindt;
            NSLog(@"%@",pid);
            [wSelf.navigationController pushViewController:vc animated:YES];
        };
        return self.head;
    }else{
        return  nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QQIntegListModel *model = self.dataArray[indexPath.row];
    if (model) {
        QQShoppingIntegralDetailVC *vc = [[QQShoppingIntegralDetailVC alloc]init];
        vc.model = model;
        vc.score= self.poindt;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)createUI {
    self.title = @"积分商城";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = BARTITLEBUTTON(@"积分说明", @selector(rightBtnClick));
    self.navigationItem.rightBarButtonItem.tintColor = [Tools getUIColorFromString:@"6d6d6d"];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 7;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"QQShoppingIntegralCell"  bundle:nil] forCellWithReuseIdentifier:QQShoppingIntegralCellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"QQShoppingIntegralHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:QQShoppingIntegralHeadViewID];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor =COLOR(245, 245, 247);
        WS(wSelf);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [wSelf getData];
        }];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [[NSMutableArray alloc]init];
    }
    return _bannerArray;
}

- (void)rightBtnClick {
    [self getExplainRequest];
//    QQShoppingMallVC *vc = [[QQShoppingMallVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







