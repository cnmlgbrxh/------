//
//  QQShoppingMallVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/4.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingMallVC.h"
#import "QQIntegralMallVC.h"
#import "QQIntegralMallVC.h"
#import "QQShoppingHeadView.h"
#import "QQShoppingMallModel.h"
#import "QQSearchRecordVC.h"
#import "QQShoppingCollectionCell.h"
#import "QQShoppingClassificationVC.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "QQShoppingProducDetailVC.h"
#import "QQShoppingCarVC.h"
#import "ZeroBuyVC.h"
#import "QQShoppingOrderViewController.h"
#import "QQShoppingBannerModel.h"
#import "RechargeViewController.h"
#import "QQShoppingNewProductVC.h"
#import "SDShowHUDView.h"

@interface QQShoppingMallVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) QQShoppingHeadView *headView;
@property(nonatomic,strong) QQBaseCollectionView *collectionView;
@property(nonatomic,strong) UIButton *topBtn;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,strong) NSMutableArray *bannerArray;
@property(nonatomic,strong) UIView *topHeadView;
@property(nonatomic,assign) NSInteger first;
@property(nonatomic,assign) NSInteger second;
@end

@implementation QQShoppingMallVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.headView.cycleScrollView adjustWhenControllerViewWillAppera];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.first = 1;
    [self getBanner];
}

- (void)refreshData {
    self.page = 1;
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self getRequestData];
}

- (void)getBanner {
    [HYBNetworking setTimeout:30];
    [[SDShowHUDView sharedHUDView]showLoading];
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@",shopping_listBannerURL,[UserManager shareManager].userName];
        NSLog(@"banner --- %@",QQ_API_CON(urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        wSelf.first = 1;
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingBannerModel class] json:response];
        [wSelf.bannerArray removeAllObjects];
        [wSelf.bannerArray addObjectsFromArray:tempArr];
        [wSelf getRequestData];
        //NSLog(@"%@",response);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getRequestData {
    WS(wSelf);
//        [[RSMBProgressHUDTool shareProgressHUDManager] showViewLoadingHUD:self.view showText:@"正在加载..."];
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@",QQProductSmallURL,[UserManager shareManager].userName];
         NSLog(@"%@",QQ_API_CON(urlStr));
    [HYBNetworking getWithUrl:QQ_API_CON(urlStr) refreshCache:YES success:^(id response) {
        wSelf.first = 2;
        if (wSelf.page == 1) {
            [wSelf.dataArray removeAllObjects];
        }
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
        //        NSLog(@"商品列表页数据-----%@",response);
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingMallModel class] json:response[@"list"]];
        [wSelf.dataArray addObjectsFromArray:tempArr];
        if (wSelf.dataArray.count == 0) {
            [[BSNoDataCustomView sharedInstance] showCustormViewToTargetView:self.view promptText:@"暂无相关商品、敬请期待哦~" customViewFrame:CGRectMake(0, 450, SCREEN_W, SCREEN_H-450)];
            [wSelf.collectionView hiddenRefresh];
        }else{
            [[BSNoDataCustomView sharedInstance] hiddenNoDataView];
        }
        if (wSelf.bannerArray) {
            wSelf.headView.bannerArray = wSelf.bannerArray;
        }
        [wSelf.collectionView reloadData];
        [wSelf.collectionView endRefresh];
        if (tempArr.count == 0) {
            [wSelf.collectionView.mj_footer setState:MJRefreshStateNoMoreData];
        }else{
            wSelf.page ++;
            [wSelf.collectionView.mj_footer setState:MJRefreshStateIdle];
        }
    } fail:^(NSError *error) {
        if (error.code == -1009) {
            [[BSNoDataCustomView sharedInstance]showReloadViewToTargetView:self.view customViewFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-4)];
            [BSNoDataCustomView sharedInstance].BSNoDataCustomViewBlock = ^{
                [wSelf getRequestData];
            };
        }
        [self.collectionView endRefresh];
        [[RSMBProgressHUDTool shareProgressHUDManager]hiddenHUD];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
        [self.collectionView hiddenRefresh];
    }];
}

- (void)createUI {
    self.title = @"商城";
    self.page = 1;
    self.view.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
    [self.view addSubview:self.topBtn];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.topHeadView];
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

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={SCREEN_W,75+SCREEN_W*0.46+104*QQAdapter+7};
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(7, 7, 7, 7);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        WS(wSelf);
        self.headView= [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:QQShoppingHeadViewIdentifier forIndexPath:indexPath];
        self.headView.bgView.shopping_headViewBtnClickBlock = ^(NSInteger tag) {
            [wSelf headViewBtnClick:tag];
        };
        self.headView.shopping_shoppingBannerTapkBlock = ^(NSInteger index,NSString *pid) {
            QQShoppingProducDetailVC *vc = [[QQShoppingProducDetailVC alloc]init];
            vc.pid = pid;
            [wSelf.navigationController pushViewController:vc animated:YES];
        };
    self.headView.shopping_midImageViewClickBlock = ^(NSInteger tag) {
        if (tag == 14) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"暂未开放、敬请期待哦~"];
        }else{
            QQIntegralMallVC *vc = [[QQIntegralMallVC alloc]init];
            [wSelf.navigationController pushViewController:vc animated:YES];
        }
    };
        return self.headView;
    }else{
        return  nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (SCREEN_W-21)/2;
    return CGSizeMake(width, 167*SCREEN_W/375+5+15+34+10+17);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= SCREEN_W*0.46+7 ) {
        self.topHeadView.hidden = NO;
    }else{
        self.topHeadView.hidden = YES;
    }
}

- (void)headViewBtnClick:(NSInteger)tag {
    if (tag == 10) {
        QQShoppingCarVC *vc = [[QQShoppingCarVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tag == 11) {
        QQShoppingOrderViewController *vc = [[QQShoppingOrderViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tag == 12){
        QQShoppingNewProductVC *vc = [[QQShoppingNewProductVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        RechargeViewController  *vc = [[RechargeViewController alloc]init];
        vc.navTitle = @"账户充值";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QQShoppingProducDetailVC *vc = [[QQShoppingProducDetailVC alloc]init];
    QQShoppingMallModel *model = self.dataArray[indexPath.row];
    vc.pid = model.productId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- LazyLoad

- (UIView *)topHeadView {
    if (!_topHeadView) {
        _topHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_W==375?60:70, SCREEN_W, 75+10)];
        _topHeadView.backgroundColor = [UIColor whiteColor];
        _topHeadView.hidden = YES;
        
        QQShoppingHeadItemView *headView = [[QQShoppingHeadItemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 75)];
        WS(wSelf);
        headView.shopping_headViewBtnClickBlock = ^(NSInteger tag) {
            [wSelf headViewBtnClick:tag];
        };
        [_topHeadView addSubview:headView];
    }
    return _topHeadView;
}

- (UIButton *)topBtn {
    if (!_topBtn) {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topBtn setImage:QQIMAGE(@"shopping_searchBar") forState:UIControlStateNormal];
        _topBtn.frame = CGRectMake(10, 23, SCREEN_W-20,SCREEN_W==375?28:38);
        [_topBtn addTarget:self action:@selector(setarchBtnDown:) forControlEvents:UIControlEventTouchDown];
        [_topBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //        _topBtn.userInteractionEnabled = NO;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-20, 40*QQAdapter)];
        view.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchBtnClick)];
        [view addGestureRecognizer:tap];
        view.userInteractionEnabled = YES;
        [_topBtn addSubview:view];
    }
    return _topBtn;
}

- (QQBaseCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 7;
        _collectionView = [[QQBaseCollectionView alloc]initWithFrame:CGRectMake(0, SCREEN_W==375?60:70, SCREEN_W, SCREEN_H-(SCREEN_W==375?60:70)-49) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:QQShoppingCollectionCellClass bundle:nil] forCellWithReuseIdentifier:QQShoppingCollectionCellID];
        [self.collectionView registerClass:[QQShoppingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:QQShoppingHeadViewIdentifier];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [Tools getUIColorFromString:@"f7f7f7"];
        WS(wSelf);
//        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            [wSelf getRequestData];
//        }];
        
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            wSelf.page = 1;
            [wSelf getBanner];
            [wSelf getRequestData];
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
#pragma mark --- btnClick
- (void)rightBtnClick {
    QQShoppingCarVC *vc = [[QQShoppingCarVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBtnClick {
    QQSearchRecordVC *vc = [[QQSearchRecordVC alloc]init];
    vc.status = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setarchBtnDown:(UIButton *)btn {
    btn.backgroundColor = [UIColor clearColor];
    btn.imageView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end









