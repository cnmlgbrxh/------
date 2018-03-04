//
//  QQChangeRecordCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQChangeRecordCell.h"

@interface QQChangeRecordCell()

@property (weak, nonatomic) IBOutlet UIButton *getGootsBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *goolsImageView;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;

@end
@implementation QQChangeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.getGootsBtn.layer.cornerRadius = 5;
    self.getGootsBtn.layer.masksToBounds = YES;
    self.getGootsBtn.layer.borderWidth = 1;
    self.getGootsBtn.layer.borderColor = [Tools getUIColorFromString:@"ed4044"].CGColor;
    self.imageViewHeight.constant = QQAdapterSpacingValure(105);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(QQShoppingOrderListModel *)model {
    _model = model;
    self.titleLabel.text = model.productName;
    if ([model.gstats isEqualToString:@"1"] && [model.is_delivery isEqualToString:@"1"] && [model.take_delivery isEqualToString:@"1"]) {
        self.statusLabel.text = @"已收货";
        self.getGootsBtn.hidden = YES;
    }else if ([model.gstats isEqualToString:@"1"] && [model.is_delivery isEqualToString:@"1"]) {
        self.statusLabel.text = @"已发货";
        self.getGootsBtn.hidden = NO;
    }else{
          self.statusLabel.text = @"待发货";
        self.getGootsBtn.hidden = YES;
    }
    [self.goolsImageView sd_setImageWithURL:[NSURL URLWithString:model.productPic] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
    self.orderNumLabel.text = model.gno;
    self.jifenLabel.text= [NSString stringWithFormat:@"消耗积分 : %@",model.gprice];
}

- (void)setHiddenBtn:(BOOL)hiddenBtn {
    self.getGootsBtn.hidden = YES;
}

- (void)setHiddenRightBtn:(BOOL)hiddenRightBtn {
    _hiddenRightBtn = hiddenRightBtn;
    self.rightArrowBtn.hidden = YES;
}

- (IBAction)getGoolsBtnClick:(id)sender {
    if (self.shopping_changeRecordBlock) {
        self.shopping_changeRecordBlock();
    }
}
@end




@interface QQChangeTimeCell()
@property(nonatomic,strong)UILabel *leftLable;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UIView *bgView;

@end
@implementation QQChangeTimeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)setLeftLabelStr:(NSString *)leftLabelStr {
    _leftLabelStr = leftLabelStr;
    _leftLable.text = leftLabelStr;
}

- (void)setRightLabelStr:(NSString *)rightLabelStr {
    _rightLabelStr = rightLabelStr;
    _rightLabel.text = rightLabelStr;
}

- (void)createUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.leftLable];
    [self.bgView addSubview:self.rightLabel];
    [self setAutolaout];
}

- (void)setAutolaout {
    WS(wSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(wSelf);
        make.bottom.mas_equalTo(wSelf).mas_offset(-7);
    }];
    
    [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).offset(10);
        make.centerY.mas_equalTo(wSelf.bgView);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.bgView).mas_offset(-10);
        make.centerY.mas_equalTo(wSelf.bgView);
    }];
}

- (UILabel *)leftLable {
    if (!_leftLable) {
        _leftLable = [[UILabel alloc]init];
        _leftLable.font = [UIFont systemFontOfSize:15];
        _leftLable.textColor = [UIColor lightGrayColor];
        _leftLable.text = @"兑换时间";
    }
    return _leftLable;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont systemFontOfSize:15];
        _rightLabel.text = @"2017-05-18";
    }
    return _rightLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

@end



@interface QQChangeExplianCell()
@property(nonatomic,strong)UIImageView *redImageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UITextView *textView;
@end
@implementation QQChangeExplianCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        [self setAutoLayout];
    }
    return self;
}

- (void)createUI {
    self.redImageView = [[UIImageView alloc]init];
    self.redImageView.image = QQIMAGE(@"shopping_expliicon");
    [self addSubview:self.redImageView];
    self.textView = [[UITextView alloc]init];
    self.textView.font = [UIFont systemFontOfSize:13];
    self.textView.textColor = [Tools getUIColorFromString:@"969696"];
    self.textView.text = @"兑换的商品会发送您指定的物流公司到指定的地址，请注意查收。\n如有疑问请联系客服QQ800123152";
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.userInteractionEnabled = NO;
    [self addSubview:self.textView];
}

- (void)setAutoLayout {
    WS(wSelf);
    [wSelf.redImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.top.mas_equalTo(wSelf).mas_offset(20);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    [wSelf.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(wSelf).mas_offset(10);
        make.left.mas_equalTo(wSelf.redImageView.mas_right).mas_offset(0);
        make.right.mas_equalTo(wSelf).mas_offset(33);
    }];
}
@end



@interface QQChangeRecordHeadView()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *lineImageView;
@end
@implementation QQChangeRecordHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.phoneLabel];
    [self.bgView addSubview:self.placeLabel];
    [self.bgView addSubview:self.lineImageView];
    [self setAutoLayout];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [Tools getUIColorFromString:@"2a2a2a"];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:15];
        _phoneLabel.textColor = [Tools getUIColorFromString:@"2a2a2a"];
    }
    return _phoneLabel;
}

- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]init];
        _placeLabel.font = [UIFont systemFontOfSize:13];
        _placeLabel.textColor = [Tools getUIColorFromString:@"2a2a2a"];
        _placeLabel.numberOfLines = 0;
    }
    return _placeLabel;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc]initWithImage:QQIMAGE(@"shopping_line")];
    }
    return _lineImageView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (void)setAutoLayout {
    WS(wSelf);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(wSelf);
        make.bottom.mas_equalTo(wSelf).mas_offset(-12);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(10);
        make.top.mas_equalTo(wSelf.bgView).mas_offset(20);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.nameLabel.mas_right).mas_offset(30);
        make.centerY.mas_equalTo(wSelf.nameLabel);
    }];
    
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf.bgView).mas_offset(10);
        make.right.mas_equalTo(wSelf.bgView).mas_offset(-10);
        make.top.mas_equalTo(wSelf.nameLabel.mas_bottom).mas_offset(8);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(wSelf.bgView);
        make.height.equalTo(@5);
    }];
}
@end




