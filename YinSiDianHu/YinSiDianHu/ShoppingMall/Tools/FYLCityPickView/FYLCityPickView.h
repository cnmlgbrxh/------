//
//  FYLCityPickView.h
//  QinYueHui
//
//  Created by FuYunLei on 2017/4/14.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YYModel.h"

/**
 选择完成回调

 @param arr @[省,市,区]
 */
typedef void(^FYLCityBlock)(NSArray *arr);

@interface FYLCityPickView : UIView

@property (nonatomic,copy)FYLCityBlock completeBlcok;
@property (nonatomic,strong)UIPickerView *pickerView;

/**
 自动执行回调,默认为NO
 */
@property (nonatomic,assign)BOOL autoGetData;

///滚动到对应行
- (void)scrollToRow:(NSInteger)firstRow  secondRow:(NSInteger)secondRow thirdRow:(NSInteger)thirdRow;
///获取省份对应的row
- (NSInteger)rowOfProvinceWithName:(NSString *)provinceName;


///弹出城市选择器,默认选中上海
+ (FYLCityPickView *)showPickViewWithComplete:(FYLCityBlock)block;
///弹出城市选择器,可指定默认选中省份,只有首次会生效
+ (FYLCityPickView *)showPickViewWithDefaultProvince:(NSString *)province complete:(FYLCityBlock)block;
@end
