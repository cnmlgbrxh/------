//
//  MyView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 17/7/3.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "MyView.h"
#import "CollectionViewCellFunction.h"
#import "CollectionReusableViewHeader.h"
#import "CollectionReusableViewFooter.h"
#import "TradingRecordsViewController.h"
#import "SmallStateViewController.h"
#import "LevelQueryViewController.h"
#import "ModifyPasswordSecondViewController.h"
#import "MyGainViewController.h"
#import "FeeDescriptionViewController.h"
#import "HelpFeedbackViewController.h"
#import "AboutQiQuViewController.h"
#import "PurchaseNumberViewController.h"
#import "PublicNumberViewController.h"
#import "InviteFriendsViewController.h"
#import "GainProductViewController.h"
#import "LoadWebViewViewController.h"
#import "QQMoneyListVC.h"
#import "QQMoneyMyEarningsVC.h"
@interface MyView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@end
@implementation MyView{
    UICollectionView *_collectionView;
    NSArray *arrData;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HOMECOLOR;
        //@{@"关注公众号":@"获取微信公众号信息"},
//        if ([USERMANAGER.level isEqualToString:@"super"]) {
            arrData = @[@{@"增益产品":@"查看理财产品"},@{@"我的增益":@"查看理财收益"},@{@"购买小号":@"购买座机或手机号码"},@{@"设置显示号码":@"设置主呼叫号码"},@{@"交易记录":@"查看明细记录"},@{@"通话变音":@"设置通话声音风格"},@{@"小号状态":@"更改号码开关状态"},@{@"修改密码":@"更改当前账户密码"},@{@"资费说明":@"查看软件介绍"},@{@"邀请好友":@"分享软件给好友"},@{@"帮助反馈":@"帮助软件反馈问题"},@{@"关于奇趣":@"更新以及使用帮助等"}];
//        }else{
//            arrData = @[@{@"交易记录":@"查看明细记录"},@{@"通话变音":@"设置通话声音风格"},@{@"修改密码":@"更改当前账户密码"},@{@"资费说明":@"查看软件介绍"},@{@"邀请好友":@"分享软件给好友"},@{@"帮助反馈":@"帮助软件反馈问题"},@{@"关于奇趣":@"更新以及使用帮助等"}];
//        }
        [self creatUI];
    }
    return self;
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
    [_collectionView reloadData];
}
#pragma mark - 设置号码
-(void)setUpShowNumber:(UIViewController *)viewController alertAddedTo:(UIView *)view{
    UIAlertController * alertDialog = [UIAlertController alertControllerWithTitle:@"设置显示号码" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *laterAction = [UIAlertAction actionWithTitle:@"本机号码" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDictionary *dicParameters = @{@"action":@"setcallerid",
                                        @"username":USERNAME,
                                        @"userpass":USERPASS,
                                        @"callerid":USERMANAGER.bindphone
                                        };
        [DataRequest POST_Parameters:dicParameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [DataManager save:@"" forKey:@"刷新用户信息"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MessageHUG showSuccessAlert:[responseObject objectForKey:@"msg"]];
            });
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[view viewWithTag:66666] removeFromSuperview];
        }];
    }];
    UIAlertAction *neverAction = [UIAlertAction actionWithTitle:@"随机号码" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDictionary *dicParameters = @{@"action":@"setcallerid",
                                        @"username":USERNAME,
                                        @"userpass":USERPASS,
                                        @"callerid":@""
                                        };
        [DataRequest POST_Parameters:dicParameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [DataManager save:@"" forKey:@"刷新用户信息"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MessageHUG showSuccessAlert:[responseObject objectForKey:@"msg"]];
            });
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[view viewWithTag:66666] removeFromSuperview];
        }];
    }];
    UIAlertAction *neverAction1 = [UIAlertAction actionWithTitle:@"自定义号码" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        LevelQueryViewController *levelQueryVC = [[LevelQueryViewController alloc] init];
        levelQueryVC.navTitle = @"设置显示号码";
        [viewController.navigationController pushViewController:levelQueryVC animated:YES];
    }];
    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    // 添加操作（顺序就是呈现的上下顺序）
    [alertDialog addAction:laterAction];
    [alertDialog addAction:neverAction];
    
    if ([USERMANAGER.level isEqualToString:@"super"]) {
        [alertDialog addAction:neverAction1];
    }
    
    [alertDialog addAction:cancalAction];
    
    [viewController presentViewController:alertDialog animated:YES completion:nil];
}
#pragma mark - 设置通话变音
-(void)setUpCallTone:(UIViewController *)viewController alertAddedTo:(UIView *)view{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *arr = @[@"默认",@"女士",@"男士",@"小孩",@"老人",@"机器人"];
    for (NSString *str in arr) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSDictionary *dicParameters = @{@"action":@"setvoice",
                                            @"username":USERNAME,
                                            @"userpass":USERPASS,
                                            @"uservoice":[NSString stringWithFormat:@"%ld",[arr indexOfObject:action.title]]
                                            };
            [DataRequest POST_Parameters:dicParameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [DataManager save:@"" forKey:@"刷新用户信息"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MessageHUG showSuccessAlert:[responseObject objectForKey:@"msg"]];
                });
            }failure:^(NSURLSessionDataTask *task, NSError *error) {
                [[view viewWithTag:66666] removeFromSuperview];
            }];
        }];
        
        [alertController addAction:action];
    }
    UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:cancalAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = arrData[indexPath.row];
    NSString *strTitle = [dic.allKeys firstObject];
    if ([strTitle isEqualToString:@"增益产品"])
    {//增益产品
//        GainProductViewController *gainProductVC = [[GainProductViewController alloc]init];
//        gainProductVC.navTitle = strTitle;
//        [_viewController.navigationController pushViewController:gainProductVC animated:YES];
        QQMoneyListVC *vc = [[QQMoneyListVC alloc]init];
        [_viewController.navigationController pushViewController:vc animated:YES];
    }else if ([strTitle isEqualToString:@"我的增益"])
    {//我的增益
//        GainProductViewController *gainProductVC = [[GainProductViewController alloc]init];
//        gainProductVC.navTitle = strTitle;
//        [_viewController.navigationController pushViewController:gainProductVC animated:YES];
        QQMoneyMyEarningsVC *vc = [[QQMoneyMyEarningsVC alloc]init];
        [_viewController.navigationController pushViewController:vc animated:YES];
    }else if ([strTitle isEqualToString:@"购买小号"])
    {//购买小号
        PurchaseNumberViewController *purchaseNumberVC = [[PurchaseNumberViewController alloc]init];
        purchaseNumberVC.navTitle = @"";
        [_viewController.navigationController pushViewController:purchaseNumberVC animated:YES];
    }else if ([strTitle isEqualToString:@"设置显示号码"])
    {//设置显示号码
        [self setUpShowNumber:_viewController alertAddedTo:self];
    }else if ([strTitle isEqualToString:@"交易记录"])
    {//交易记录
        TradingRecordsViewController *tradingRecordsVC = [[TradingRecordsViewController alloc] init];
        tradingRecordsVC.navTitle = strTitle;
        [_viewController.navigationController pushViewController:tradingRecordsVC animated:YES];
    }else if ([strTitle isEqualToString:@"通话变音"])
    {//通话变音
        [self setUpCallTone:_viewController alertAddedTo:self];
    }else if ([strTitle isEqualToString:@"小号状态"])
    {//小号状态
        SmallStateViewController *smallStateVC = [[SmallStateViewController alloc] init];
        smallStateVC.navTitle = strTitle;
        [_viewController.navigationController pushViewController:smallStateVC animated:YES];
    }else if ([strTitle isEqualToString:@"修改密码"])
    {//修改密码
        ModifyPasswordSecondViewController *modifyPasswordFirstVC = [[ModifyPasswordSecondViewController alloc] init];
        modifyPasswordFirstVC.navTitle = strTitle;
        [_viewController.navigationController pushViewController:modifyPasswordFirstVC animated:YES];
    }else if ([strTitle isEqualToString:@"资费说明"])
    {//资费说明
        LoadWebViewViewController *load = [[LoadWebViewViewController alloc]init];
        load.navTitle = strTitle;
        load.strUrl = [NSString stringWithFormat:@"rate.php?username=%@",USERNAME];
        [_viewController.navigationController pushViewController:load animated:YES];
//        FeeDescriptionViewController *feeDescriptionVC = [[FeeDescriptionViewController alloc]init];
//        feeDescriptionVC.navTitle = strTitle;
//        [_viewController.navigationController pushViewController:feeDescriptionVC animated:YES];
    }else if ([strTitle isEqualToString:@"邀请好友"])
    {//邀请好友
        InviteFriendsViewController *inviteFriendsVC = [[InviteFriendsViewController alloc]init];
        inviteFriendsVC.navTitle = strTitle;
        inviteFriendsVC.dicDetail = _dicDetail;
        [_viewController.navigationController pushViewController:inviteFriendsVC animated:YES];
    }else if ([strTitle isEqualToString:@"关注公众号"])
    {//关注公众号
        PublicNumberViewController *publicNumberVC = [[PublicNumberViewController alloc]init];
        publicNumberVC.navTitle = strTitle;
        [_viewController.navigationController pushViewController:publicNumberVC animated:YES];
    }
    else if ([strTitle isEqualToString:@"帮助反馈"])
    {//帮助反馈
        HelpFeedbackViewController *helpFeedbackVC = [[HelpFeedbackViewController alloc]init];
        helpFeedbackVC.navTitle = strTitle;
        [_viewController.navigationController pushViewController:helpFeedbackVC animated:YES];
    }else if ([strTitle isEqualToString:@"关于奇趣"])
    {//关于奇趣
        AboutQiQuViewController *AboutQiQuVC = [[AboutQiQuViewController alloc] init];
        AboutQiQuVC.navTitle = strTitle;
        [_viewController.navigationController pushViewController:AboutQiQuVC animated:YES];
    }
    

}
#pragma mark - UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionFooter) {
        CollectionReusableViewFooter *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionViewFooter" forIndexPath:indexPath];
        footView.viewController = _viewController;
        return footView;
    }else{
        CollectionReusableViewHeader *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader" forIndexPath:indexPath];
        headView.viewController = _viewController;
        headView.dicDetail = _dicDetail;
        return headView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_W, 455);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_W , Sc(162));
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrData.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCellFunction *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    cell.dicValue = arrData[indexPath.row];
    if (indexPath.row == 0 || indexPath.row == 1) {
        cell.topLine.hidden = NO;
    }else{
        cell.topLine.hidden = YES;
    }
    return cell;
}
#pragma mark - 创建UI
-(void)creatUI{
    // 瀑布流
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置大小
    flowLayout.itemSize = CGSizeMake(SCREEN_W/2, 70);
    // 设置item间隔
    //设置每组的item（如果是垂直显示 行距。如果是水平方向显示 列距）
    flowLayout.minimumLineSpacing = 0;
    // 设置 每组item（如果是垂直显示 列距。如果是水平方向显示 行距）
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset =UIEdgeInsetsMake(0,0, 0, 0);
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_W, SCREEN_H/3);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.height-64-49) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = HOMECOLOR;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:_collectionView];
    //刷新
    _collectionView.mj_header= [MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        [DataManager save:@"" forKey:@"刷新用户信息"];
        [_collectionView.mj_header   endRefreshing];
    }];
    
    // item注册
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCellFunction class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ID"];
    //注册头视图
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableViewHeader" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    //注册尾视图
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableViewFooter" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionViewFooter"];
}
@end
