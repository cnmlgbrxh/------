//
//  TalkingViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/11.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "TalkingViewController.h"
@interface TalkingViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
//波
@property (nonatomic, strong) CAShapeLayer *waveLayer1;
@property (nonatomic, strong) CAShapeLayer *waveLayer2;
@property (nonatomic, strong) CAShapeLayer *waveLayer3;

@end

@implementation TalkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layout];
    
    _labTime.text = [NSString stringWithFormat:@"正在回拨%@，请注意接听...",USERNAME];
    
    //创建波
    [self buildWaveLayers];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}
-(void)layout{
    _layTop.constant = Sc(155);
    _layTop1.constant = Sc(100);
    _layTop2.constant = Sc(707);
    _layLeft.constant = Sc(300);
}
-(void)setContactModel:(ContactModel *)contactModel{
    _contactModel = contactModel;
    _labName.text = _contactModel.name?:_contactModel.phoneNumber;
}
#pragma mark - 程序不处于活跃状态时,取消该界面
-(void)willResignActive:(NSNotification *)notification{
    [self dismissViewControllerAnimated:YES completion:^{
        [self stopWaveAnimation];
    }];
}
#pragma mark - 挂断
- (IBAction)hangUp:(UIButton *)sender {
    NSDictionary *dicParameters = @{@"action":@"hangupcall",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS
                                    };
    WeakSelf
    [DataRequest POST_Parameters:dicParameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            [weakSelf stopWaveAnimation];
        }];
//        {
//            msg = "\U6210\U529f\U6302\U65ad\U5f53\U524d\U547c\U53eb";
//            stats = ok;
//        }
    }];
    
}
#pragma mark - 改变状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark - 水波动画
- (void)startWaveAnimation
{
    CABasicAnimation *animation1 = [CABasicAnimation animation];
    animation1.duration = 1.5;
    animation1.repeatCount = MAXFLOAT;
    animation1.keyPath = @"transform";
    animation1.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(SCREEN_W, 0, 0)];
    
    [_waveLayer1 addAnimation:animation1 forKey:nil];
    [_waveLayer2 addAnimation:animation1 forKey:nil];
    [_waveLayer3 addAnimation:animation1 forKey:nil];
}

- (void)stopWaveAnimation
{
    [_waveLayer1 removeAllAnimations];
    [_waveLayer2 removeAllAnimations];
    [_waveLayer3 removeAllAnimations];
    
    [_waveLayer1 removeFromSuperlayer];
    [_waveLayer2 removeFromSuperlayer];
    [_waveLayer3 removeFromSuperlayer];
}
- (void)buildWaveLayers{
    
    _waveLayer1 = [CAShapeLayer layer];
    _waveLayer1.fillColor = [UIColor clearColor].CGColor;
    _waveLayer1.strokeColor = ColorHexWithAlpha(0x9e9e9e, 0.5).CGColor;
    _waveLayer1.lineCap = kCALineCapRound;
    
    _waveLayer2 = [CAShapeLayer layer];
    _waveLayer2.fillColor = [UIColor clearColor].CGColor;
    _waveLayer2.strokeColor = ColorHexWithAlpha(0x9e9e9e, 0.5).CGColor;
    _waveLayer2.lineCap = kCALineCapRound;
    
    _waveLayer3 = [CAShapeLayer layer];
    _waveLayer3.fillColor = [UIColor clearColor].CGColor;
    _waveLayer3.strokeColor = ColorHexWithAlpha(0x9e9e9e, 1).CGColor;
    _waveLayer3.lineCap = kCALineCapRound;
    
    CGFloat SCREEN_W1 = 30;
    CGFloat SCREEN_W2 = 60;
    CGFloat centerY = SCREEN_H/2+50;
    
    UIBezierPath *shapePath = [[UIBezierPath alloc] init];
    [shapePath moveToPoint:CGPointMake(-SCREEN_W, centerY)];
    
    UIBezierPath *shapePath1 = [[UIBezierPath alloc] init];
    [shapePath1 moveToPoint:CGPointMake(-SCREEN_W - SCREEN_W1, centerY)];
    
    UIBezierPath *shapePath2 = [[UIBezierPath alloc] init];
    [shapePath2 moveToPoint:CGPointMake(-SCREEN_W - SCREEN_W2, centerY)];
    
    
    CGFloat  x = 0;
    for (int i =0 ; i < 6; i++) {
        [shapePath addQuadCurveToPoint:CGPointMake(x - SCREEN_W / 2.0, centerY) controlPoint:CGPointMake(x - SCREEN_W + SCREEN_W/4.0, centerY - 40)];
        [shapePath addQuadCurveToPoint:CGPointMake(x, centerY) controlPoint:CGPointMake(x - SCREEN_W/4.0, centerY + 40)];
        
        [shapePath1 addQuadCurveToPoint:CGPointMake(x - SCREEN_W1 - SCREEN_W / 2.0, centerY) controlPoint:CGPointMake(x - SCREEN_W1 - SCREEN_W + SCREEN_W/4.0, centerY - 35)];
        [shapePath1 addQuadCurveToPoint:CGPointMake(x - SCREEN_W1, centerY) controlPoint:CGPointMake(x - SCREEN_W1 - SCREEN_W/4.0, centerY + 35)];
        
        [shapePath2 addQuadCurveToPoint:CGPointMake(x - SCREEN_W2 - SCREEN_W / 2.0, centerY) controlPoint:CGPointMake(x - SCREEN_W2 - SCREEN_W + SCREEN_W/4.0, centerY - 45)];
        [shapePath2 addQuadCurveToPoint:CGPointMake(x - SCREEN_W2, centerY) controlPoint:CGPointMake(x - SCREEN_W2 - SCREEN_W/4.0, centerY + 45)];
        
        x += SCREEN_W;
    }
    
    _waveLayer1.path = shapePath.CGPath;
    _waveLayer2.path = shapePath1.CGPath;
    _waveLayer3.path = shapePath2.CGPath;
    
    [self.view.layer addSublayer:_waveLayer1];
    [self.view.layer addSublayer:_waveLayer2];
    [self.view.layer addSublayer:_waveLayer3];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开始波动
    [self startWaveAnimation];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
