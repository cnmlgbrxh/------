//
//  QQShoppingPostAndPayView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingPostAndPayView.h"
#import "QQShoppingPostAndPayCell.h"
#import "QQShoppingConfirmStyleModel.h"
#import <WXApi.h>

@interface QQShoppingPostAndPayView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
@implementation QQShoppingPostAndPayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    [self addSubview:self.tableView];
}

- (void)show {
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, SCREEN_H);
    self.backgroundColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:0.55];
    
    self.alpha = 0;
    [self.tableView setFrame:CGRectMake(0, SCREEN_H, SCREEN_W,250)];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.tableView setFrame:CGRectMake(0, SCREEN_H-250, SCREEN_W,250)];
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)hide {
    self.alpha = 0.55;
    [self.tableView setFrame:CGRectMake(0, SCREEN_H-250, SCREEN_W,250)];
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0;
        [self.tableView setFrame:CGRectMake(0, SCREEN_H, SCREEN_W,250)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView *view = touch.view;
    if (view.height == 50) {
        return NO;
    }
    return  YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.isBalance && indexPath.row == 3) {
        [[RSMBProgressHUDTool shareProgressHUDManager]showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"余额不足、请先充值"];
        return;
    }
    [self hide];
    if (indexPath.row == 0) {
        return;
    }
    QQShoppingConfirmStyleModel *model = self.dataArray[indexPath.row-1];
    if (self.shopping_postAndPayBlock) {
        self.shopping_postAndPayBlock(model.styleKey,self.isPost?@"":model.imageName);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QQShoppingPostAndPayHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingPostAndPayHeadCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(wSelf);
        cell.shopping_payHeadViewBlock = ^{
            [wSelf hide];
        };
        return  cell;
    }
    QQShoppingPostAndPayCell *cell = [tableView dequeueReusableCellWithIdentifier:QQShoppingPostAndPayCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 1) {
        cell.lineLeading.constant = 0;
    }
    QQShoppingConfirmStyleModel *model = self.dataArray[indexPath.row-1];
    [cell.imageBtn setImage:QQIMAGE(model.imageName) forState:UIControlStateNormal];
    cell.nameLabel.text = model.styleKey;
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,SCREEN_H, SCREEN_W, 250) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        [_tableView registerNib:[UINib nibWithNibName:@"QQShoppingPostAndPayCell" bundle:nil] forCellReuseIdentifier:QQShoppingPostAndPayCellID];
        [_tableView registerClass:[QQShoppingPostAndPayHeadCell class] forCellReuseIdentifier:QQShoppingPostAndPayHeadCellID];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _tableView;
}

- (void)setIsPost:(BOOL)isPost {
    self.dataArray = [[NSMutableArray alloc]init];
    _isPost = isPost;
    NSArray *titleArr;
    NSArray *imageArr;
    if (isPost) {
        titleArr= @[@"顺丰速运",@"圆通快递",@"中通快递"];
        imageArr = @[@"shopping_SF",@"shopping_yt",@"shopping_zto"];
        
    }else{
        if (self.isBalance) {
            imageArr = @[@"shopping_zfb",@"shopping_wechat",@"shopping_yeb"];
        }else{
            imageArr = @[@"shopping_zfb",@"shopping_wechat",@"shopping_yeb_nor"];
        }
        titleArr= @[@"支付宝",@"微信",@"余额"];
    }
    for (int i = 0; i<titleArr.count; i++) {
        QQShoppingConfirmStyleModel *model = [[QQShoppingConfirmStyleModel alloc]init];
        model.styleKey = titleArr[i];
        model.imageName = imageArr[i];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}
@end
