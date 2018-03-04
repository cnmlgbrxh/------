//
//  QQMoneyListModel.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQMoneyListProductDetailModel : NSObject
/**
 *  是否是体验专区
 */
@property (nonatomic,assign)BOOL isExperience;
/**
 *  理财产品id
 */
@property (nonatomic,strong)NSString *pid;
/**
 *  理财产品名称
 */
@property (nonatomic,strong)NSString *pro_name;
/**
 *  每份价格(增益专区：起投金额)
 */
@property (nonatomic,strong)NSString *pro_price;
/**
 *  年化收益率
 */
@property (nonatomic,strong)NSString *pro_rate;
/**
 *  介绍
 */
@property (nonatomic,strong)NSString *pro_details;
/**
 *  期限
 */
@property (nonatomic,strong)NSString *deadline;
/**
 *  赠礼
 */
@property (nonatomic,strong)NSString *pro_gift;
/**
 *  安全保障
 */
@property (nonatomic,strong)NSString *safety;
/**
 *  计息日期
 */
@property (nonatomic,strong)NSString *accrual_time;
/**
 *  汇款方式
 */
@property (nonatomic,strong)NSString *remit_type;
/**
 *  到期时间
 */
@property (nonatomic,strong)NSString *expire;
/**
 *  取出时间
 */
@property (nonatomic,strong)NSString *get_out;
/**
 *  取出规则
 */
@property (nonatomic,strong)NSString *get_rule;
/**
 *  提示
 */
@property (nonatomic,strong)NSString *hint;
/**
 *  提现方式
 */
@property (nonatomic,strong)NSString *cash_type;
/**
 *  常见问题
 */
@property (nonatomic,strong)NSString *FAQ;
/**
 * 总额度
 */
@property (nonatomic,strong)NSString *pro_all_price;
/**
 * 已购额度
 */
@property (nonatomic,strong)NSString *pro_ove_price;
@end



@interface QQMoneyListModel : NSObject
/**
 *  banner图片
 */
@property (nonatomic,strong)NSString *img;
/**
 *  产品专区
 */
@property (nonatomic,strong)NSArray<QQMoneyListProductDetailModel *> *matters;
/**
 *  体验专区
 */
@property (nonatomic,strong)QQMoneyListProductDetailModel  *ty;

@end
