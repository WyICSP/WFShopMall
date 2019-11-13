//
//  WFIncomeViewController.m
//  AFNetworking
//
//  Created by YZC on 2019/11/4.
//

#import "WFIncomeViewController.h"

@interface WFIncomeViewController ()

@end

@implementation WFIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收益";
    self.dwebview = [[DWKWebView alloc] initWithFrame:self.view.bounds];
    [self.dwebview evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *userAgent = result;
        NSString *newUserAgent = [userAgent stringByAppendingString:@"云智充-------"];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
        
        
        self.dwebview = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.dwebview];
        
        
        [self.dwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.jx9n.cn/yzc-ebus-front-ua/"]]];

    }];
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
