//
//  SDShowHUDView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "SDShowHUDView.h"
#import "QQShoppingTools.h"
#import <HYBNetworking/HYBNetworking.h>
@interface SDShowHUDView()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *imageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,assign)NSInteger time;
@property(nonatomic,strong)UIActivityIndicatorView *indicator;
@end

@implementation SDShowHUDView

+(instancetype)sharedHUDView {
    static SDShowHUDView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[SDShowHUDView alloc]init];
        view.backgroundColor =[UIColor clearColor];
        view.userInteractionEnabled = YES;
    });
    return view;
}

- (void)createUI {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    [self addGestureRecognizer:tap];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    [window addSubview:self];
}

- (void)startTime {
    self.time = 3;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeReduce:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timeReduce:(NSTimer *)timer {
     --self.time ;
    if (self.time == 0) {
        [timer  invalidate];
        [self removeFromSuperview];
    }
}

- (void)hidden {
    if (self.indicator) {
        [self.indicator stopAnimating];
        [self.indicator removeFromSuperview];
    }
    if (self.imageView) {
        [self.imageView removeFromSuperview];
    }
    if (self.titleLabel) {
        [self.titleLabel removeFromSuperview];
    }
    [self removeFromSuperview];
//    [HYBNetworking cancelAllRequest];
}

-(void)showImage:(NSString *)imageName withTitle:(NSString *)title {
    [self createUI];
    [self startTime];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil];
    CGFloat width =rect.size.width>200?200:rect.size.width;
    self.bgView.frame = CGRectMake((SCREEN_W-width-30)/2, (SCREEN_H-80)/2, width+30, width<200?80:100);
    self.imageView.frame = CGRectMake(0, 10, self.bgView.frame.size.width, 30);
    self.titleLabel.frame = CGRectMake(15, 37, self.bgView.frame.size.width-30, self.bgView.height-10-35);
    [self.imageView setImage:QQIMAGE(imageName) forState:UIControlStateNormal];
    self.titleLabel.text = title;
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.imageView];
    if (self.indicator) {
        [self.indicator removeFromSuperview];
    }
    [self.bgView addSubview:self.titleLabel];
}

- (void)showLoading {
    [self createUI];
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    CGRect rect = [@"正在加载" boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil];
    self.bgView.frame = CGRectMake((SCREEN_W-rect.size.width-30)/2, (SCREEN_H-80)/2, rect.size.width+30, 80);
    self.indicator.frame = CGRectMake(0, 10, self.bgView.frame.size.width, 35);
    self.titleLabel.frame = CGRectMake(0, 45, self.bgView.frame.size.width, 30);
    self.titleLabel.text = @"正在加载";
    [self addSubview:self.bgView];
    [self.indicator startAnimating];
    [self.bgView addSubview:self.indicator];
    if (self.imageView) {
        [self.imageView removeFromSuperview];
    }
    [self.bgView addSubview:self.titleLabel];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 3;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    }
    return _bgView;
}

- (UIButton *)imageView {
    if (!_imageView) {
        _imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageView.userInteractionEnabled = NO;
    }
    return _imageView;
}

@end
