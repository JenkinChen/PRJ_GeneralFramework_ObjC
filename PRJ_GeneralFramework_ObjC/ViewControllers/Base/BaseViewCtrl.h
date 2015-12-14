//
//  BaseViewCtrl.h
//  PRJ_GeneralFramework_ObjC
//
//  Created by C on 15/10/20.
//  Copyright © 2015年 C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicMacro.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <MJRefresh/MJRefresh.h>
#import "BaseViewCtrlNetworkDelegate.h"

static NSString * _Nonnull const RJCellIdentifier = @"CellIdentifier";        /**< Cell复用标识符 */

static NSString * _Nonnull const RJHeaderIdentifier = @"HeaderIdentifier";     /**< 头部复用标识符 */

static NSString * _Nonnull const RJFooterIdentifier = @"FooterIdentifier";    /**< 尾部复用标识符 */

@interface BaseViewCtrl : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, BaseViewCtrlNetworkDelegate>
{
    NSInteger _pageIndex;
    
@private
    MBProgressHUD *_progressHUD;
}

@property (nonatomic, copy, nullable) void (^refreshBlock) (void);    /**< 回调刷新 */

@property (nonatomic, strong, nullable) NSMutableArray *dataSource;

@property (nonatomic, copy, nullable) NSString *detailId;             /**< 详情ID */

/**
 *  初始化数据
 */
- (void)initialization;

/*************************为上拉下拉控件使用，可以不实现************************/
/**
 *  第一次加载
 */
- (void)loadDataNew;

/**
 *  加载更多
 */
- (void)loadDataMore;
/***************************************************************************/

/***********************************必须实现**********************************/
/**
 *  请求数据
 */
- (void)requestData;
/***************************************************************************/

/**
 *  2层查找UITableView或UICollectionView，结束刷新
 */
- (void)endRefreshing;

/**
 *  结束刷新
 *
 *  @param control UITableView或UICollectionView
 */
- (void)endRefreshingWith:(nullable id)control;

- (void)POST:(nullable NSString *)URLString parameters:(nullable id)parameters requestCode:(NSInteger)requestCode object:(nullable id)object;

- (void)POST:(nullable NSString *)URLString parameters:(nullable id)parameters requestCode:(NSInteger)requestCode;

/**
 *  导航栏返回根控制器
 */
- (void)popRoot;

/**
 *  导航栏返回
 */
- (void)popBack;

/**
 *  返回到viewController
 *
 *  @param viewController 指定viewController
 */
- (void)popToViewController:(nonnull UIViewController *)viewController;

/**
 *  结束编辑
 */
- (void)endEdit;

- (void)showMBProgressHUDCorrect:(nullable NSString *)message completionBlock:(nullable void(^)(void))completionBlock;

- (void)showMBProgressHUDError:(nullable NSString *)message;

- (void)showMBProgressHUDText:(nullable NSString *)message;

- (void)hideMBProgressHUD;

@end
