//
//  QQConfirmOrderHeadView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQConfirmOrderHeadView.h"
@interface QQConfirmOrderHeadView()
@property (weak, nonatomic) IBOutlet UILabel *tapLabel;//点击添加收货地址
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabl;
@end
@implementation QQConfirmOrderHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)addPlaceBtnClick:(id)sender {
    if (self.shopping_addPlaceBlock) {
        self.shopping_addPlaceBlock();
    }
}

- (void)setHiddenTapLabel:(BOOL)hiddenTapLabel {
    if (hiddenTapLabel) {
        self.tapLabel.hidden = YES;
        self.nameLabel.hidden = NO;
        self.phoneLabel.hidden = NO;
        self.placeLabl.hidden = NO;
    }else{
        self.tapLabel.hidden = NO;
        self.nameLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
        self.placeLabl.hidden = YES;
    }
}

- (void)setModel:(QQShoppingAddressListModel *)model {
    _model = model;
    if (model.cname.length > 0) {
        self.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",model.cname];
    }
    self.phoneLabel.text = model.cphone;
    self.placeLabl.text = [NSString stringWithFormat:@"收货地址：%@%@",model.czone.length>0?model.czone:@"",model.caddr];
}
@end
