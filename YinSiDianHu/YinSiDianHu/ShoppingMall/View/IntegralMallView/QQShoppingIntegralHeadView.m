//
//  QQShoppingIntegralHeadView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingIntegralHeadView.h"
#import "SDCycleScrollView.h"
#import "QQShoppingBannerModel.h"

@interface QQShoppingIntegralHeadView()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) SDCycleScrollView   *cycleScrollView;

@end
@implementation QQShoppingIntegralHeadView

- (void)awakeFromNib {
    [super awakeFromNib];    
    [self.bgView addSubview:self.cycleScrollView];

}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView){
        _cycleScrollView = [ SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W*0.376) imageURLStringsGroup:nil];
        //        _cycleScrollView.placeholderImage = QQIMAGE(@"shopping_placeHolderImage");
        _cycleScrollView.currentPageDotColor =[Tools getUIColorFromString:@"0xd22120"];
        _cycleScrollView.pageDotColor = WHITECOLOR;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        WS(wSelf);
        _cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
            if (wSelf.integ_BannerTapkBlock) {
                NSLog(@"-----%lu",(unsigned long)wSelf.bannerArray.count);
                QQShoppingBannerModel *model = wSelf.bannerArray[currentIndex];
                NSLog(@"-----%lu",(unsigned long)model.p_id);
                wSelf.integ_BannerTapkBlock (currentIndex,model.p_id);
            }
        };
    }
    return _cycleScrollView;
}

- (void)setBannerArray:(NSArray *)bannerArray {
    _bannerArray = bannerArray;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<bannerArray.count; i++) {
        QQShoppingBannerModel *model = bannerArray[i];
        [arr addObject:model.p_url];
    }
    _cycleScrollView.imageURLStringsGroup = arr;
    NSLog(@"-----%lu",(unsigned long)bannerArray.count);
}

- (IBAction)changeRecodBtnClick:(id)sender {
    if (self.shopping_changeRecordBlock) {
        self.shopping_changeRecordBlock();
    }
}

//点击可用积分
- (IBAction)leftBtnClick:(id)sender {
    if (self.shopping_canUseBlock) {
        self.shopping_canUseBlock();
    }
}
@end
