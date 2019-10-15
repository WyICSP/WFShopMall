//
//  YFMediatorManager+WFShopMall.m
//  WFShopMall_Example
//
//  Created by 王宇 on 2019/10/14.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "YFMediatorManager+WFShopMall.h"

@implementation YFMediatorManager (WFShopMall)

+ (void)shareWechatWithWebpageUrl:(NSString *)webpageUrl
                            title:(NSString *)title
                      description:(NSString *)description
                   thumbImageName:(NSString *)thumbImageName
                            scnce:(NSInteger)scnce {
    NSArray *pamrs = @[webpageUrl,title,description,thumbImageName,@(scnce)];
    [self performTarget:@"WFPayPublicAPI" action:@"shareWechatWithWebpageUrl:" params:pamrs isRequiredReturnValue:NO];
}



@end
