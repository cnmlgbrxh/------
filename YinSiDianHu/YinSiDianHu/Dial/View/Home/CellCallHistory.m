//
//  CellCallHistory.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellCallHistory.h"

@interface CellCallHistory ()
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labPlaceAttribution;

@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@end

@implementation CellCallHistory

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setStrTitle:(NSString *)strTitle{
    _strTitle = strTitle;
    NSMutableString *muStr = [[NSMutableString alloc]initWithString:strTitle];
    NSString *first = [strTitle substringToIndex:1];
    if (strTitle.length == 11 && [first isEqualToString:@"1"]) {
        [muStr insertString:@"-" atIndex:3];
        [muStr insertString:@"-" atIndex:8];
        _labTitle.text = muStr;;
    }else if ([strTitle containsString:@"("] && [first isEqualToString:@"1"]){
        NSRange range = [strTitle rangeOfString:@"("];
        NSString *str = [strTitle substringFromIndex:range.location];
        NSString *str2 = [strTitle substringToIndex:range.location];
        NSMutableString *tempStr = [[NSMutableString alloc]initWithString:str2];
        [tempStr insertString:@"-" atIndex:3];
        [tempStr insertString:@"-" atIndex:8];
        _labTitle.text = [NSString stringWithFormat:@"%@%@",tempStr,str];
    } else{
        if (![self includeChinese:strTitle] && ![self isABC:strTitle]) {
            [muStr insertString:@"+" atIndex:0];
        }
        _labTitle.text = muStr;
    }
}
-(void)setStrDetail:(NSString *)strDetail{
    _strDetail = strDetail;
    _labTime.text = strDetail.length>10?[strDetail substringToIndex:10]:strDetail;
}
-(void)setStrPlaceAttribution:(NSString *)strPlaceAttribution{
    _strPlaceAttribution = strPlaceAttribution;
    _labPlaceAttribution.text = strPlaceAttribution;
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    _btnEdit.hidden = NO;
    _btnEdit.tag = 100+indexPath.row;
}
- (IBAction)btnClick:(UIButton *)sender {
    if (_EditBlock) {
        self.EditBlock(sender.tag-100);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)includeChinese:(NSString *)str {
    for(int i=0; i< [str length];i++) {
        int a =[str characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){ return YES;
        }
    } return NO;
}

- (BOOL)isABC:(NSString *)str{
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    int tLetterMatchCount = (int)[tLetterRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    if(tLetterMatchCount>=1){
        return YES;
    }else{
        return NO;
    }
}

@end




@interface CallShowCell()

@end
@implementation  CallShowCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self setAutolayout];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [Tools getUIColorFromString:@"171717"];
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        _phoneLabel.textColor = [Tools getUIColorFromString:@"b2b2b2"];
    }
    return _phoneLabel;
}

- (UILabel *)topLine {
    if (!_topLine) {
        _topLine = [[UILabel alloc]init];
        _topLine.backgroundColor = [Tools getUIColorFromString:@"eaeaea"];
    }
    return _topLine;
}

- (UILabel *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc]init];
        _bottomLine.backgroundColor = [Tools getUIColorFromString:@"eaeaea"];
    }
    return _bottomLine;
}

- (void)setAutolayout {
    WS(wSelf);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.top.mas_equalTo(wSelf).mas_offset(13);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wSelf).mas_offset(10);
        make.top.mas_equalTo(wSelf.nameLabel.mas_bottom).mas_offset(8);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(wSelf);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.bottom.mas_equalTo(wSelf);
        make.height.mas_equalTo(0.5);
    }];
    
}
@end












