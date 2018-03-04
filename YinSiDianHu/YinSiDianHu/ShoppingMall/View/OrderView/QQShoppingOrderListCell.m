//
//  QQShoppingOrderListCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingOrderListCell.h"

@interface QQShoppingOrderListCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNum;//订单标号
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;//订单状态：待付款
@property (weak, nonatomic) IBOutlet UIImageView *goolsImage;//商品图片
@property (weak, nonatomic) IBOutlet UILabel *titleName;//商品名称
@property (weak, nonatomic) IBOutlet UILabel *goolsDetail;//商品参数
@property (weak, nonatomic) IBOutlet UILabel *priceLabl;//商品单价
@property (weak, nonatomic) IBOutlet UILabel *goolsNum;//商品件数      X1  X2
@property (weak, nonatomic) IBOutlet UILabel *allNumLabel;//共1件商品
@property (weak, nonatomic) IBOutlet UILabel *allCountMoney;//合计多少钱;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
@property (weak, nonatomic) IBOutlet UILabel *explineLabel;//已付款、等待卖家发货




@end
@implementation QQShoppingOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBorder:self.cancleBtn BorderColor:@"aeaeae"];
    [self setBorder:self.yesBtn BorderColor:@"ed4044"];
}

- (void)setBorder:(UIButton *)btn BorderColor:(NSString *)colorStr {
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [Tools getUIColorFromString:colorStr].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.masksToBounds = YES;
}

- (void)setModel:(QQShoppingOrderListModel *)model {
    _model = model;
    self.orderNum.text = model.gno;
    self.orderStatus.text = [model.gstats isEqualToString:@"0"]?@"待付款":@"";
    if ([model.gstats isEqualToString:@"0"] && ![model.is_abolish isEqualToString:@"1"]) {
        self.explineLabel.hidden = YES;
        self.cancleBtn.hidden = NO;
        self.yesBtn.hidden = NO;
        self.cancleBtn.userInteractionEnabled = YES;
        self.yesBtn.userInteractionEnabled = YES;
        [self.cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.yesBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        self.orderStatus.text = @"待付款";
    }else {
        if ([model.is_delivery isEqualToString:@"0"]) {
            self.cancleBtn.hidden = YES;
            self.yesBtn.hidden = YES;
            self.cancleBtn.userInteractionEnabled = NO;
            self.yesBtn.userInteractionEnabled = NO;
            self.explineLabel.hidden = NO;
            self.explineLabel.text = @"已付款 等待发货";
            self.orderStatus.text = @"待发货";
        }else{
            if ([model.take_delivery isEqualToString:@"0"]) {
                self.cancleBtn.hidden = YES;
                self.cancleBtn.userInteractionEnabled = NO;
                self.yesBtn.hidden = NO;
                self.yesBtn.userInteractionEnabled = YES;
                [self.yesBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                self.explineLabel.hidden = YES;
                self.orderStatus.text = @"待收货";
            }else{
                self.cancleBtn.hidden = YES;
                self.cancleBtn.userInteractionEnabled = NO;
                self.yesBtn.hidden = NO;
                self.yesBtn.userInteractionEnabled = YES;
                [self.yesBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                self.explineLabel.hidden = YES;
                self.orderStatus.text = @"交易成功";
            }
        }
        
        if ([model.is_abolish isEqualToString:@"1"]) {
            self.cancleBtn.hidden = YES;
            self.yesBtn.hidden = YES;
            self.cancleBtn.userInteractionEnabled = NO;
            self.yesBtn.userInteractionEnabled = NO;
            self.explineLabel.hidden = NO;
            self.explineLabel.text = @"订单已取消";
            self.orderStatus.text = @"已取消";
        }
    }
    
    
    [self.goolsImage sd_setImageWithURL:[NSURL URLWithString:model.productPic] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
    self.titleName.text = model.productName;
    if ([model.product_dp containsString:@"?"]) {
        NSArray *arr = [model.product_dp componentsSeparatedByString:@"?"];
        self.goolsDetail.text = arr[1];
    }else{
        if ([model.product_dp isEqualToString:@"null"] || model.product_dp == nil || model.product_dp == NULL || [model.product_dp isKindOfClass:[NSNull class]]) {
            self.goolsDetail.text = @"";
        }else{
            self.goolsDetail.text = model.product_dp;
        }
    }
    self.priceLabl.text = [NSString stringWithFormat:@"￥%@",model.gprice];
    self.goolsNum.text = [NSString stringWithFormat:@"x %@",model.gnum];
    self.allNumLabel.text = [NSString stringWithFormat:@"共%@件商品",model.gnum];
    self.allCountMoney.text = [NSString stringWithFormat:@"合计：￥%.2f (含运费￥%@)",[model.gnum integerValue] * [model.gprice floatValue],model.freight];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)cancleBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.shopping_orderListCancleBlock) {
        self.shopping_orderListCancleBlock(btn.titleLabel.text);
    }
}
- (IBAction)yesBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.shopping_orderListYesBlock) {
        self.shopping_orderListYesBlock(btn.titleLabel.text);
    }
}

@end
