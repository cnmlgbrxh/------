//
//  ZeroBuyWillStartCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/21.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyWillStartCell.h"
@interface ZeroBuyWillStartCell()
{
    dispatch_source_t _timer;
}
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@end

@implementation ZeroBuyWillStartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self clipButten:self.dayLabel];
    [self clipButten:self.hourLabel];
    [self clipButten:self.minuteLabel];
    [self clipButten:self.secondLabel];
}

- (void)setEndTime:(NSString *)endTime {
    _endTime = endTime;
}

- (void)clipButten:(UILabel *)label {
    label.layer.cornerRadius = 4;
    label.layer.masksToBounds = YES;
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    if (_timer==nil) {
        _timeInterval = timeInterval;
                if(timeInterval<=0){ //倒计时结束，关闭
//                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.dayLabel.text = @"00";
                        self.hourLabel.text = @"00";
                        self.minuteLabel.text = @"00";
                        self.secondLabel.text = @"00";
                    });
                }else{
                    int days = (int)(timeInterval/(3600*24));
                    if (days==0) {
                        self.dayLabel.text = @"";
                    }
                    int hours = (int)((timeInterval-days*24*3600)/3600);
                    int minute = (int)(timeInterval-days*24*3600-hours*3600)/60;
                    int second = timeInterval-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayLabel.text = @"00";
                        }else if(days < 10){
                            self.dayLabel.text = [NSString stringWithFormat:@"0%d",days];
                        }else{
                            self.dayLabel.text = [NSString stringWithFormat:@"%d",days];
                        }
                        if (hours<10) {
                            self.hourLabel.text = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                            self.hourLabel.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minuteLabel.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteLabel.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondLabel.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondLabel.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                }
        }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
