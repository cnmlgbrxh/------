//
//  QQMoneyDetaiSecondTitleView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyDetaiSecondTitleView.h"


@interface QQMoneyDetaiSecondTitleView()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrorBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnWidth;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end
@implementation QQMoneyDetaiSecondTitleView
- (void)setModel:(QQMoneyListDetailModel *)model {
    _model = model;
    self.leftImageView.image = QQIMAGE(model.imageName);
    self.titleLabel.text = model.title;
    if ([Tools isValidateNumber:model.rightTitle] ) {
        [self.arrorBtn setTitle:[NSString stringWithFormat:@"%@人",model.rightTitle] forState:UIControlStateNormal];
        self.rightLabel.hidden = NO;
        self.arrorBtn.hidden = YES;
        self.rightLabel.text = [NSString stringWithFormat:@"%@人",model.rightTitle];
    }else{
        self.rightLabel.hidden = YES;
        self.arrorBtn.hidden = NO;
        [self.arrorBtn setImage:QQIMAGE(model.rightTitle) forState:UIControlStateNormal];
    }
}

- (IBAction)moreBtnClick:(id)sender {
    if ([self.model.rightTitle isEqualToString:@"money_detail_downArror"]) {
        self.model.rightTitle = @"money_detail_upArror";
        [self.arrorBtn setImage:QQIMAGE(self.model.rightTitle) forState:UIControlStateNormal];
    }else if ([self.model.rightTitle isEqualToString:@"money_detail_upArror"]) {
        self.model.rightTitle = @"money_detail_downArror";
        [self.arrorBtn setImage:QQIMAGE(self.model.rightTitle) forState:UIControlStateNormal];
    }else{
        return;
    }
    if (self.money_detailShowMoreBlock) {
        self.money_detailShowMoreBlock(self.model.rightTitle);
    }
}

@end



@interface QQMoneyDetailExplain()
@property(nonatomic,strong)UILabel *line;
@end
@implementation QQMoneyDetailExplain
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.titleLabel];
    [self  addSubview:self.line];
    [self setAutoLayout];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithHexString:@"6b6b6b"];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = [UIColor colorWithHexString:@"cfcfcf"];
    }
    return _line;
}

- (void)setAutoLayout {
    WS(wSelf);
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(wSelf);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.right.mas_equalTo(wSelf).mas_offset(-10);
        make.top.mas_equalTo(wSelf.line).mas_offset(18);
    }];
}
@end
