//
//  QQShoppingProducDetailHeadView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/8.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingProducDetailHeadView.h"
#import "SDCycleScrollView.h"

@interface QQShoppingProducDetailHeadView()
@property (weak, nonatomic) IBOutlet UIView *scrollBgview;
@property (nonatomic,strong) SDCycleScrollView   *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollBackViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollBgViewHeight;//大view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@end

@implementation QQShoppingProducDetailHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollBackViewHeight.constant = SCREEN_W*0.9;
//    self.scrollBgViewHeight.constant = SCREEN_W*0.56+120;
    self.bgViewHeight.constant = SCREEN_W*0.9+120;
    [self.scrollBgview addSubview:self.cycleScrollView];
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView){
        _cycleScrollView = [ SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W*0.9) imageURLStringsGroup:nil];
        _cycleScrollView.placeholderImage = QQIMAGE(@"shopping_placeHolderImage");
        _cycleScrollView.currentPageDotColor =[Tools getUIColorFromString:@"0xd22120"];
        _cycleScrollView.pageDotColor = WHITECOLOR;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _cycleScrollView;
}

- (void)popAnimationWithView:(UIView*)view{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[ @0.8, @1.1, @1, @1.1, @1 ];
    animation.keyTimes = @[ @0, @(1 / 4.0), @(2 / 4.0), @(3 / 4.0), @1 ];
    animation.duration = 1.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [view.layer addAnimation:animation forKey:nil];
}

- (void)setModel:(QQShoppingProductDetailModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"市场价：￥%@",model.market];
    self.cycleScrollView.imageURLStringsGroup = @[model.img.length>0?model.img:model.pic];
    [self popAnimationWithView:self.cycleScrollView];
}
@end



@interface QQShoppingProducDetailCell()
@end
@implementation QQShoppingProducDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.detailImageView = [[UIImageView alloc]init];
    self.detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.detailImageView];
    [self.detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
}

@end


@interface QQShoppingDetailDescribeCell()

@end
@implementation QQShoppingDetailDescribeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.describeLabel = [[UILabel alloc]init];
    self.describeLabel.font = [UIFont systemFontOfSize:13];
    self.describeLabel.textColor = [Tools getUIColorFromString:@"686868"];
    self.describeLabel.numberOfLines = 0;
    [self addSubview:self.describeLabel];
    
    WS(wSelf);
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.right.mas_equalTo(wSelf).mas_offset(-10);
        make.top.bottom.mas_equalTo(wSelf);
    }];
}

- (void)setModel:(QQShoppingProductDetailModel *)model {
    _model = model;
    self.describeLabel.text = model.describe;
}

@end
