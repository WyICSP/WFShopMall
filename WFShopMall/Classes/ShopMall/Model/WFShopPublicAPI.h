//
//  WFShopPublicAPI.h
//  AFNetworking
//
//  Created by YZC on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFShopPublicAPI : NSObject



/**
 打开分享页面

 @param params H5 带过来的参数
 */
- (void)openShareViewCtrlWithParams:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
