//
//  WFShopDataTool.m
//  WFShopMall_Example
//
//  Created by 王宇 on 2019/10/12.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFShopDataTool.h"
#import <MJExtension/MJExtension.h>
#import "WFProductListModel.h"
#import "WFWithdrawModel.h"
#import "SKSafeObject.h"
#import "YFKeyWindow.h"
#import "WKRequest.h"
#import "WKSetting.h"
#import "YFToast.h"
#import "WKHelp.h"

@implementation WFShopDataTool

#pragma mark 获取导购券商品列表数据
+ (void)getShopMallProductsListWithParams:(NSDictionary *)params
                              resultBlock:(void(^)(NSArray <WFProductListModel *> *models))resultBlock
                                failBlock:(void(^)(void))failBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@yzc-b2bb2c-api/api/product/findByParam",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:params isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            NSArray *productDatas = [[baseModel.mDictionary safeJsonObjForKey:@"data"] safeJsonObjForKey:@"datas"];
            resultBlock([WFProductListModel mj_objectArrayWithKeyValuesArray:productDatas]);
        }else {
            failBlock();
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        failBlock();
    }];
}

+ (void)getShareNumWithParams:(NSDictionary *)params
                  resultBlock:(void(^)(NSString *ticketId))resultBlock {
    //接口地址
    NSString *path = [NSString stringWithFormat:@"%@yzc-b2bb2c-api/api/ticketShare/getShareNum",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock(baseModel.data);
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}







#pragma mark- 支付宝提现和绑定相关


/**
获取绑定信息和 可提现余额
@param params 参数
@param resultBlock 返回结果
*/
+ (void)getWithdrawDataWithParams:(NSDictionary *)params
                      resultBlock:(void(^)(WFWithdrawModel *model))resultBlock
                        failBlock:(void(^)(void))failBlock {

    //接口地址 NEW_HOST_URL
    NSString *path = [NSString stringWithFormat:@"%@app-zx/zx/partner/draw/findDrawShowData",NEW_HOST_URL];
    
    [WKRequest getWithURLString:path parameters:params isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock([WFWithdrawModel mj_objectWithKeyValues:baseModel.data]);
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
    
}





/**发送验证码*/
+ (void)bindAlipaySendCodeWithParams:(NSDictionary *)params
                         resultBlock:(void(^)(void))resultBlock {
    NSString *path = [NSString stringWithFormat:@"%@app-zx/zx/partner/draw/sendCode?",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:params isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock();
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}




/**绑定支付宝*/
+ (void)bindAlipayWithParams:(NSDictionary *)params
                 resultBlock:(void(^)(void))resultBlock {
    NSString *path = [NSString stringWithFormat:@"%@app-zx/zx/partner/draw/bindingAli",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock();
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}



/**提现
 @param params 参数
 @param resultBlock 返回结果
 */

+ (void)WithdrawWithParams:(NSDictionary *)params
                      resultBlock:(void(^)( NSDictionary *detailDic))resultBlock
                        failBlock:(void(^)(void))failBlock {
    
    
    NSString *path = [NSString stringWithFormat:@"%@app-zx/zx/partner/draw",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock(baseModel.data);
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
    
}


@end
