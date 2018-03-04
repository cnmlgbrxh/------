//
//  NumCollectionViewCell.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "NumCollectionViewCell.h"
@interface NumCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *btnNum;

@end
@implementation NumCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)btnClickExit:(UIButton *)sender {
    sender.backgroundColor = WHITECOLOR;
}
- (IBAction)btnClickDown:(UIButton *)sender {
    sender.backgroundColor = ColorHex(0xbcbcbc);
}
- (IBAction)btnClick:(UIButton *)sender {
    sender.backgroundColor = WHITECOLOR;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"点击的拨号键" object:[NSString stringWithFormat:@"%ld",sender.tag]];
}
-(void)setData:(NumData *)data{
    _data = data;
    
    [_btnNum setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",data.normal]] forState:UIControlStateNormal];
    
    [_btnNum setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",data.highlight]] forState:UIControlStateHighlighted];
    
    _btnNum.tag = 100+data.num;
    if (data.num == 12) {
        UILongPressGestureRecognizer *longTapGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTapGes:)];
        [_btnNum addGestureRecognizer:longTapGes];
    }
}
#pragma mark - 点击手势进入此方法
-(void)longTapGes:(UILongPressGestureRecognizer *)sender{
    sender.view.backgroundColor = WHITECOLOR;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"长按删除键" object:@""];
}
@end
