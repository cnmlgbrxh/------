//
//  CellMentionDetail.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellMentionDetail.h"

@interface CellMentionDetail ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labName;

@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation CellMentionDetail

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _textF.delegate = self;
    
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
    _labName.text = [_dicDetail.allKeys firstObject];
    _textF.placeholder = [_dicDetail.allValues firstObject];
    
    if ([_labName.text isEqualToString:@"卡号"]||[_labName.text isEqualToString:@"账户"]) {
        _textF.keyboardType = UIKeyboardTypeNumberPad;
    }
}
-(void)setIsBecomeFirstResponder:(BOOL)isBecomeFirstResponder{
    _isBecomeFirstResponder = isBecomeFirstResponder;
    if (_isBecomeFirstResponder) {
        [_textF becomeFirstResponder];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_Block) {
        self.Block(_labName.text,textField.text);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
