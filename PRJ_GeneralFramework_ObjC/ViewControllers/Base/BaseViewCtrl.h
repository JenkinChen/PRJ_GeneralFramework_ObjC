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

static NSString *const RJCellIdentifier = @"CellIdentifier";        /**< Cell复用标识符 */

static NSString *const RJHeaderIdentifier = @"HeaderIdentifier";     /**< 头部复用标识符 */

static NSString *const RJFooterIdentifier = @"FooterIdentifier";    /**< 尾部复用标识符 */

@interface BaseViewCtrl : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
{
    NSInteger _pageIndex;
    
@private
    MBProgressHUD *_progressHUD;
}

@property (nonatomic, copy) void (^refreshBlock) (void);    /**< 回调刷新 */

@property (nonatomic, copy) NSMutableArray *dataSource;

@property (nonatomic, copy) NSString *detailId;             /**< 详情ID */

/**
 *  初始化控件
 */
- (void)initView;

/**
 *  初始化数据
 */
- (void)initData;

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
- (void)loadData;
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
- (void)endRefreshingWith:(id)control;

/**
 *  导航栏返回
 */
- (void)popBack;

/**
 *  结束编辑
 */
- (void)endEdit;


- (void)showMBProgressHUDCorrect:(NSString *)message completionBlock:(void(^)(void))completionBlock;

- (void)showMBProgressHUDError:(NSString *)message;

- (void)showMBProgressHUDText:(NSString *)message;

- (void)hideMBProgressHUD;

@end
