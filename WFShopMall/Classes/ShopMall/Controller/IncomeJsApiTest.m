//
//  IncomeJsApiTest.m
//  AFNetworking
//
//  Created by YZC on 2019/11/13.
//

#import "IncomeJsApiTest.h"
#import "WFWithdrawViewController.h"
#import "YFKeyWindow.h"
#import "dsbridge.h"
#import "UserData.h"
#import "WKHelp.h"
#import "WFWithdrawViewController.h"
@implementation IncomeJsApiTest

/**跳转到提现页面*/
- (void)gotoWithdrawController:(NSString *)msg :(JSCallback) completionHandler{
    
    WFWithdrawViewController *withDrawVC = [[WFWithdrawViewController alloc] initWithNibName:@"WFWithdrawViewController" bundle:[NSBundle bundleForClass:[self class]]];
    
    [[[YFKeyWindow shareInstance] getCurrentVC].navigationController pushViewController:withDrawVC animated:YES];
    completionHandler(msg,YES);
    
}


/**返回*/
- (void)goBack:(NSString *)msg :(JSCallback) completionHandler{

        // 如果用户提现成功 就返回到根视图
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"withdeawToRoot"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"withdeawToRoot"];
        [[[YFKeyWindow shareInstance] getCurrentVC].navigationController popToRootViewControllerAnimated:YES];
           completionHandler(msg,YES);
        
    }else{
        [[[YFKeyWindow shareInstance] getCurrentVC].navigationController popViewControllerAnimated:YES];
        completionHandler(msg,YES);
    }
}

/** 获取版本号*/
- (NSString *)getAppVersion:(NSString *)msg {
    return APP_VERSION;
}

/**UUID*/
- (NSString *)getUserId:(NSString *)msg {
    return [UserData userInfo].uuid;
}
@end
