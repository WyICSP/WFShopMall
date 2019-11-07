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
    //接口地址 20191107 修改接口域名
    NSString *path = [NSString stringWithFormat:@"%@yzc-guide-ticket/api/product/findByParam",NEW_HOST_URL];
    [WKRequest getWithURLString:path parameters:params isShowHud:NO success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            // 20191107 datas  修改为 list
            NSArray *productDatas = [[baseModel.mDictionary safeJsonObjForKey:@"data"] safeJsonObjForKey:@"list"];
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
    //接口地址 20191107 修改接口域名
    NSString *path = [NSString stringWithFormat:@"%@yzc-guide-ticket/api/ticketShare/getShareNum",NEW_HOST_URL];
    [WKRequest postWithURLString:path parameters:params isJson:YES isShowHud:YES success:^(WKBaseModel *baseModel) {
        if (CODE_ZERO) {
            resultBlock(baseModel.data);
        }else {
            [YFToast showMessage:baseModel.message inView:[[YFKeyWindow shareInstance] getCurrentVC].view];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
