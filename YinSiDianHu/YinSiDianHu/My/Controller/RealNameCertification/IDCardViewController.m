//
//  IDCardViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "IDCardViewController.h"
#import "UploadPhoto.h"
#import "IDCardPersonViewController.h"
#import "ProgressView.h"
@interface IDCardViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop6;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop7;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft0;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layRight0;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;


@end

@implementation IDCardViewController{
    NSTimer *_timer;
    ProgressView *progressView;
    NSMutableDictionary *dicmValue;
    UIView *viewBackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layout];
    
    dicmValue = [NSMutableDictionary dictionary];
}
-(void)layout{
    _layTop.constant = Sc(38);
    _layTop1.constant = Sc(48);
    _layTop2.constant = Sc(36);
    _layTop3.constant = Sc(46);
    _layTop4.constant = Sc(34);
    _layTop5.constant = Sc(46);
    _layTop6.constant = Sc(14);
    if (ISIPHONE_6) {
        _layLeft0.constant = (SCREEN_W-168*2)/3;
        _layRight0.constant = (SCREEN_W-168*2)/3;
    }else{
        _layLeft0.constant = (SCREEN_W-190.67*2)/3;
        _layRight0.constant = (SCREEN_W-190.67*2)/3;
    }
    
    _layLeft.constant = Sc(50);
    _layWidth.constant = Sc(26);
}

- (IBAction)uploadPositiveID:(UIButton *)sender {
    [[UploadPhoto sharedClient] choosePhotoForViewController:self getPhoto:^(UIImage *selectImage, NSDictionary *responseObject) {
        [sender setTitle:nil forState:UIControlStateNormal];
        [sender setImage:nil forState:UIControlStateNormal];
        [sender setBackgroundImage:selectImage forState:UIControlStateNormal];
        [dicmValue setObject:selectImage forKey:@"正面"];
    }];
}
- (IBAction)uploadBackID:(UIButton *)sender {
    
    [[UploadPhoto sharedClient] choosePhotoForViewController:self getPhoto:^(UIImage *selectImage, NSDictionary *responseObject) {
        [sender setTitle:nil forState:UIControlStateNormal];
        [sender setImage:nil forState:UIControlStateNormal];
        [sender setBackgroundImage:selectImage forState:UIControlStateNormal];
        [dicmValue setObject:selectImage forKey:@"反面"];
    }];
    
}

- (IBAction)next:(UIButton *)sender {
    //[self progress];
    //第一张
    [self progress];
    [DataRequest uploadImageParameters:@{@"action":@"testup",@"image":[Tools base64FromImage:[dicmValue objectForKey:@"正面"]]} progress:^(NSProgress *progress) {
        
        progressView.progress = (CGFloat)progress.completedUnitCount/(CGFloat)progress.totalUnitCount/2;
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"q:%@",responseObject);
        //第二张
        [DataRequest uploadImageParameters:@{@"action":@"testup",@"image":[Tools base64FromImage:[dicmValue objectForKey:@"反面"]]} progress:^(NSProgress *progress) {
            progressView.progress = 0.5+(CGFloat)progress.completedUnitCount/(CGFloat)progress.totalUnitCount/2;
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"q:%@",responseObject);
            [viewBackView removeFromSuperview];
            IDCardPersonViewController *iDCardPersonVC = [[IDCardPersonViewController alloc] init];
            iDCardPersonVC.navTitle = @"实名认证";
            [self.navigationController pushViewController:iDCardPersonVC animated:YES];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}
-(void)progress{
    //黑色背景
    if (!viewBackView) {
        viewBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    }
    viewBackView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.5];
    [self.navigationController.view addSubview:viewBackView];
    
    //进度条
    if (!progressView) {
        progressView = [[ProgressView alloc] init];
    }
    progressView.layer.cornerRadius = Sc(30);
    progressView.layer.masksToBounds = YES;
    [viewBackView addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Sc(50));
        make.right.mas_equalTo(-Sc(50));
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(Sc(300));
    }];
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
