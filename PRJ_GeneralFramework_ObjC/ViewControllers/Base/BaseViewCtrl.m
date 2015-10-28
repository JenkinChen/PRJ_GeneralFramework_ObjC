//
//  BaseViewCtrl.m
//  PRJ_GeneralFramework_ObjC
//
//  Created by C on 15/10/20.
//  Copyright © 2015年 C. All rights reserved.
//

#import "BaseViewCtrl.h"
#import "BaseViewCtrl+Network.h"

@interface BaseViewCtrl ()

@end

@implementation BaseViewCtrl

#pragma mark - Life Cycle
- (void)dealloc{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self Initialization];
    [self initView];
    [self initData];
    [self loadData];
}

- (void)Initialization
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:UIImageName(@"公用-导航栏-返回-白色") style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    
    
    UITapGestureRecognizer *endEditTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    endEditTap.delegate = self;
    [self.view addGestureRecognizer:endEditTap];
}

- (void)initView
{
    
}

- (void)initData
{
    
}

- (void)loadDataNew
{
    _pageIndex = 0;
    [self loadData];
}

- (void)loadDataMore
{
    _pageIndex++;
    [self loadData];
}

- (void)loadData
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

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%@", [touch.view class]);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] ) {
        return NO;
    }
    return YES;
}

#pragma mark - Public
- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
        [[control header] endRefreshing];
        [[control footer] endRefreshing];
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

- (void)showMBProgressHUDCorrect:(NSString *)message completionBlock:(void(^)(void))completionBlock;
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

- (void)showMBProgressHUDError:(NSString *)message;
{
    [self showMBProgressHUDWith:MBProgressHUDModeCustomView];
    _progressHUD.customView = [[UIImageView alloc] initWithImage:UIImageName(@"公共-失败-图标")];
    _progressHUD.labelText = message;
    
    [self hideMBProgressHUDAfterDelay:1];
}

- (void)showMBProgressHUDText:(NSString *)message
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
