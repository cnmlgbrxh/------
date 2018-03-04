//
//  ZeroBuyDetailHeadCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyDetailHeadCell.h"
@interface ZeroBuyDetailHeadCell()
@property (weak, nonatomic) IBOutlet UIButton *imageDetailBtn;
@property (weak, nonatomic) IBOutlet UIButton *joinRecordBtn;
@property (weak, nonatomic) IBOutlet UIButton *awardBtn;
@property (assign,nonatomic)UIButton *tempBtn;
@end

@implementation ZeroBuyDetailHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBtn:self.joinRecordBtn];
    [self setBtn:self.awardBtn];
    [self setBtn:self.imageDetailBtn];
    self.imageDetailBtn.selected = YES;
    self.tempBtn = self.imageDetailBtn;
}

- (void)setBtn:(UIButton *)btn {
    [btn setTitleColor:[Tools getUIColorFromString:@"ed4044"] forState:UIControlStateSelected];
    [btn setTitleColor:[Tools getUIColorFromString:@"9c9c9c"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)awardRecoredBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    self.tempBtn.selected = NO;
    self.tempBtn = btn;
    if (self.zero_imageDetailBlock) {
        NSInteger index;
        if ([btn.titleLabel.text isEqualToString:@"图文详情"]) {
            index = 0;
        }else{
            index = [btn.titleLabel.text isEqualToString:@"参与记录"]?1:2;
        }
        self.zero_imageDetailBlock(index);
    }
}

@end



@interface ZeroBuyDetailTitleCell()

@end
@implementation ZeroBuyDetailTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [Tools getUIColorFromString:@"686868"];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    
    WS(wSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(wSelf).mas_equalTo(10);
        make.right.bottom.mas_equalTo(wSelf).mas_equalTo(-10);
    }];
}

@end


@interface ZeroBuyDetailImageCell()
@property(nonatomic,strong)UIImageView *myImageView;
@end
@implementation  ZeroBuyDetailImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.myImageView = [[UIImageView alloc]init];
    self.myImageView.image = QQIMAGE(@"zero_detailbanner");
    [self addSubview:self.myImageView];
    
    
    WS(wSelf);
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_equalTo(10);
        make.right.mas_equalTo(wSelf).mas_equalTo(-10);
    }];
}
@end
