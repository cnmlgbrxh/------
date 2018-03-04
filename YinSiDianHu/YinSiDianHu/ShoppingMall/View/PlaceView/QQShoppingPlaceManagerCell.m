//
//  QQShoppingPlaceManagerCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingPlaceManagerCell.h"
@interface QQShoppingPlaceManagerCell()
@property (weak, nonatomic) IBOutlet UILabel *defLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIButton *curentPlaceBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeLeading;
@end
@implementation QQShoppingPlaceManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editBtnClik:(id)sender {
    if (self.shopping_editPlaceBlock) {
        self.shopping_editPlaceBlock();
    }
}

- (IBAction)curentBtnClick:(id)sender {
    if (self.shopping_defultPlaceBlock) {
        self.shopping_defultPlaceBlock();
    }
}

- (IBAction)delBtnClick:(id)sender {
    if (self.shopping_delPlaceBlock) {
        self.shopping_delPlaceBlock();
    }
}

- (void)setModel:(QQShoppingAddressListModel *)model {
    _model = model;
    self.nameLabel.text = model.cname;
    self.phoneNumLabel.text = model.cphone;
    self.placeLabel.text = [NSString stringWithFormat:@"收货地址：%@%@",model.czone,model.caddr];
    if ([model.is_common isEqualToString:@"1"]) {
        [self.curentPlaceBtn setImage:QQIMAGE(@"shopping_Checked") forState:UIControlStateNormal];
        [self.curentPlaceBtn setTitle:@"默认地址" forState:UIControlStateNormal];
    }else{
        [self.curentPlaceBtn setImage:QQIMAGE(@"shopping_Unchecked") forState:UIControlStateNormal];
        [self.curentPlaceBtn setTitle:@"设为默认" forState:UIControlStateNormal];
    }
}
@end
