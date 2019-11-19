//
//  WFShopMallViewController.m
//  WFShopMall_Example
//
//  Created by 王宇 on 2019/9/23.
//  Copyright © 2019 wyxlh. All rights reserved.
//

#import "WFShopMallViewController.h"
#import "WFShopMallSearchViewController.h"
#import "WFProductListTableViewCell.h"
#import "WFStrategyViewController.h"
#import "UITableView+YFExtension.h"
#import "WFProductMsgShareView.h"
#import "SVProgressHUD+YFHud.h"
#import "WFShopMallHeadView.h"
#import "WFProductListModel.h"
#import "WFShopMallTopView.h"
#import "WFShopNavbarView.h"
#import "NSString+Regular.h"
#import "WFShopDataTool.h"
#import "UIView+Frame.h"
#import "SKSafeObject.h"
#import "MJRefresh.h"
#import "WKSetting.h"
#import "WKHelp.h"
#import "WFWithdrawViewController.h"
#import "WFShopMallIncomeViewController.h"

@interface WFShopMallViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong, nullable) UITableView *tableView;
/**搜索条*/
@property (nonatomic, strong, nullable) WFShopNavbarView *navBar;
/**topView*/
@property (nonatomic, strong, nullable) WFShopMallTopView *topView;
/// 分享的弹出视图
@property (nonatomic, strong, nullable) WFProductMsgShareView *popShareView;
/// 头视图
@property (nonatomic, strong, nullable) WFShopMallHeadView *headView;
/**置顶Button*/
@property (nonatomic, strong, nullable) UIButton *goTopBtn;
/// 数据
@property (nonatomic, strong, nullable) NSMutableArray <WFProductListModel *> *models;
/// 页码
@property (nonatomic, assign) NSInteger currentPage;
/// 筛选 默认红包向上
@property (nonatomic, copy) NSString *ptype;

@end

@implementation WFShopMallViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark 私有方法
- (void)setUI {
    self.currentPage = 1;
    self.ptype = @"ticket_after_price_des";
    [SVProgressHUD showWithStatus:@"加载中..."];
    //添加 navbar
    [self.view addSubview:self.navBar];
    //获取数据
    [self getProductListData];
    
}

/// 获取商品数据
- (void)getProductListData {
//    ticket_after_price_asc 红包升序
//    ticket_after_price_des 红包降序
//    ticket_id_asc 导购券升序
//    ticket_id_des 导购券降序
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safeSetObject:@(self.currentPage) forKey:@"currentPage"];
    [params safeSetObject:@"20" forKey:@"pageSize"];
    [params safeSetObject:self.ptype forKey:@"ptype"];
    @weakify(self)
    [WFShopDataTool getShopMallProductsListWithParams:params resultBlock:^(NSArray<WFProductListModel *> * _Nonnull models) {
        @strongify(self)
        [self completionHandlerWithModels:models];
    } failBlock:^{
        //结束加载
        [SVProgressHUD dismiss];
    }];
}

- (void)completionHandlerWithModels:(NSArray <WFProductListModel *> *)models {
    //结束加载
    [SVProgressHUD dismiss];
    // 结束刷新
    [self.tableView.mj_footer endRefreshing];
    
    if (self.currentPage == 1)
        [self.models removeAllObjects];
    
    //将获取的数据添加到数组中
    if (models.count != 0) [self.models addObjectsFromArray:models];
    
    //是否显示空页面
    [self.tableView isShowEmptyView:self.models.count == 0];
    
    if (models.count == 0 & self.models.count != 0 & self.currentPage != 1) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer resetNoMoreData];
    }
    [self.tableView reloadData];
}

///  获取分享批次号 分享前调用
- (void)getShareNumWithModel:(WFProductListModel *)model {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safeSetObject:model.ticketId forKey:@"ticketId"];
    [params safeSetObject:model.productId forKey:@"productId"];
    
    @weakify(self)
    [WFShopDataTool getShareNumWithParams:params resultBlock:^(NSString * _Nonnull ticketId) {
        @strongify(self)
        model.shareTicketId = ticketId;
        self.popShareView.model = model;
        self.popShareView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    }];
}

/// 处理筛选
/// @param tag 11 红包 12 导购券
/// @param topOrDowm 红包 筛选方向
- (void)completionHandlerScreenWithTag:(NSInteger)tag
                       topOrDowm:(BOOL)topOrDowm {
    [SVProgressHUD showWithStatus:@"加载中..."];
    if (tag == 11 && !topOrDowm) {
        //红包 朝下
        self.ptype = @"ticket_after_price_des";
    }else if (tag == 11 && topOrDowm) {
        //红包 朝上
        self.ptype = @"ticket_after_price_asc";
    }else if (tag == 12) {
        self.ptype = @"ticket_id_des";
    }
    // 重置
    self.currentPage = 1;
    //重新获取数据
    [self getProductListData];
}

/**
 打开分享记录页面
 
 @param model 100 记录 200 分享页面
 */
- (void)openShareRecordsOrShowShareViewWithModel:(WFProductListModel *)model {
    [self getShareNumWithModel:model];
}

/**
 跳转搜索页面和攻略

 @param tag 10 搜索   20 攻略  30 收益
 */
- (void)jumpSearchOrStrategyCtrlWithTag:(NSInteger)tag {
    if (tag == 10) {
        WFShopMallSearchViewController *search = [[WFShopMallSearchViewController alloc] init];
        search.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:search animated:NO];
    }else if(tag ==20)  {
        WFStrategyViewController *strategy = [[WFStrategyViewController alloc] init];
        strategy.urlString = [NSString stringWithFormat:@"%@yzc_business_h5/page/strategy.html",H5_HOST];
        strategy.progressColor = NavColor;
        strategy.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:strategy animated:YES];
    }else{
    
        // 收益
        WFShopMallIncomeViewController *incomeVC = [[WFShopMallIncomeViewController alloc] init];
        incomeVC.hidesBottomBarWhenPushed = YES;
        incomeVC.urlString =[NSString stringWithFormat:@"%@yzc-ebus-front/#/partner/profit/index?",H5_HOST] ;
        [self.navigationController pushViewController:incomeVC animated:NO];
    }
}

/**置顶*/
- (void)clickGoTop:(UIButton *)sender {
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFProductListTableViewCell *cell = [WFProductListTableViewCell cellWithTableView:tableView];
    cell.model = self.models[indexPath.row];
    @weakify(self)
    cell.clickBtnBlock = ^(NSInteger tag) {
        @strongify(self)
        [self getShareNumWithModel:self.models[indexPath.row]];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    self.goTopBtn.alpha = offset / 200;
}

#pragma mark get set
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.maxY, ScreenWidth, ScreenHeight - NavHeight - TabbarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 127.0f;
        _tableView.separatorStyle = 0;
        _tableView.tableHeaderView = self.topView;
        [_tableView addEmptyView];
        _tableView.emptyView.backgroundColor = UIColor.clearColor;
        _tableView.emptyView.emptyLbl.hidden = YES;
        _tableView.emptyView.emptyImg.image = [UIImage imageNamed:@"noMoreGoods"];
        _tableView.emptyView.centerCons.constant = -50.0f;
        @weakify(self)
        _tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            @strongify(self)
            self.currentPage ++;
            [self getProductListData];
        }];
        [self.view addSubview:_tableView];
        [self.view addSubview:self.goTopBtn];
    }
    return _tableView;
}

/// navbar
- (WFShopNavbarView *)navBar {
    if (!_navBar) {
        _navBar = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFShopNavbarView" owner:nil options:nil] firstObject];
        _navBar.frame = CGRectMake(0, 0, ScreenWidth, NavHeight);
        @weakify(self)
        _navBar.clickBtnBlock = ^(NSInteger tag) {
            @strongify(self)
            [self jumpSearchOrStrategyCtrlWithTag:tag];
        };
    }
    return _navBar;
}

/// 筛选的 view
- (WFShopMallTopView *)topView {
    if (!_topView) {
        _topView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFShopMallTopView" owner:nil options:nil] firstObject];
        _topView.frame = CGRectMake(0, self.navBar.maxY, ScreenWidth, 50.0f);
    }
    return _topView;
}

/// 分享的弹出视图
- (WFProductMsgShareView *)popShareView {
    if (!_popShareView) {
        _popShareView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFProductMsgShareView" owner:nil options:nil] firstObject];
        _popShareView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        @weakify(self)
        _popShareView.clickApperBlock = ^{
            @strongify(self)
            [self.popShareView removeFromSuperview];
            self.popShareView = nil;
        };
        [YFWindow addSubview:_popShareView];
    }
    return _popShareView;
}

/// 头视图
- (WFShopMallHeadView *)headView {
    if (!_headView) {
        _headView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:@"WFShopMallHeadView" owner:nil options:nil] firstObject];
        @weakify(self)
        _headView.screenProductBlock = ^(NSInteger tag, BOOL isTop) {
            @strongify(self)
            [self completionHandlerScreenWithTag:tag topOrDowm:isTop];
        };
    }
    return _headView;
}

/**
 置顶

 @return goTopBtn
 */
- (UIButton *)goTopBtn {
    if (!_goTopBtn) {
        _goTopBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-52.0f, ScreenHeight-TabbarHeight-93.0f, 40.0f, 40.0f)];
        NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
        NSString *path = [NSString getImagePathWithCurrentBundler:currentBundle PhotoName:@"goTop" bundlerName:@"WFShopMall.bundle"];
        [_goTopBtn setImage:[UIImage imageWithContentsOfFile:path] forState:0];
        _goTopBtn.alpha = 0;
        [_goTopBtn addTarget:self action:@selector(clickGoTop:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goTopBtn;
}

/// 数据源
- (NSMutableArray<WFProductListModel *> *)models {
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

@end
