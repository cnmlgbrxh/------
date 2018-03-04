//
//  ProgressView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ProgressView.h"

#define KProgressBorderWidth 2.0f
#define KProgressPadding 1.0f
#define KProgressColor ColorHex(0x4f7489)
@interface ProgressView ()

@end

@implementation ProgressView{
    UIView *borderView;
    UIView *tView;
    UILabel *labPro;
}
/*
 WS(wSelf);
 [self.titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.left.right.mas_equalTo(wSelf);
 make.height.mas_equalTo(100);
 }];
 
 [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(wSelf.titleBgView.mas_bottom);
 make.left.right.bottom.mas_equalTo(wSelf);
 }];
 
 [self.explianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(wSelf.bgView).mas_offset(10);
 make.centerY.mas_equalTo(wSelf.bgView);
 }];
 
 [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(wSelf.titleBgView).mas_offset(10);
 make.right.mas_equalTo(wSelf.titleBgView).mas_offset(-10);
 make.top.mas_equalTo(wSelf.titleBgView).mas_offset(19);
 }];
 
 [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerX.mas_equalTo(wSelf.titleBgView);
 make.top.mas_equalTo(wSelf.titleLabel.mas_bottom).mas_offset(15);
 }];
 */
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        
//        
//    }
//    
//    return self;
//}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = WHITECOLOR;
        
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"图片上传";
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:20];
    lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(Sc(54));
        make.height.mas_equalTo(21);
    }];
    
    //边框
    borderView = [[UIView alloc] init];
    borderView.layer.cornerRadius = Sc(22) * 0.5;
    borderView.layer.masksToBounds = YES;
    borderView.backgroundColor = [UIColor whiteColor];
    borderView.layer.borderColor = [KProgressColor CGColor];
    borderView.layer.borderWidth = KProgressBorderWidth;
    [self addSubview:borderView];
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Sc(43));
        make.right.mas_equalTo(-Sc(43));
        make.top.mas_equalTo(lab.mas_bottom).mas_offset(Sc(60));
        make.height.mas_equalTo(Sc(22));
    }];
    
    //进度
    tView = [[UIView alloc] init];
    tView.backgroundColor = KProgressColor;
    tView.layer.cornerRadius = Sc(22)* 0.5;
    tView.layer.masksToBounds = YES;
    [self addSubview:tView];
    
    labPro = [[UILabel alloc]init];
    labPro.text = @"0%";
    labPro.textColor = ColorHex(0xa6a6a6);
    labPro.font = [UIFont systemFontOfSize:14];
    labPro.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labPro];
    [labPro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(borderView.mas_bottom).mas_offset(Sc(24));
        make.height.mas_equalTo(17);
    }];
}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    CGFloat maxWidth = borderView.width;
    CGFloat heigth = Sc(22) - 1;
    
    tView.frame = CGRectMake(borderView.x, borderView.y, maxWidth * progress, heigth);
    
    labPro.text = [NSString stringWithFormat:@"%.0lf%%",_progress*100];
}

@end
