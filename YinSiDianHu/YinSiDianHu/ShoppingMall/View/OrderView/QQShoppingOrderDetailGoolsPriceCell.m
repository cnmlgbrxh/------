//
//  QQShoppingOrderDetailGoolsPriceCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingOrderDetailGoolsPriceCell.h"
@interface  QQShoppingOrderDetailGoolsPriceCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendGoolsTimeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendGoolsTimeBGViewHeight;
@end

@implementation QQShoppingOrderDetailGoolsPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(QQShoppingOrderDetailModel *)model {
    _model = model;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    self.freightLabel.text = [NSString stringWithFormat:@"￥%@",model.freight];
    self.allPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.num integerValue]*[model.price floatValue]+[model.freight integerValue]];
    self.sendTypeLabel.text = [NSString stringWithFormat:@"配送快递：%@",model.distribution];
    self.payLabel.text = [NSString stringWithFormat:@"支付方式：%@",model.payment];
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.ordno];
    if ([model.status isEqualToString:@"待付款"] || [model.status isEqualToString:@"已取消"]) {
        self.sendGoolsTimeBGViewHeight.constant = 52;
        self.payTimeLabel.hidden = YES;
        self.sendGoolsTimeLabel.hidden = YES;
    }else if ([model.status isEqualToString:@"待发货"]) {
        self.sendGoolsTimeLabel.hidden = YES;
        self.sendGoolsTimeBGViewHeight.constant = 72;
    }else{
        self.sendGoolsTimeBGViewHeight.constant = 95;
    }
    self.createTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.time];
    self.payTimeLabel.text = [NSString stringWithFormat:@"付款时间：%@",model.time];
    self.sendGoolsTimeLabel.text = [NSString stringWithFormat:@"发货时间：%@",model.time];
}

@end




@interface QQShoppingOrderDetailFirstCell()
@property(nonatomic,strong)UIImageView *leftIamgeView;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@end
@implementation QQShoppingOrderDetailFirstCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (UIImageView *)leftIamgeView {
    if (!_leftIamgeView) {
        _leftIamgeView = [[UIImageView alloc]initWithImage:QQIMAGE(@"shopping_Open3Dbox")];
    }
    return _leftIamgeView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.textColor = [Tools getUIColorFromString:@"ffffff"];
        _statusLabel.font = [UIFont systemFontOfSize:14];
    }
    return _statusLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = [Tools getUIColorFromString:@"bababa"];
    }
    return _timeLabel;
}

- (void)createUI {
    [self addSubview:self.leftIamgeView];
    [self addSubview:self.statusLabel];
    [self addSubview:self.timeLabel];
    [self  setAutoLayout];
}

- (void)setAutoLayout {
    WS(wSelf);
    [self.leftIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_equalTo(15);
        make.centerY.mas_equalTo(wSelf);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.leftIamgeView.mas_right).mas_offset(17);
        make.bottom.mas_equalTo(wSelf).mas_offset(-5);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.leftIamgeView.mas_right).mas_offset(10);
        make.height.mas_equalTo(14);
        make.centerY.mas_equalTo(wSelf);
    }];
}

- (void)setStatesStr:(NSString *)statesStr {
    _statesStr = statesStr;
    self.statusLabel.text = [NSString stringWithFormat:@"【%@】",statesStr];
}

@end




