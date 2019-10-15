//
//  WFShopNavbarView.h
//  WFShopMall_Example
//
//  Created by 王宇 on 2019/9/23.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFShopNavbarView : UIView
/**搜索按钮*/
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
/**点击事件*/
@property (copy, nonatomic) void (^clickBtnBlock)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
