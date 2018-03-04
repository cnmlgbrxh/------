//
//  CellSmallState.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellSmallState.h"

@interface CellSmallState ()

@property (weak, nonatomic) IBOutlet UILabel *labName;

@property (weak, nonatomic) IBOutlet UILabel *labTime;

@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;

@end

@implementation CellSmallState

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)switchClick:(UISwitch *)sender {
    //sender setOn:<#(BOOL)#> animated:<#(BOOL)#>
    NSDictionary *dicParameters = @{@"action":@"didstats",
                                    @"username":USERNAME,
                                    @"userpass":USERPASS,
                                    @"didstats":[NSString stringWithFormat:@"%d",sender.isOn],
                                    @"didnumber":_labName.text
                                    };
    [DataRequest POST_Parameters:dicParameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        WeakSelf
        if (weakSelf.BlockSelect) {
            weakSelf.BlockSelect(sender.isOn,self.tag);
        }
        [MessageHUG showSuccessAlert:[responseObject objectForKey:@"msg"]];
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        [sender setOn:!sender.isOn];
    }];
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
    _labName.text = [_dicDetail objectForKey:@"name"];
    _labTime.text = [_dicDetail objectForKey:@"expdate"];
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    
    [_switchBtn setOn:_isSelect animated:NO];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
