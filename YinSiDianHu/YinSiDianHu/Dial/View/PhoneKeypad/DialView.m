//
//  DialView.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "DialView.h"
#import "NumCollectionViewCell.h"
#import "NumData.h"

@interface DialView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation DialView{
    UICollectionView *_collectionView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    // 瀑布流
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置大小
    flowLayout.itemSize = CGSizeMake(SCREEN_W/3, Scale(270)/4);
    // 设置item间隔
    //设置每组的item（如果是垂直显示 行距。如果是水平方向显示 列距）
    flowLayout.minimumLineSpacing = 0;
    // 设置 每组item（如果是垂直显示 列距。如果是水平方向显示 行距）
    flowLayout.minimumInteritemSpacing = 0;
    //flowLayout.sectionInset =UIEdgeInsetsMake(1,0, 1, 0);//上左下右
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.height) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = WHITECOLOR;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
    [self addSubview:_collectionView];
    // item注册
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NumCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ID"];
    
}
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    cell.data = [NumData getData:indexPath.row];
    return cell;
}
@end
