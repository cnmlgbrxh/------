//
//  CallView.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CallView.h"
#import "DialView.h"
#import "CallHistory.h"
#import "ContactsList.h"
#import "ContactModel.h"
#import "TalkingViewController.h"
#import "LJContactManager.h"
#import "CellCallHistory.h"
#import "CallAdvertising.h"
#import "UIButton+Button.h"
#import "SetUpViewController.h"
#import "ContactViewController.h"
#import "CallManager.h"
#define KeyboardHeight Scale(270)

@interface CallView ()<UITableViewDelegate,UITableViewDataSource>
/**
 显示所拨打的号码Label
 */
@property (strong,nonatomic) UILabel *labIphoneNumber;

/**
 电话号码
 */
@property (strong,nonatomic) NSMutableString *strmNumber;

/**
 拨打电话和通讯录按钮
 */
@property (strong,nonatomic) UIView *viewCall;
/**
 键盘View
 */
@property (strong,nonatomic) DialView *dialView;

/**
 广告或提示
 */
@property (strong,nonatomic) CallAdvertising *callAdvertising;
/**
 数据库存储联系人列表
 */
@property (strong,nonatomic) ContactsList *contactsList;

/**
 数据库存储通话记录
 */
@property (strong,nonatomic) CallHistory *callHistory;

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation CallView{
    NSArray<ContactModel *> *arrContacts;
    NSMutableArray<CallHistoryModel *> *arrmCallHistory;
    NSArray<ContactModel *> *arrSearchContacts;
    NSMutableArray *arrmPinYin;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        
        arrmPinYin = [NSMutableArray array];
        
        //通讯录改变 更新数据库
        WeakSelf
        [LJContactManager sharedInstance].contactChangeHanlder = ^(BOOL succeed, NSArray<LJPerson *> *newContacts) {
            if ([self.contactsList deleteAllData]) {
                if ([self.contactsList insertContacts:newContacts]) {
                    arrContacts = [self.contactsList queryAllData];
                    [weakSelf.tableView reloadData];
                }
            }
        };
        
        [self creatUI];
        
        //广告
        self.callAdvertising.hidden = YES;
        [self addSubview:self.callAdvertising];
        
        //键盘
        [self addSubview:self.dialView];
        
        //所选择的号码监听(NumCollectionViewCell 发过来的)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listeningForMessages:) name:@"点击的拨号键" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longDelete:) name:@"长按删除键" object:nil];
        
        //避免第一次显示延迟
        [self viewCall];
    }
    return self;
}
-(void)setArrContactsSave:(NSArray *)arrContactsSave{
    _arrContactsSave = arrContactsSave;
    //获取联系人
    arrContacts = [self.contactsList queryAllData];
}
-(void)setViewController:(UIViewController *)viewController{
    _viewController = viewController;
    self.labIphoneNumber.text = @"拨号";
}
#pragma mark - 所选择的号码
-(void)listeningForMessages:(NSNotification *)sender{
    NSInteger intNum = [sender.object integerValue]-100;
    if (intNum == 11)
    {//设置
        dispatch_async(dispatch_get_main_queue(), ^{
            [self isShowDialView:NO];
            SetUpViewController *setUpVC = [[SetUpViewController alloc] init];
            setUpVC.navTitle = @"快捷设置";
            setUpVC.BlockBack = ^{
                if (self.strmNumber.length>0) {
                    [self isShowDialView:YES];
                }
            };
            [self.viewController.navigationController pushViewController:setUpVC animated:YES];
        });
    }else if (intNum == 12)
    {//删除
        if (!IsNilString(self.strmNumber)) {
            [self.strmNumber deleteCharactersInRange:NSMakeRange(self.strmNumber.length-1, 1)];
            [arrmPinYin removeLastObject];
        }
        [self keyboardChange];
    }else
    {//号码
        if (self.strmNumber.length>18) {
            return;
        }
        if (intNum == 2) {
            [arrmPinYin addObject:@[@"a",@"b",@"c"]];
        }else if (intNum == 3){
            [arrmPinYin addObject:@[@"d",@"e",@"f"]];
        }else if (intNum == 4){
            [arrmPinYin addObject:@[@"g",@"h",@"i"]];
        }else if (intNum == 5){
            [arrmPinYin addObject:@[@"j",@"k",@"l"]];
        }else if (intNum == 6){
            [arrmPinYin addObject:@[@"m",@"n",@"o"]];
        }else if (intNum == 7){
            [arrmPinYin addObject:@[@"p",@"q",@"r",@"s"]];
        }else if (intNum == 8){
            [arrmPinYin addObject:@[@"t",@"u",@"v"]];
        }else if (intNum == 9){
            [arrmPinYin addObject:@[@"w",@"x",@"y",@"z"]];
        }
        [self.strmNumber appendFormat:@"%ld",intNum];
        [self keyboardChange];
    }
}
#pragma mark - 长按删除键
-(void)longDelete:(NSNotification *)sender{
    self.strmNumber = nil;
    [self keyboardChange];
}
#pragma mark - 键盘有操作时做的处理
-(void)keyboardChange{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        arrSearchContacts = [CallManager search:arrmPinYin arrContacts:arrContacts arrContactsSave:_arrContactsSave Iphone:self.strmNumber];
        
        [self isShowCallAdvertising];
        [_tableView reloadData];
        
        if (self.strmNumber.length>0) {
            self.labIphoneNumber.text = self.strmNumber;
            self.labIphoneNumber.font = [UIFont systemFontOfSize:Scale(23)];
            [self isShowDialView:YES];
        }else{
            self.labIphoneNumber.text = @"拨号";
            self.labIphoneNumber.font = [UIFont systemFontOfSize:Scale(17.5)];
            [arrmPinYin removeAllObjects];
            [self isShowDialView:NO];
        }
        
    });
}
#pragma mark - 点击通讯录按钮
-(void)btnContactsClick:(UIButton *)sendere{
    ContactViewController *contactVC = [[ContactViewController alloc]init];
    [self isShowDialView:NO];
    contactVC.navTitle = @"通讯录";
    WeakSelf
    contactVC.BlockNotice = ^{
        //显示拨号按钮
        [weakSelf isShowDialView:YES];
    };
    [_viewController.navigationController pushViewController:contactVC animated:YES];
}
#pragma mark - 点击拨号
-(void)btnDialClick:(UIButton *)sender{
    
    //监测网络
    [DataRequest networkStatus:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            return;
        }
    }];
    
    if (self.strmNumber.length<=6||self.strmNumber.length>=18)
    {
        [MessageHUG showWarningAlert:@"号码格式错误"];
        return;
    }
    
    if (USERMANAGER.isEnhancedCall)
    {//增强呼叫
        WeakSelf;
        [CallManager enhancedCall:_viewController iphone:self.strmNumber Status:^(BOOL authorization) {
            if (authorization) {
                arrmCallHistory = [NSMutableArray arrayWithArray:[self.callHistory queryAllData]];
                [weakSelf.tableView reloadData];
            };
        }];
    }else
    {//回拨
        ContactModel *model = [self.contactsList queryDataWith:self.strmNumber];
        model.name = model.name;
        model.phoneNumber = self.strmNumber;
        WeakSelf
        [CallManager callbackViewController:_viewController ContactModel:model iphone:self.strmNumber Status:^(BOOL authorization) {
            if (authorization) {
                arrmCallHistory = [NSMutableArray arrayWithArray:[self.callHistory queryAllData]];
                [weakSelf.tableView reloadData];
            }
        }];
    }
    
    self.strmNumber = nil;
    [self keyboardChange];
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *strPhoneNumber;
    ContactModel *model;
    if (self.strmNumber.length>0)
    {//联系人
        model = arrSearchContacts[indexPath.row];
        strPhoneNumber = model.phoneNumber;
    }else
    {//通话记录
        CallHistoryModel *historyModel = arrmCallHistory[indexPath.row];
        strPhoneNumber = historyModel.phoneNumber;
        model = [self.contactsList queryDataWith:historyModel.phoneNumber];
        model.name = model.name;
        model.phoneNumber = historyModel.phoneNumber;
    }
    
    if (USERMANAGER.isEnhancedCall)
    {
        WeakSelf;
        [CallManager enhancedCall:_viewController iphone:strPhoneNumber Status:^(BOOL authorization) {
            if (authorization) {
                arrmCallHistory = [NSMutableArray arrayWithArray:[self.callHistory queryAllData]];
                [weakSelf.tableView reloadData];
                
            }
        }];
    }else
    {
        WeakSelf
        [CallManager callbackViewController:_viewController ContactModel:model iphone:strPhoneNumber Status:^(BOOL authorization) {
            if (authorization) {
                arrmCallHistory = [NSMutableArray arrayWithArray:[self.callHistory queryAllData]];
                [weakSelf.tableView reloadData];
            }
        }];
    }
    
    self.strmNumber = nil;
    [self keyboardChange];
}
// 3. 允许row 编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.strmNumber.length>0?NO:YES;
}
// 4. 设置编辑样式
- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.isEditing) {
        return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}
// 5. 提交编辑效果
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CallHistoryModel *callHistoryModel = arrmCallHistory[indexPath.row];
        BOOL isSuccess = [self.callHistory deleteDataWithPhoneNumber:callHistoryModel.phoneNumber];
        if (isSuccess) {
            [arrmCallHistory removeObject:callHistoryModel];
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            //判断是否展示广告
            [self isShowCallAdvertising];
        }
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [DataManager save:[NSNumber numberWithBool:YES] forKey:@"隐藏键盘了"];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.strmNumber.length>0?arrSearchContacts.count:arrmCallHistory.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.strmNumber.length>0)
    {//联系人
        CallShowCell *cell =[tableView dequeueReusableCellWithIdentifier:@"id"];
        if (cell == nil) {
            cell = [[CallShowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        }
        ContactModel *contact = arrSearchContacts[indexPath.row];
        cell.nameLabel.text = contact.name;
        cell.phoneLabel.attributedText = [Tools LabelStr:contact.phoneNumber changeStr:self.strmNumber color:[UIColor blackColor] font:nil];
        return cell;
    }else
    {//通话记录
        CellCallHistory *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (cell == nil) {
            cell = LoadViewWithNIB(@"CellCallHistory");
        }
        CallHistoryModel *callHistoryModel = arrmCallHistory[indexPath.row];
        ContactModel *contactModel = [self.contactsList queryDataWith:callHistoryModel.phoneNumber];
        cell.strTitle = [callHistoryModel.callNumber integerValue]==1? contactModel.name? :callHistoryModel.phoneNumber:[NSString stringWithFormat:@"%@(%@)",contactModel.name? :callHistoryModel.phoneNumber,callHistoryModel.callNumber];
        cell.strDetail = callHistoryModel.date;
        cell.strPlaceAttribution = callHistoryModel.PlaceOfAttribution;
        cell.indexPath = indexPath;
        WeakSelf
        cell.EditBlock = ^(NSInteger indexPath) {
            [weakSelf editCallHistory:indexPath];
        };
        return cell;
    }
}
#pragma mark - 编辑通话记录
-(void)editCallHistory:(NSInteger )indexPath{
    CallHistoryModel *callHistoryModel = arrmCallHistory[indexPath];
    ContactModel *model = [self.contactsList queryDataWith:callHistoryModel.phoneNumber];
    NSString *strTitle;
    if (model.name)
    {//已在通讯录
        strTitle = @"确定删除通话记录";
    }else
    {//不在通讯录
        strTitle = nil;
    }
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:strTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionNew = [UIAlertAction actionWithTitle:@"新建联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[LJContactManager sharedInstance] createNewContactWithPhoneNum:callHistoryModel.phoneNumber controller:_viewController];
        
    }];
    UIAlertAction *actionBefore = [UIAlertAction actionWithTitle:@"添加到现有联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[LJContactManager sharedInstance] addToExistingContactsWithPhoneNum:callHistoryModel.phoneNumber controller:_viewController];
    }];
    UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        CallHistoryModel *callHistoryModel = arrmCallHistory[indexPath];
        BOOL isSuccess = [self.callHistory deleteDataWithPhoneNumber:callHistoryModel.phoneNumber];
        if (isSuccess) {
            [arrmCallHistory removeObject:callHistoryModel];
            NSIndexPath *NsIndexPath = [NSIndexPath indexPathForRow:indexPath inSection:0];
            [_tableView deleteRowsAtIndexPaths:@[NsIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [_tableView reloadData];
            //判断是否展示广告
            [self isShowCallAdvertising];
        }
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    if (strTitle==nil) {
        [alertC addAction:actionNew];
        [alertC addAction:actionBefore];
    }
    [alertC addAction:actionDelete];
    [alertC addAction:actionCancel];
    [_viewController presentViewController:alertC animated:YES completion:nil];
}
#pragma mark - 创建UI
-(void)creatUI{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.height-65) style:UITableViewStylePlain];
    }
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = HOMECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 57*QQAdapter;
    [self addSubview:_tableView];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.tableFooterView = [UIView new];
}
#pragma mark - 是否显示拨号键
-(void)setStrIsPhoneKeypad:(NSString *)strIsPhoneKeypad{
    _strIsPhoneKeypad = strIsPhoneKeypad;
    
    if ([_strIsPhoneKeypad isEqualToString:@"动画隐藏"])
    {//动画隐藏
        [UIView animateWithDuration:0.25 animations:^{
            self.dialView.frame = CGRectMake(0, self.height, SCREEN_W, KeyboardHeight);
            [self isShowDialView:NO];
        }];
        
    }else if ([_strIsPhoneKeypad isEqualToString:@"动画显示"])
    {//动画显示
        [UIView animateWithDuration:0.25 animations:^{
            self.dialView.frame = CGRectMake(0, self.height-KeyboardHeight-64-49, SCREEN_W, KeyboardHeight);
            if (self.strmNumber.length>0) {
                [self isShowDialView:YES];
            }
        }];
    }else if ([_strIsPhoneKeypad isEqualToString:@"显示"])
    {//显示
        self.dialView.frame = CGRectMake(0, self.height-KeyboardHeight-64-49, SCREEN_W, KeyboardHeight);
        if (self.strmNumber.length>0) {
            [self isShowDialView:YES];
        }
    }
    
    //获取数据库数据
    arrmCallHistory = [NSMutableArray arrayWithArray:[self.callHistory queryAllData]];
    [_tableView reloadData];
    
    //判断是否展示广告
    [self isShowCallAdvertising];
        
}
#pragma mark - 显示或隐藏广告
-(void)isShowCallAdvertising{
    if (self.strmNumber.length>0||arrmCallHistory.count!=0) {
        self.callAdvertising.hidden = YES;
    }else if (self.strmNumber.length ==0 &&arrmCallHistory.count==0){
        self.callAdvertising.hidden = NO;
    }
}
#pragma mark - 是否展示拨号按钮
-(void)isShowDialView:(BOOL)isShow{
    if (isShow)
    {//显示拨号按钮
        if (self.viewCall.hidden == YES) {
            self.viewCall.hidden = NO;
        }else{
            [[UIApplication sharedApplication].windows[0] addSubview:self.viewCall];
        }
    }else
    {//隐藏拨号按钮
        self.viewCall.hidden = YES;
    }
}
#pragma mark - 懒加载
-(UIView *)viewCall{
    if (!_viewCall) {
        //CGRectMake(SCREEN_W/4, SCREEN_H-47, SCREEN_W/4*3, 47)
        //
        _viewCall = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/5, SCREEN_H-49, SCREEN_W/5*4, 49)];
        _viewCall.backgroundColor = [UIColor blackColor];
        //CGRectMake(0, 0, SCREEN_W/2, _viewCall.height)
        //
        UIButton *btnDial = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/5*3, _viewCall.height)];
        btnDial.backgroundColor = COLOR(90, 198, 109);
        [btnDial setImage:[UIImage imageNamed:@"DialLogo"] forState:UIControlStateNormal];
        [btnDial addTarget:self action:@selector(btnDialClick:) forControlEvents:UIControlEventTouchUpInside];
        [_viewCall addSubview:btnDial];
        //CGRectMake(SCREEN_W/2, 0, SCREEN_W/4, _viewCall.height)
        //
        UIButton *btnContacts = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W/5*3, 0, SCREEN_W/5, _viewCall.height)];
        [btnContacts setImage:[UIImage imageNamed:@"通讯录"] forState:UIControlStateNormal];
        [btnContacts setImage:[UIImage imageNamed:@"通讯录se"] forState:UIControlStateHighlighted];
        [btnContacts setTitle:@"通讯录" forState:UIControlStateNormal];
        [btnContacts setTitleColor:COLOR(142, 142, 142) forState:UIControlStateNormal];
        btnContacts.titleLabel.font = [UIFont systemFontOfSize:10];
        [btnContacts centerImageAndTitle:3];
        [btnContacts addTarget:self action:@selector(btnContactsClick:) forControlEvents:UIControlEventTouchUpInside];
        btnContacts.backgroundColor = [UIColor blackColor];
        
        [_viewCall addSubview:btnContacts];
    }
    return _viewCall;
}
-(CallAdvertising *)callAdvertising{
    if (!_callAdvertising) {
        _callAdvertising = LoadViewWithNIB(@"CallAdvertising");
        _callAdvertising.frame = CGRectMake(0, 0, SCREEN_W, self.height);
    }
    return _callAdvertising;
}
-(NSMutableString *)strmNumber{
    if (!_strmNumber) {
        _strmNumber = [NSMutableString string];
    }
    return _strmNumber;
}
#pragma mark  展示号码
-(UILabel *)labIphoneNumber{
    if (!_labIphoneNumber) {
        _labIphoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 44)];
        _labIphoneNumber.textAlignment = NSTextAlignmentCenter;
        _labIphoneNumber.font = [UIFont systemFontOfSize:Scale(17.5)];
        _viewController.navigationItem.titleView = _labIphoneNumber;
    }
    return _labIphoneNumber;
}
#pragma mark 初始化数据库
-(ContactsList *)contactsList{
    if (!_contactsList) {
        _contactsList = [[ContactsList alloc]init];
    }
    return _contactsList;
}
-(CallHistory *)callHistory{
    if (!_callHistory) {
        _callHistory = [[CallHistory alloc]init];
    }
    return _callHistory;
}
#pragma mark 拨号键盘
-(DialView *)dialView{
    if (!_dialView) {
        _dialView = [[DialView alloc]initWithFrame:CGRectMake(0, self.height-KeyboardHeight-49-64, SCREEN_W, KeyboardHeight)];
    }
    return _dialView;
}
#pragma mark - 注销
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"点击的拨号键" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"长按删除键" object:nil];
}
@end
