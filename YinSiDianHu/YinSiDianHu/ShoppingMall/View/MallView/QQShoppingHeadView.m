//
//  QQShoppingHeadView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingHeadView.h"
#import "QQShoppingBannerModel.h"

@interface QQShoppingHeadView ()
@property (nonatomic,strong) UIView *footBGView;
@end
@implementation QQShoppingHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.cycleScrollView];
    [self addSubview:self.bgView];
    [self addSubview:self.footBGView];
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView){
        _cycleScrollView = [ SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W*0.46) imageURLStringsGroup:nil];
//        _cycleScrollView.placeholderImage = QQIMAGE(@"shopping_placeHolderImage");
        _cycleScrollView.currentPageDotColor =[Tools getUIColorFromString:@"0xd22120"];
        _cycleScrollView.pageDotColor = WHITECOLOR;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.autoScrollTimeInterval = 4;
        _cycleScrollView.autoScroll = YES;
        _cycleScrollView.infiniteLoop = YES;
        _cycleScrollView.backgroundColor = [UIColor colorWithPatternImage:QQIMAGE(@"shopping_placeHolderImage")];
        
        WS(wSelf);
        _cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            if (wSelf.shopping_shoppingBannerTapkBlock) {
                QQShoppingBannerModel *model = wSelf.bannerArray[currentIndex];
                wSelf.shopping_shoppingBannerTapkBlock(currentIndex,model.p_id);
            }
        };
    }
    return _cycleScrollView;
}

- (QQShoppingHeadItemView *)bgView {
    if (!_bgView) {
        _bgView = [[QQShoppingHeadItemView alloc]initWithFrame:CGRectMake(0, self.cycleScrollView.height+7, SCREEN_W, 75+10)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIView *)footBGView {
    if (!_footBGView) {
        _footBGView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bgView.y+self.bgView.height, SCREEN_W, 95*QQAdapter)];
        _footBGView.backgroundColor = [UIColor whiteColor];
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 7, (SCREEN_W-1-20)/2, 83*QQAdapter)];
        leftView.backgroundColor = [UIColor whiteColor];
        [_footBGView addSubview:leftView];
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(leftView.x+leftView.width+1, 7, leftView.width, leftView.height)];
        rightView.backgroundColor = [UIColor whiteColor];
        [_footBGView addSubview:rightView];
        
        
        UIImageView *leftImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, leftView.width-14, leftView.height)];
        leftImageView.userInteractionEnabled = YES;
        leftImageView.image = QQIMAGE(@"shopping_mallLeftImage");
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLeftImageView)];
        [leftImageView addGestureRecognizer:leftTap];
        [leftView addSubview:leftImageView];
        
        UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(14,0, leftView.width-14, rightView.height)];
        rightImageView.userInteractionEnabled = YES;
        rightImageView.image = QQIMAGE(@"shopping_mallRightImage");
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRightImageView)];
        [rightImageView addGestureRecognizer:rightTap];
        [rightView addSubview:rightImageView];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 7, SCREEN_W, 0.5)];
        line.backgroundColor = [Tools getUIColorFromString:@"eaeaea"];
        [_footBGView addSubview:line];
        
        UIView *midLine = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2, 7, 0.5, 95*QQAdapter-7)];
        midLine.backgroundColor = [Tools getUIColorFromString:@"eaeaea"];
        [_footBGView addSubview:midLine];
    }
    return _footBGView;
}

- (void)tapLeftImageView {
    if (self.shopping_midImageViewClickBlock) {
        self.shopping_midImageViewClickBlock(14);
    }
}

- (void)tapRightImageView {
    if (self.shopping_midImageViewClickBlock) {
        self.shopping_midImageViewClickBlock(15);
    }
}

- (void)setBannerArray:(NSArray *)bannerArray {
    _bannerArray = bannerArray;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<bannerArray.count; i++) {
        QQShoppingBannerModel *model = bannerArray[i];
        [arr addObject:model.p_url];
    }
    self.cycleScrollView.imageURLStringsGroup = arr;
}
@end



@interface QQShoppingClassificationHeadView ()
@property(nonatomic,strong)UILabel *label;
@end
@implementation QQShoppingClassificationHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.label = [[UILabel alloc]init];
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.textColor = [Tools getUIColorFromString:@"6d6d6d"];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);;
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setSectionTitle:(NSString *)sectionTitle {
    self.label.text = sectionTitle;
}
@end





@interface QQShoppingHeadItemView()
@end
@implementation QQShoppingHeadItemView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    NSArray *titleArr = @[@"购物车",@"我的订单",@"新品上市",@"余额充值"];
    NSArray *iconArr = @[@"shopping_iconLeft1",@"shopping_iconLeft3",@"shopping_iconLeft2",@"shopping_iconLeft4"];
    for (int i =0 ;i<titleArr.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:QQIMAGE(iconArr[i]) forState:UIControlStateNormal];
        btn.frame = CGRectMake(i*SCREEN_W/4, 10, SCREEN_W/4, QQAdapterSpacingValure(45));
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*SCREEN_W/4, btn.height+10+7, SCREEN_W/4, 15)];
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}

- (void)btnClick:(UIButton *)btn {
    if (self.shopping_headViewBtnClickBlock) {
        self.shopping_headViewBtnClickBlock(btn.tag);
    }
}

@end
