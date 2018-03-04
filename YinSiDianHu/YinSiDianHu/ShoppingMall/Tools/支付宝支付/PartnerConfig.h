//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088721075802349"

//收款支付宝账号
#define SellerID  @"86323456@qq.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJefSdkmQsfJf1dm+c91UbuJqteg6b1AIYG3WneiKsAD6iTiv6pnyVVhxI0MIfl7sVUsQGRYyteEu8nIL8qc3AAkEd/hHa/NcAtEEuIiYWOq3fGg0I5Iih7TvpSrgL8sn3s/0qUjVjZPmILTKoizA+67X/9h355S4mx8zM8S7Xa3AgMBAAECgYATjwKxtlPK/d0lYy06a8HdVUbqheFg/lLULtjGse6d0mNz2qQq0TSRhQkbwMLpMeGQQSMVTrbr0j1/LAmuM0nVr8EXkD4FavurQrKVvA5/clXzEmxj84Uq37ptop9tPqhfMqxC5vAg4I+kUP/WQDqtwEEJop0hHWCRUsUoyJMsQQJBANjhVwkIhpj/dtecZOgsOAqyvSNyf2+BLnqm7vzOlAIdTSjHR+lc6nSBPthYf59gQmfNIgXO7y0SQgcaQzfNgscCQQCy+JhOzH7fA1ERBG+UzY/kkA95cnTWsxvtISzESOn/ZjRL3yp/thOxaGS5luNYDCUfGip3iaMFDuNRd1REYnyRAkApREdBSsQBnKpKQFHa837+WiAu/HxPBS+I2vaiV9RFyrmBxtliB/H8lRMWK1CtTK2V/qw4mrVbyBuUKmUb2xjFAkEAhlzga/hXH7Lrv6zm4H5bkysckv78/NtHEgYgB9T96EKg7H1E+NCHhF9tj2/aipXDoNASJeBtRTTiMJ035IdUIQJAGMDMcw3XCL5GIKHjUuP3thkvXwTkaDU6u96nRvhfstbD8CXxEUh6xS1hfS6sdOa3LtMqJfcDfzcMmD7qwQK7ag=="
////支付宝公钥
//#define AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXEIpRFRj33g4mCAmYSta4fT6XSw+73b+VE6iMi1lXRhOKaSyD7+S863z3RLs3uaGoiaTXVy0/sXgCRPQyfgX0fwlK+w9ejqzB/G+2I9Hb46wco9AnTJ6RexVb3V9COpwfMKyruRJlr+WqCp9NQjCstp/vL6wGj9q4cvGIyxh4swIDAQAB"


#define AliPayNotifyURL  @"http://qqtel.dciig.com/app_alipay/store_alinotify.php"

//快捷支付app跳转Scheme URL Type，必填，暂用AlipayCallPay，必须修改，一般填工程名。将AliPay下的URL Schemes换成相同的名字


#endif
