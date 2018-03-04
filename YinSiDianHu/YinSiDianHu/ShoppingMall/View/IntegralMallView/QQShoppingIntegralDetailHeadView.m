//
//  QQShoppingIntegralDetailHeadView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingIntegralDetailHeadView.h"
#import "SDCycleScrollView.h"

@interface QQShoppingIntegralDetailHeadView()
@property (weak, nonatomic) IBOutlet UIView *scrollBgView;
@property (nonatomic,strong) SDCycleScrollView   *cycleScrollView;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;
@property (weak, nonatomic) IBOutlet UILabel *numCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBGHeight;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation QQShoppingIntegralDetailHeadView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollViewBGHeight.constant = SCREEN_W*0.56;
    [self.scrollBgView addSubview:self.cycleScrollView];
    self.jifenLabel.attributedText = [Tools LabelStr:@"900积分" changeStr:@"900" color:[Tools getUIColorFromString:@"f70d00"] font:[UIFont systemFontOfSize:20]];
    self.numCountLabel.attributedText = [Tools LabelStr:@"最后8件" changeStr:@"8" color:[Tools getUIColorFromString:@"f70d00"] font:nil];
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView){
        _cycleScrollView = [ SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W*0.56) imageURLStringsGroup:nil];
        _cycleScrollView.placeholderImage = QQIMAGE(@"");
        _cycleScrollView.currentPageDotColor =[Tools getUIColorFromString:@"0xd22120"];
        _cycleScrollView.pageDotColor = WHITECOLOR;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.placeholderImage = QQIMAGE(@"shopping_placeHolderImage");
    }
    return _cycleScrollView;
}

- (void)setModel:(QQIntegListModel *)model {
    _model = model;
    self.nameLabel.text = model.productName;
    self.jifenLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%@ 积分",model.producting] changeStr:model.producting color:[Tools getUIColorFromString:@"f70d00"] font:[UIFont systemFontOfSize:20]];
    self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.productMarket];
    NSString *str = [NSString stringWithFormat:@"最后 %@ 件",model.productAmount];
    self.numCountLabel.attributedText = [Tools LabelStr:str changeStr:model.productAmount color:[Tools getUIColorFromString:@"b63030"] font:nil];
}

- (void)setDetailModel:(QQShoppingProductDetailModel *)detailModel {
    _detailModel = detailModel;
    NSString *img= detailModel.img;
    _cycleScrollView.imageURLStringsGroup = @[img?img:detailModel.pic];
    if (!self.model) {
        self.nameLabel.text = detailModel.name;
        self.jifenLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%@ 积分",detailModel.producting] changeStr:detailModel.producting color:[Tools getUIColorFromString:@"f70d00"] font:[UIFont systemFontOfSize:20]];
        self.marketPriceLabel.text = [NSString stringWithFormat:@"￥%@",detailModel.market];
        NSString *str = [NSString stringWithFormat:@"最后 %@ 件",detailModel.amount];
        self.numCountLabel.attributedText = [Tools LabelStr:str changeStr:detailModel.amount color:[Tools getUIColorFromString:@"b63030"] font:nil];
    }
}

@end


@implementation QQShoppingIntegraDetailTitleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textColor = [Tools getUIColorFromString:@"686868"];
    self.nameLabel.numberOfLines = 0;
    [self addSubview:self.nameLabel];
    WS(wSelf);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.right.mas_equalTo(wSelf).mas_offset(-10);
        make.top.mas_equalTo(wSelf).mas_equalTo(0);
    }];
}
@end
