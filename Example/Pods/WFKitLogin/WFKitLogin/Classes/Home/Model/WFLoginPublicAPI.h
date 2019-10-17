//
//  WFLoginPublicAPI.h
//  WFKitLogin_Example
//
//  Created by 王宇 on 2019/8/9.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFLoginViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WFLoginPublicAPI : NSObject

/**
 根视图
 
 @return 登录页面
 */
+ (WFLoginViewController *)rootLoginViewController;


/**
 发起支付

 @param params 参数
 */
+ (void)getPaymentMsgWithParams:(NSDictionary *)params;


/**
 退出登录 跳转登录页面
 */
+ (void)loginOutAndJumpLogin;

/**
 打电话
 @param phone 电话号码
 */
+ (void)callPhoneWithNumber:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END
