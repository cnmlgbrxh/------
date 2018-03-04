//
//  QQShoppingSearchResultHeadView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/8.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingSearchResultHeadView.h"
@interface QQShoppingSearchResultHeadView()
@property (weak, nonatomic) IBOutlet UIButton *salesBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIButton *productBtn;//新品
@property (strong,nonatomic)NSString *salesBtnStatus;//销量状态
@property (strong,nonatomic)NSString *priceBtnStatus;//价格状态
@end
@implementation QQShoppingSearchResultHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setColorWithButten:self.synthesizeBtn];
    [self setColorWithButten:self.salesBtn];
    [self setColorWithButten:self.priceBtn];
    [self setColorWithButten:self.productBtn];
    self.salesBtnStatus = @"0";
    self.priceBtnStatus = @"0";
}

- (void)setColorWithButten:(UIButton *)btn {
    [btn setTitleColor:[Tools getUIColorFromString:@"676767"] forState:UIControlStateNormal];
    [btn setTitleColor:[Tools getUIColorFromString:@"fc4d00"] forState:UIControlStateSelected];
}

- (IBAction)synthesizeBtnClick:(id)sender {
    self.synthesizeBtn.selected = YES;
    self.salesBtn.selected = NO;
    self.priceBtn.selected = NO;
    self.productBtn.selected = NO;
    [self setPriceBtn];
    [self setSalesBtn];
    if (self.shopping_synthesizeBtnClickBlock) {
        self.shopping_synthesizeBtnClickBlock();
    }
}

- (IBAction)salesBtnClick:(id)sender {
    //salesBtn  0:平  1:从高到低  2:从低到高
    self.synthesizeBtn.selected = NO;
    self.salesBtn.selected = YES;
    self.priceBtn.selected = NO;
    self.productBtn.selected = NO;
    [self setPriceBtn];
    if ([self.salesBtnStatus isEqualToString:@"0"] || [self.salesBtnStatus isEqualToString:@"2"]) {
        self.salesBtnStatus = @"1";
        [self.salesBtn setImage:QQIMAGE(@"shopping_price-up") forState:UIControlStateNormal];
    }else{
        self.salesBtnStatus = @"2";
        [self.salesBtn setImage:QQIMAGE(@"shopping_price-down") forState:UIControlStateNormal];
    }
    if (self.shopping_salesBtnClickBlock) {
        self.shopping_salesBtnClickBlock([self.salesBtnStatus isEqualToString:@"1"]?NO:YES);
    }
}

- (IBAction)priceBtnClick:(id)sender {
    //priceBtn  0:平  1:从低到高  2:从高到低
    self.synthesizeBtn.selected = NO;
    self.salesBtn.selected = NO;
    self.priceBtn.selected = YES;
    self.productBtn.selected = NO;
    [self setSalesBtn];
    if ([self.priceBtnStatus isEqualToString:@"0"] || [self.priceBtnStatus isEqualToString:@"2"]) {
        self.priceBtnStatus = @"1";
        [self.priceBtn setImage:QQIMAGE(@"shopping_price-down") forState:UIControlStateNormal];
    }else{
        self.priceBtnStatus = @"2";
        [self.priceBtn setImage:QQIMAGE(@"shopping_price-up") forState:UIControlStateNormal];
    }
    if (self.shopping_priceBtnClickBlock) {
        self.shopping_priceBtnClickBlock([self.priceBtnStatus isEqualToString:@"1"]?YES:NO);
    }
}

- (IBAction)productBtnClick:(id)sender {
    self.synthesizeBtn.selected = NO;
    self.salesBtn.selected = NO;
    self.priceBtn.selected = NO;
    self.productBtn.selected = YES;
    [self setSalesBtn];
    [self setPriceBtn];
    if (self.shopping_productBtnClickBlock) {
        self.shopping_productBtnClickBlock();
    }
}

- (void)setSalesBtn {
    [self.salesBtn setImage:QQIMAGE(@"shopping_price-ping") forState:UIControlStateNormal];
    self.salesBtnStatus = @"0";
}

- (void)setPriceBtn {
    [self.priceBtn setImage:QQIMAGE(@"shopping_price-ping") forState:UIControlStateNormal];
    self.priceBtnStatus = @"0";
}

@end


