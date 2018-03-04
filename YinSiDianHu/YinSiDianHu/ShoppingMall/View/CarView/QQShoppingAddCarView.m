//
//  QQShoppingAddCarView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingAddCarView.h"
#import "QQAddCarNamePriceCell.h"
#import "QQAddCarNumChangeCell.h"
#import "JHCustomFlow.h"
#import "RSWebServiceURL.h"
#import <HYBNetworking/HYBNetworking.h>
#import "QQShoppingCarModel.h"
#import "QQShoppingConfirmOrder.h"
#import "SDShowHUDView.h"

@interface QQShoppingAddCarView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)QQAddCarNamePriceCell *headView;
@property(nonatomic,strong)UIButton *yesBtn;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *grayView;
@property(nonatomic,strong)NSMutableArray *indepathArr;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *selectedArray;//选中item后放选中的标题
@property(nonatomic,strong)NSString *num;//数量
@end
@implementation QQShoppingAddCarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (NSString *)createProduct_dp {
    NSString *produStr= @"";
    for (int i = 0; i<self.indepathArr.count; i++) {
        //拿出item上的文字 如：红色
        NSIndexPath *indexPath = self.indepathArr[i];
        NSArray *temp = self.dataArray[indexPath.section];
        NSString *itemStr = temp[indexPath.row];
        
        //拿文字对应的标题  如：颜色
        for (NSString *tempStr in self.productArray) {
            if ([tempStr containsString:itemStr]) {
                NSArray *t = [tempStr componentsSeparatedByString:@":"];
                NSString *title = t[0];
                produStr =  [produStr stringByAppendingString:[NSString stringWithFormat:@"%@:",title]];
            }
        }
        produStr = [produStr stringByAppendingString:[NSString stringWithFormat:@"%@ ",itemStr]];
        NSLog(@"拼接的字符串 ----- %@",produStr);
    }
    return produStr;
}

- (void)addCarRequest {
    NSString *utf8 = [[self createProduct_dp] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSString stringWithFormat:@"%@username=%@&pid=%@&num=%@&product_dp=%@",shopping_addCarURL,[UserManager shareManager].userName,self.pid,self.num,utf8.length>0?utf8:@"?"];
    //NSLog(@"加入购物车请求的url---------------%@",QQ_API_CON(str));
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        // NSLog(@"加入购物车-------%@   %@",response,response[@"msg"]);
        if ([response[@"stats"] isEqualToString:@"ok"]) {
            [self hide];
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"添加成功，在购物车等亲~"];
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];

        }
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)show {
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    self.alpha = 0;
//    if (self.productArray.count > 0) {
        [self.bgView setFrame:CGRectMake(0, SCREEN_H, SCREEN_W,SCREEN_H-self.grayView.height-50)];
//    }else{
//        [self.bgView setFrame:CGRectMake(0, SCREEN_H, SCREEN_W,SCREEN_H-self.grayView.height-50 )];
//    }
//    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        if (self.productArray.count > 0) {
//            [self.bgView setFrame:CGRectMake(0, 260, SCREEN_W, SCREEN_H-260)];
//        }else{
//            [self.bgView setFrame:CGRectMake(0, 320*SCREEN_W/375, SCREEN_W, SCREEN_H-390*SCREEN_W/375)];
//        }
        
        self.alpha = 1;
        [self makeOtherLayout];
    } completion:^(BOOL finished) {
    }];
}

- (void)hide {
    self.alpha = 1;
    WS(wSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(wSelf);
        make.bottom.mas_equalTo(wSelf.yesBtn.mas_top);
        make.top.mas_equalTo(wSelf.grayView.mas_bottom);
    }];
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0;
//        if (self.productArray.count > 0) {
            [self.bgView setFrame:CGRectMake(0, SCREEN_H, SCREEN_W,SCREEN_H-260)];
//        }else{
//            [self.bgView setFrame:CGRectMake(0, SCREEN_H, SCREEN_W,SCREEN_H-330)];
//        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setProductArray:(NSArray *)productArray {
    _productArray = productArray;
    for (NSString *titleStr in productArray) {
        NSArray *temp = [titleStr componentsSeparatedByString:@":"];
        [self.titleArray addObject:temp[0]];
        NSString *str = temp[1];
        [self.dataArray addObject:[str componentsSeparatedByString:@","]];
    }
    [self resetHeight];
    [self.collectionView reloadData];
}

- (void)resetHeight {
//    if (self.titleArray.count == 0) {
//        self.grayView.frame = CGRectMake(0, 0, SCREEN_W, 340*SCREEN_W/375);
//    }else{
        self.grayView.frame = CGRectMake(0, 0, SCREEN_W, 260);
//    }
}

- (void)setModel:(QQShoppingProductDetailModel *)model {
    _model = model;
    self.headView.model = model;
}

#pragma mark ---- delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.productArray.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == self.dataArray.count) {
        return 1;
    }
    return [self.dataArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.dataArray.count) {
        QQAddCarNumChangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QQAddCarNumChangeCellID forIndexPath:indexPath];
        WS(wSelf);
        cell.shopping_addCarNumBlock = ^(NSString *numStr) {
            wSelf.num = numStr;
        };
        return cell;
    }
    
    QQAddCarPropertyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QQAddCarPropertyCellID forIndexPath:indexPath];
    NSArray *temp = self.dataArray[indexPath.section];
    cell.propertyLabel.text = temp[indexPath.row];
    cell.propertyLabel.frame = cell.bounds;
    if ([self.indepathArr containsObject:indexPath]) {
        cell.propertyLabel.layer.borderColor = [Tools getUIColorFromString:@"f70d00"].CGColor;
        cell.propertyLabel.textColor = [Tools getUIColorFromString:@"f70d00"];
    }else{
        cell.propertyLabel.layer.borderColor = [Tools getUIColorFromString:@"c5c5c5"].CGColor;
        cell.propertyLabel.textColor = [Tools getUIColorFromString:@"2a2a2a"];
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section != self.dataArray.count) {
        return UIEdgeInsetsMake(0, 12,0, 12);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == indexPath.section) {
        return CGSizeMake(SCREEN_W, 80);
    }
    NSArray *temp = self.dataArray[indexPath.section];
    CGSize size = [temp[indexPath.row] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil]];
    return CGSizeMake(size.width+20, 26);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        QQAddCarHeadView *heade= [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:QQAddCarHeadViewID forIndexPath:indexPath];
        heade.titleLabel.text = self.titleArray[indexPath.section];
        return heade;
    }else{
        return  nil;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == self.dataArray.count) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(SCREEN_W, 35);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.productArray.count) {
        return;
    }else{
    NSIndexPath *temp = nil;
    for (NSIndexPath *inde in self.indepathArr) {
        if (inde.section == indexPath.section) {
            temp = inde;
            break;
        }
    }
    QQAddCarPropertyCell *cell1 = (QQAddCarPropertyCell *)[collectionView cellForItemAtIndexPath:temp];
    cell1.propertyLabel.layer.borderColor = [Tools getUIColorFromString:@"c5c5c5"].CGColor;
    cell1.propertyLabel.textColor = [Tools getUIColorFromString:@"2a2a2a"];
    [self.indepathArr removeObject:temp];
    if ([[collectionView cellForItemAtIndexPath:indexPath] isMemberOfClass:[QQAddCarPropertyCell class]]) {
        QQAddCarPropertyCell *cell = (QQAddCarPropertyCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.propertyLabel.layer.borderColor = [Tools getUIColorFromString:@"f70d00"].CGColor;
        cell.propertyLabel.textColor = [Tools getUIColorFromString:@"f70d00"];
    }
    [self.indepathArr addObject:indexPath];
    if (![self.selectedArray containsObject:self.titleArray[indexPath.section]]) {
        [self.selectedArray addObject:self.titleArray[indexPath.section]];
    }
    NSLog(@"%@   %@",self.selectedArray,self.titleArray);
    }
}

- (void)createUI {
    [self addSubview:self.grayView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headView];
    [self.bgView addSubview:self.collectionView];
    self.num = @"1";
    [self addSubview:self.yesBtn];
    [self setAutolayout];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self.grayView addGestureRecognizer:tapGesture];
}

- (void)makeOtherLayout {
    WS(wSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(wSelf);
        make.bottom.mas_equalTo(wSelf.yesBtn.mas_top);
        make.top.mas_equalTo(wSelf.grayView.mas_bottom);
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(wSelf.bgView);
        make.height.mas_equalTo(101);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(wSelf.bgView);
        make.top.mas_equalTo(wSelf.headView.mas_bottom);
    }];
}

- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc]init];
        _grayView.backgroundColor = [UIColor clearColor];
    }
    return _grayView;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [[NSMutableArray alloc]init];
    }
    return _selectedArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        JHCustomFlow *layout = [[JHCustomFlow alloc]init];
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 7;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[QQAddCarHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:QQAddCarHeadViewID];
        [_collectionView registerNib:[UINib nibWithNibName:@"QQAddCarNumChangeCell" bundle:nil] forCellWithReuseIdentifier:QQAddCarNumChangeCellID];
        [_collectionView registerClass:[QQAddCarPropertyCell class] forCellWithReuseIdentifier:QQAddCarPropertyCellID];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (QQAddCarNamePriceCell *)headView {
    if (!_headView) {
        _headView = [[NSBundle mainBundle]loadNibNamed:@"QQAddCarNamePriceCell" owner:self options:nil][0];
        _headView.backgroundColor = [UIColor clearColor
                                     ];
        WS(wSelf);
        _headView.shopping_hiddenGrayViewBlock = ^{
            [wSelf hide];
        };
    }
    return _headView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UIButton *)yesBtn {
    if (!_yesBtn) {
        _yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yesBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_yesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _yesBtn.backgroundColor = [Tools getUIColorFromString:@"ff564d"];
        _yesBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_yesBtn addTarget:self action:@selector(yesBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _yesBtn.userInteractionEnabled = YES;
    }
    return _yesBtn;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

- (NSMutableArray *)indepathArr {
    if (!_indepathArr) {
        _indepathArr = [[NSMutableArray alloc]init];
    }
    return _indepathArr;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc]init];
    }
    return _titleArray;
}

- (void)tappedCancel {
    [self hide];
}

- (void)yesBtnClick {

    if (self.selectedArray.count < self.titleArray.count) {
        NSMutableArray *arr1 = [[NSMutableArray alloc]initWithArray:[self.titleArray copy]];
        NSMutableArray *arr2 = [[NSMutableArray alloc]initWithArray:[self.selectedArray copy]];
        [arr1 removeObjectsInArray:arr2];
        [[SDShowHUDView sharedHUDView]showImage:@"QQ_warning" withTitle:[NSString stringWithFormat:@"请选择 %@",arr1[0]]];
//        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:[NSString stringWithFormat:@"请选择 %@",arr1[0]]];
        return;
    }
    if (_addCar) {
        [self addCarRequest];
    }else{
        if (self.shopping_toConfirmOrderVCBlock) {
            self.shopping_toConfirmOrderVCBlock([self createProduct_dp],self.num);
        }
    }
}

- (void)setAutolayout {
    WS(wSelf);
    [self.yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(wSelf);
        make.height.mas_equalTo(50);
    }];
}

- (void)dealloc {
    NSLog(@"释放啦");
}
@end
