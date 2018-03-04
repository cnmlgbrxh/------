//
//  QQShoppingTools.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingTools.h"

@implementation QQShoppingTools

+ (QQShoppingTools *)shareInstance
{
    static QQShoppingTools *shareInstance = nil;
    if (!shareInstance) {
        shareInstance = [[[self class] alloc] init];
    }
    return shareInstance;
}

- (void)cacheRecord:(NSMutableArray *)recordArr {
    [[NSUserDefaults standardUserDefaults]setObject:[recordArr copy] forKey:searchRecordKey];
}

- (NSArray *)getCacheRecord {
    return [[NSUserDefaults standardUserDefaults] objectForKey:searchRecordKey];
}

+ (void) showAlertControllerWithTitle:(NSString *)titleStr message:(NSString *)msg confirmTitle :(NSString *)confirmTitle cancleTitle :(NSString *)cancleTitle vc :(id)vc confirmBlock :(RSToolsAlertControllerConfirmBlock) confirmBlock cancleBlock :(RSToolsAlertControllerCancleBlock) cancleBlock {
    
    UIAlertController    *alertController = [UIAlertController alertControllerWithTitle:titleStr message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (cancleTitle) {
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancleBlock) {
                cancleBlock();
            }
        }];
        [alertController addAction:cancle];
    }
    if (confirmTitle) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) {
                confirmBlock();
            }
        }];
        [alertController addAction:confirm];
    }
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize bgViewWidth:(CGFloat)bgViewWidth{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};    CGRect rect = [string boundingRectWithSize:CGSizeMake(bgViewWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}

+ (void)showSheetControllerWithTitiles:(NSArray *)titleArr vc :(id)vc confirmBlock :(RSToolsAlertControllerConfirmArrayBlock) confirmBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i<titleArr.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleArr[i] style:i==titleArr.count-1?UIAlertActionStyleCancel:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) {
                confirmBlock(i);
            }
        }];
        [alert addAction:action];
    }
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
