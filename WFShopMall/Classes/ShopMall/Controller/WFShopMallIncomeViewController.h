//
//  WFShopMallIncomeViewController.h
//  AFNetworking
//
//  Created by YZC on 2019/11/12.
//

#import <WFKitMain/WFBaseNoNavWebViewController.h>
#import "YukiWebProgressLayer.h"
NS_ASSUME_NONNULL_BEGIN

@interface WFShopMallIncomeViewController : WFBaseNoNavWebViewController

/**
 加载url
 */
@property (nonatomic, copy) NSString *urlString;
/**
 进度条
 */
@property (nonatomic, strong)YukiWebProgressLayer *webProgressLayer;

@end

NS_ASSUME_NONNULL_END
