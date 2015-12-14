//
//  BaseViewCtrl.m
//  PRJ_GeneralFramework_ObjC
//
//  Created by C on 15/10/20.
//  Copyright © 2015年 C. All rights reserved.
//

#import "BaseViewCtrl.h"
#import "HttpRequest.h"
#import "BaseViewCtrl+Category.h"

@interface BaseViewCtrl () <HttpRequestDelegate>

@end

@implementation BaseViewCtrl

#pragma mark - Life Cycle
- (void)dealloc{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self initialization];
}

- (void)initialization
{
    
}

- (void)loadDataNew
{
    _pageIndex = 0;
    [self requestData];
}

- (void)loadDataMore
{
    _pageIndex++;
    [self requestData];
}

- (void)requestData
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    return cell;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - NetWork
- (void)POST:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode object:(id)object
{
    [self showMBProgressHUDIndeterminate];
    [HttpRequest POST:URLString parameters:parameters requestCode:requestCode delegate:self object:object];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode
{
    [self showMBProgressHUDIndeterminate];
    [HttpRequest POST:URLString parameters:parameters requestCode:requestCode delegate:self];
}

#pragma mark - HttpRequestDelegate
- (void)httpRequestSuccess:(NSInteger)requestCode result:(id)responseObject object:(id)object
{
    [self hideMBProgressHUD];
    [self endRefreshing];
    
    if ([self respondsToSelector:@selector(requestSuccess:result:object:)]) {
        [self requestSuccess:requestCode result:responseObject object:object];
    }
}

- (void)httpRequestSuccess:(NSInteger)requestCode result:(id)responseObject
{
    [self hideMBProgressHUD];
    [self endRefreshing];
    if ([self respondsToSelector:@selector(requestSuccess:result:object:)]) {
        [self requestSuccess:requestCode result:responseObject object:nil];
    }
}

- (void)httpRequestFailure:(NSInteger)requestCode error:(NSError *)error
{
    [self hideMBProgressHUD];
    [self endRefreshing];
    [self showMBProgressHUDError:@"网络异常"];
    if ([self respondsToSelector:@selector(requestFailure:error:)]) {
        [self requestFailure:requestCode error:error];
    }
}

#pragma mark - Public
- (void)popRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToViewController:(nonnull UIViewController *)viewController;
{
    [self.navigationController popToViewController:viewController animated:YES];
}

- (void)endEdit
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)endRefreshing
{
    //深入2层查找
    for (id view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]] || [view isKindOfClass:[UICollectionView class]]) {
            [self endRefreshingWith:view];
        }
        else if([view isKindOfClass:[UIView class]]) {
            UIView *parentView = view;
            for (id subView in parentView.subviews) {
                if ([subView isKindOfClass:[UITableView class]] || [subView isKindOfClass:[UICollectionView class]]) {
                    [self endRefreshingWith:subView];
                }
            }
        }
    }
}

- (void)endRefreshingWith:(id)control
{
    if ([control isKindOfClass:[UITableView class]] || [control isKindOfClass:[UICollectionView class]]) {
        [[control mj_header] endRefreshing];
        [[control mj_footer] endRefreshing];
    }
}

#pragma mark - Private
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - MBProgressHUD
- (void)showMBProgressHUDIndeterminate
{
    [self showMBProgressHUDWith:MBProgressHUDModeIndeterminate];
}

- (void)showMBProgressHUDCorrect:(nullable NSString *)message completionBlock:(nullable void(^)(void))completionBlock;
{
    [self showMBProgressHUDWith:MBProgressHUDModeCustomView];
    _progressHUD.customView = [[UIImageView alloc] initWithImage:UIImageName(@"公共-成功-图标")];
    _progressHUD.labelText = message;
    
    [_progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [_progressHUD removeFromSuperview];
        
        if (completionBlock) {
            completionBlock();
        }
    }];
}

- (void)showMBProgressHUDError:(nullable NSString *)message;
{
    [self showMBProgressHUDWith:MBProgressHUDModeCustomView];
    _progressHUD.customView = [[UIImageView alloc] initWithImage:UIImageName(@"公共-失败-图标")];
    _progressHUD.labelText = message;
    
    [self hideMBProgressHUDAfterDelay:1];
}

- (void)showMBProgressHUDText:(nullable NSString *)message
{
    [self showMBProgressHUDWith:MBProgressHUDModeText];
    _progressHUD.detailsLabelText = message;
    
    [self hideMBProgressHUDAfterDelay:1];
}

- (void)showMBProgressHUDWith:(MBProgressHUDMode)mode
{
    if (_progressHUD) {
        [self hideMBProgressHUD];
    }
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _progressHUD.mode = mode;
}

- (void)hideMBProgressHUD;
{
    [self hideMBProgressHUDAfterDelay:0];
}

- (void)hideMBProgressHUDAfterDelay:(NSTimeInterval)delay
{
    [_progressHUD hide:YES afterDelay:delay];
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
