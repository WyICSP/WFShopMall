//
//  WFShopDataTool.h
//  WFShopMall_Example
//
//  Created by 王宇 on 2019/10/12.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WFProductListModel;

@interface WFShopDataTool : NSObject

#pragma mark 获取导购券商品列表数据
/// 获取导购券数据
/// @param params 参数
/// @param resultBlock 返回结果
+ (void)getShopMallProductsListWithParams:(NSDictionary *)params
                              resultBlock:(void(^)(NSArray <WFProductListModel *> *models))resultBlock failBlock:(void(^)(void))failBlock;


/// 获取分享批次号 分享前调用
/// @param params 参数
/// @param resultBlock 返回结果
+ (void)getShareNumWithParams:(NSDictionary *)params
                  resultBlock:(void(^)(NSString *ticketId))resultBlock;


@end

NS_ASSUME_NONNULL_END
