//
//  FYLCityPickView.m
//  QinYueHui
//
//  Created by FuYunLei on 2017/4/14.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLCityPickView.h"
#import "FYLCityModel.h"

#define kHeaderHeight 44
#define kPickViewHeight 220
#define kSureBtnColor [UIColor colorWithRed:55/255.f green:55/255.f blue:55/255.f alpha:1.0]
#define kCancleBtnColor [UIColor colorWithRed:55/255.f green:55/255.f blue:55/255.f alpha:1.0]
#define kHeaderViewColor [UIColor colorWithRed:247/255.f green:247/255.f blue:247/255.f alpha:1.0]


@interface FYLCityPickView()<UIPickerViewDataSource,UIPickerViewDelegate>


@property (nonatomic,strong)NSMutableArray *allProvinces;
/**
 *  省份对应的下标
 */
@property (nonatomic,assign)NSInteger rowOfProvince;
/**
 *  市对应的下标
 */
@property (nonatomic,assign)NSInteger rowOfCity;
/**
 *  区对应的下标
 */
@property (nonatomic,assign)NSInteger rowOfTown;

@end

@implementation FYLCityPickView


+ (FYLCityPickView *)showPickViewWithComplete:(FYLCityBlock)block{
    return [self showPickViewWithDefaultProvince:nil complete:block];
}
+ (FYLCityPickView *)showPickViewWithDefaultProvince:(NSString *)province complete:(FYLCityBlock)block{
    CGFloat screenWitdth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    FYLCityPickView *pickView= [[FYLCityPickView alloc] initWithFrame:CGRectMake(0, 0, screenWitdth, screenHeight)];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:pickView];
    pickView.completeBlcok = block;
    
    if (province != nil) {
        NSInteger customProvince = [pickView rowOfProvinceWithName:province];
        
        if (customProvince != recordRowOfProvince) {
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                recordRowOfProvince = [pickView rowOfProvinceWithName:province];
                recordRowOfCity = 0;
                recordRowOfTown = 0;
            });
  
        }
    }
    
    [pickView scrollToRow:recordRowOfProvince secondRow:recordRowOfCity thirdRow:recordRowOfTown];
    return pickView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData];
        [self setupUI];
    }
    return self;
}

- (void)loadData{
    
    _allProvinces = [NSMutableArray array];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FYLCity" ofType:@"plist"];
    
    NSArray *arrData = [NSArray arrayWithContentsOfFile:filePath];
    
    for (NSDictionary *dic in arrData) {
        ///此处用到底 "YYModel"  
        FYLProvince *provice = [FYLProvince yy_modelWithDictionary:dic];
        [_allProvinces addObject:provice];
    }
}

- (void)setupUI{
    
    CGFloat width = self.frame.size.width;
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    
    UIView *viewBg = [[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height-(kPickViewHeight+kHeaderHeight),width,kPickViewHeight+kHeaderHeight)];
    [viewBg setBackgroundColor:[UIColor whiteColor]];
//    viewBg.layer.cornerRadius = 5;
//    viewBg.layer.masksToBounds = YES;
    [self addSubview:viewBg];
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0, width,kHeaderHeight)];
    [viewHeader setBackgroundColor:kHeaderViewColor];
    [viewBg addSubview:viewHeader];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0,4, 50, 32)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:kCancleBtnColor forState:UIControlStateNormal];
    cancelButton.titleLabel.font= [UIFont systemFontOfSize:15];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:cancelButton];
    
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setFrame:CGRectMake(viewHeader.frame.size.width-50,4, 50, 32)];
    [sureButton setTitle:@"完成" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureButton setTitleColor:kSureBtnColor forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureACtion:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:sureButton];
    
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,kHeaderHeight,width,kPickViewHeight)];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    [viewBg addSubview:self.pickerView];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
}

- (void)cancelAction:(UIButton *)btn{
    [self removeFromSuperview];
}
- (void)sureACtion:(UIButton *)btn{
    NSArray *arr = [self getChooseCityArr];
    if (self.completeBlcok != nil) {
        self.completeBlcok(arr);
    }
    [self removeFromSuperview];
}

#pragma mark - PickerView的数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    FYLProvince *province = self.allProvinces[self.rowOfProvince];
    FYLCity *city = province.city[self.rowOfCity];
    
    if (component == 0) {
        //返回省个数
        return self.allProvinces.count;
    }
    
    if (component == 1) {
        //返回市个数
        return province.city.count;
    }
    
    if (component == 2) {
        //返回区个数
        return city.town.count;
    }
    return 0;
    
}
#pragma mark - PickerView的代理方法
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *showTitleValue=@"";
    if (component==0){//省
        FYLProvince *province = self.allProvinces[row];
        showTitleValue = province.name;
    }
    if (component==1){//市
        FYLProvince *province = self.allProvinces[self.rowOfProvince];
        FYLCity *city = province.city[row];
        showTitleValue = city.name;
    }
    if (component==2) {//区
        FYLProvince *province = self.allProvinces[self.rowOfProvince];
        FYLCity *city = province.city[self.rowOfCity];
        FYLTown *town = city.town[row];
        showTitleValue = town.name;
    }
    return showTitleValue;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 30) / 3,40)];
    label.textAlignment=NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}
static NSInteger recordRowOfProvince = 8;//上海
static NSInteger recordRowOfCity;
static NSInteger recordRowOfTown;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        self.rowOfProvince = recordRowOfProvince = row;
        self.rowOfCity = 0;
        self.rowOfTown = 0;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else if(component == 1){
        self.rowOfCity = recordRowOfCity = row;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else if(component==2){
        self.rowOfTown = recordRowOfTown = row;
    }
    
    if (self.autoGetData) {
        NSArray *arr = [self getChooseCityArr];
        if (self.completeBlcok != nil) {
            self.completeBlcok(arr);
        }
    }
    
}

#pragma mark - Tool
-(NSArray *)getChooseCityArr{
    NSArray *arr;
    
    if (self.rowOfProvince < self.allProvinces.count) {
        FYLProvince *province = self.allProvinces[self.rowOfProvince];
        if (self.rowOfCity < province.city.count) {
            FYLCity *city = province.city[self.rowOfCity];
            if (self.rowOfTown < city.town.count) {
                FYLTown *town = city.town[self.rowOfTown];
                arr = @[province.name,city.name,town.name];
            }
        }
    }
    return arr;
}
-(void)scrollToRow:(NSInteger)firstRow  secondRow:(NSInteger)secondRow thirdRow:(NSInteger)thirdRow{
    if (firstRow < self.allProvinces.count) {
        self.rowOfProvince = firstRow;
        FYLProvince *province = self.allProvinces[firstRow];
        if (secondRow < province.city.count) {
            self.rowOfCity = secondRow;
            [self.pickerView reloadComponent:1];
            FYLCity *city = province.city[secondRow];
            if (thirdRow < city.town.count) {
                self.rowOfTown = thirdRow;
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:firstRow inComponent:0 animated:YES];
                [self.pickerView selectRow:secondRow inComponent:1 animated:YES];
                [self.pickerView selectRow:thirdRow inComponent:2 animated:YES];
            }
        }
    }
    
    if (self.autoGetData) {
        NSArray *arr = [self getChooseCityArr];
        if (self.completeBlcok != nil) {
            self.completeBlcok(arr);
        }
    }
}
- (NSInteger)rowOfProvinceWithName:(NSString *)provinceName{
    
    NSInteger row = 0;
    for (FYLProvince *province in self.allProvinces) {
        if ([province.name containsString:provinceName]) {
            return row;
        }
        row++;
    }
    return row;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
