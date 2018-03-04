//
//  QQShoppingCarCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/11.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingCarCell.h"
@interface QQShoppingCarCell()
@property (weak, nonatomic) IBOutlet UIView *countBGView;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@end
@implementation QQShoppingCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.countBGView.layer.borderColor = [Tools getUIColorFromString:@"b9b9b9"].CGColor;
    self.bgViewWidth.constant = 83*SCREEN_W/375;
    self.bgViewHeight.constant = 22*SCREEN_W/375;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)addBtnClick:(id)sender {
    NSInteger num = [self.numBtn.titleLabel.text integerValue];
    [self.numBtn setTitle:[NSString stringWithFormat:@"%ld",num+1] forState:UIControlStateNormal];
    if ([self.numBtn.titleLabel.text integerValue] > 1) {
        [self.reduceBtn setImage:QQIMAGE(@"shopping_reduce") forState:UIControlStateNormal];
    }
    if (self.shopping_carNumChangeBlock) {
        self.shopping_carNumChangeBlock(YES);
    }
}

- (IBAction)reduceBtnClick:(id)sender {
    NSInteger num = [self.numBtn.titleLabel.text integerValue];
    if (num > 1) {
        [self.numBtn setTitle:[NSString stringWithFormat:@"%ld",num-1] forState:UIControlStateNormal];
        if ([self.numBtn.titleLabel.text integerValue] == 1) {
            [self.reduceBtn setImage:QQIMAGE(@"shopping_reduce_nomal") forState:UIControlStateNormal];
        }
        if (self.shopping_carNumChangeBlock) {
            self.shopping_carNumChangeBlock(NO);
        }
    }
}

- (void)setModel:(QQShoppingCarModel *)model {
    _model = model;
    [self.numBtn setTitle:model.carNum forState:UIControlStateNormal];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.productPrice floatValue]];
    if ([model.carNum isEqualToString:@"1"]) {
        [self.reduceBtn setImage:QQIMAGE(@"shopping_reduce_nomal") forState:UIControlStateNormal];
    }else{
        [self.reduceBtn setImage:QQIMAGE(@"shopping_reduce") forState:UIControlStateNormal];
    }
    [self.selectedBtn setImage:model.isPayment?QQIMAGE(@"shopping_Checked"):QQIMAGE(@"shopping_Unchecked") forState:UIControlStateNormal];
    self.nameLabel.text = model.productName;
    if (model.product_dp.length>0 && [model.product_dp containsString:@"?"]) {
        self.productLabel.text = [model.product_dp componentsSeparatedByString:@"?"][1];
    }else{
        self.productLabel.text = model.product_dp;
    }
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.productPic] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
}

- (IBAction)selectedBtnClick:(id)sender {
    if (self.shopping_carLeftSectedBlock) {
        self.shopping_carLeftSectedBlock();
    }
}

@end



@interface QQShoppingCarFootView()

@end
@implementation QQShoppingCarFootView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.layer.borderColor = [Tools getUIColorFromString:@"e2e3e3"].CGColor;
    self.layer.borderWidth = 0.5;
    [self addSubview:self.btn];
    [self addSubview:self.countLabel];
    [self addSubview:self.nextBtn];
    [self addSubview:self.chargesLabel];
    [self addSubview:self.deleteBtn];
    [self setAutoLayout];
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:QQIMAGE(@"shopping_Checked") forState:UIControlStateNormal];
        [_btn setTitle:@"全选" forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn setTitleColor:[Tools getUIColorFromString:@"4d4d4d"] forState:UIControlStateNormal];
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_btn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.text = @"合计:￥5000.00";
    }
    return _countLabel;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"去结算" forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 5;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.backgroundColor = [Tools getUIColorFromString:@"ed4044"];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除选中" forState:UIControlStateNormal];
        _deleteBtn.layer.cornerRadius = 5;
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.backgroundColor = [UIColor blackColor];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.hidden = YES;
        _deleteBtn.userInteractionEnabled = NO;
    }
    return _deleteBtn;
}

- (UILabel *)chargesLabel {
    if (!_chargesLabel) {
        _chargesLabel = [[UILabel alloc]init];
        _chargesLabel.textColor = [Tools getUIColorFromString:@"a3a3a3"];
        _chargesLabel.font = [UIFont systemFontOfSize:10];
        _chargesLabel.text = @"不含运费";
    }
    return _chargesLabel;
}
- (void)setAutoLayout {
    WS(wSelf);
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(7);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
        make.centerY.mas_equalTo(wSelf);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf).mas_offset(-7);
        make.centerY.mas_equalTo(wSelf);
        make.height.mas_equalTo(43);
        make.width.mas_equalTo(105);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf).mas_offset(-7);
        make.centerY.mas_equalTo(wSelf);
        make.height.mas_equalTo(43);
        make.width.mas_equalTo(105);
    }];
    
    [self.chargesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(wSelf);
        make.right.mas_equalTo(wSelf.nextBtn.mas_left).mas_offset(-9);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.chargesLabel.mas_left).mas_offset(-8);
        make.centerY.mas_equalTo(wSelf);
    }];
}

- (void)setNumCount:(NSInteger)numCount {
    _numCount = numCount;
    [self.nextBtn setTitle:[NSString stringWithFormat:@"去结算(%ld)",numCount] forState:UIControlStateNormal];
}

- (void)setPriceCount:(CGFloat)priceCount {
    _priceCount = priceCount;
    self.countLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"合计：￥%.2f",priceCount] changeStr:[NSString stringWithFormat:@"￥%.2f",priceCount] color:[Tools getUIColorFromString:@"ed4044"] font:[UIFont systemFontOfSize:14]];
}

- (void)allBtnClick {
    if (self.shopping_allSelectedBlock) {
        self.shopping_allSelectedBlock();
    }
}

- (void)nextBtnClick {
    if (self.shopping_nextBtnBlock) {
        self.shopping_nextBtnBlock();
    }
}

- (void)deleteBtnClick {
    if (self.shopping_deleteBtnBlock) {
        self.shopping_deleteBtnBlock();
    }
}
@end




