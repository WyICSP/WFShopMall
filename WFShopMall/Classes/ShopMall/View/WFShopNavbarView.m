//
//  WFShopNavbarView.m
//  WFShopMall_Example
//
//  Created by 王宇 on 2019/9/23.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFShopNavbarView.h"

@implementation WFShopNavbarView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.searchBtn.layer.cornerRadius = 14.5f;
}

- (IBAction)clickBtn:(UIButton *)sender {
    !self.clickBtnBlock ? : self.clickBtnBlock(sender.tag);
}

@end
