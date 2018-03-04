//
//  QQShoppingChangeGoolsVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingChangeGoolsVC.h"
#import "QQConfirmOrderHeadView.h"
#import "QQShoppingPlaceManagerVC.h"
#import "QQShoppingPostAndPayView.h"
#import "QQChangeRecordVC.h"
#import "QQShoppingSendStyleModel.h"

@interface QQShoppingChangeGoolsVC ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *sendStyleLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jfenLabel;
@property (nonatomic,strong) NSMutableArray *sendStyleArr;
@property (nonatomic,strong) NSString *aid;

@end

@implementation QQShoppingChangeGoolsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.model.productPic ]placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
    self.nameLabel.text = self.model.productName;
    self.jifenLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%@ 积分",self.model.producting] changeStr:self.model.producting color:[Tools getUIColorFromString:@"b63030"] font:[UIFont systemFontOfSize:16]];
    [self getStyleRequest];
}

- (void)changeRequest {
    WS(wSelf);
    NSString *urlStr = [NSString stringWithFormat:@"%@username=%@&aid=%@&pid=%@&gdistribution=%@",integ_changeGoolsURL,[UserManager shareManager].userName,self.aid,self.model.productId,self.sendStyleLabel.text];
    NSString *utf8 = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",Integ_API_CON(utf8));
    [HYBNetworking getWithUrl:Integ_API_CON(utf8) refreshCache:YES success:^(id response) {
        NSLog(@"%@",response);
        if (response) {
            if ([response[@"stats"]isEqualToString:@"ok"]) {
                [QQShoppingTools showAlertControllerWithTitle:@"兑换成功，请注意物流信息" message:@"" confirmTitle:nil cancleTitle:@"好" vc:self confirmBlock:^{
                } cancleBlock:^{
                    NSArray *vcArr = self.navigationController.viewControllers;
                    NSMutableArray *muArr = [[NSMutableArray alloc]initWithArray:vcArr];
                    [muArr removeLastObject];
                    [muArr removeLastObject];
                    QQChangeRecordVC *vc = [[QQChangeRecordVC alloc]init];
                    [muArr addObject:vc];
                    //                    vc.toRootVC = YES;
                    [wSelf.navigationController pushViewController:vc animated:YES];
                }];
            }else{
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
            }
        }
        
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
    
}

//获取快递方式
- (void)getStyleRequest {
    NSString *str = [NSString stringWithFormat:@"%@username=%@",shopping_deliveryURL,[UserManager shareManager].userName];
    [HYBNetworking getWithUrl:QQ_API_CON(str) refreshCache:YES success:^(id response) {
        //NSLog(@"配送方式 ----------%@",response);
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[QQShoppingSendStyleModel class] json:response];
        [self.sendStyleArr addObjectsFromArray:tempArr];
    } fail:^(NSError *error) {
        NSLog(@"配送方式 ----------%@",error);
    }];
}


- (void)createUI {
    self.title = @"积分商城";
    QQConfirmOrderHeadView *view = [[NSBundle mainBundle]loadNibNamed:@"QQConfirmOrderHeadView" owner:self options:nil][0];
    view.frame = CGRectMake(0, 0, SCREEN_W, 110);
    view.hiddenTapLabel = NO;
    view.orderNumView.hidden = YES;
    view.orderNumViewHeight.constant = 0;
    WS(wSelf);
    __weak __typeof(&*view)wView = view;
    view.shopping_addPlaceBlock = ^{
        QQShoppingPlaceManagerVC *vc = [[QQShoppingPlaceManagerVC alloc]init];
        vc.shopping_goolsPlaceBlock = ^(QQShoppingAddressListModel *model) {
            wView.hiddenTapLabel = YES;
            wView.model = model;
            wSelf.aid = model.aid;
        };
        [wSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.bgView addSubview:view];
    
    self.nextBtn.layer.cornerRadius = 3;
    self.nextBtn.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)chooseSendStyeBtnClick:(id)sender {
    //    WS(wSelf);
    //    QQShoppingPostAndPayView *view = [[QQShoppingPostAndPayView alloc]init];
    //    view.shopping_postAndPayBlock = ^(NSString *stye, NSString *imageName) {
    //        wSelf.sendStyleLabel.text = stye;
    //    };
    //    view.isPost = YES;
    //    [view show];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (QQShoppingSendStyleModel *model in self.sendStyleArr) {
        [arr addObject:model.dname];
    }
    if (arr.count == 0) {
        [arr addObject:@"圆通"];
        [arr addObject:@"申通"];
        [arr addObject:@"韵达"];
    }
    WS(wSelf);
    [QQShoppingTools showSheetControllerWithTitiles:arr vc:self confirmBlock:^(NSInteger index) {
        wSelf.sendStyleLabel.text = arr[index];
    }];
}

- (IBAction)nextBtnClick:(id)sender {
    
    if (self.aid == nil) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请选择收货地址"];
        return;
    }
    if ([self.sendStyleLabel.text isEqualToString:@"请选择"]) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请选择快递方式"];
        return;
    }
    
    [self changeRequest];
}

- (NSMutableArray *)sendStyleArr {
    if (!_sendStyleArr) {
        _sendStyleArr = [[NSMutableArray alloc]init];
    }
    return _sendStyleArr;
}

@end
