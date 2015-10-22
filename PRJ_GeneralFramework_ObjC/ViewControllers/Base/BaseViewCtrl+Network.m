//
//  BaseViewCtrl+Network.m
//  eTalk
//
//  Created by 256app on 15/9/25.
//  Copyright © 2015年 256app. All rights reserved.
//

#import "BaseViewCtrl+Network.h"


@interface BaseViewCtrl () 

@end

@implementation BaseViewCtrl (Network)

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
    [self requestSuccess:requestCode result:responseObject object:object];
}

- (void)httpRequestSuccess:(NSInteger)requestCode result:(id)responseObject
{
    [self hideMBProgressHUD];
    [self endRefreshing];
    [self requestSuccess:requestCode result:responseObject object:nil];
}

- (void)httpRequestFailure:(NSInteger)requestCode error:(NSError *)error
{
    [self hideMBProgressHUD];
    [self endRefreshing];
    [self showMBProgressHUDError:@"网络异常"];
    [self requestFailure:requestCode error:error];
}

- (void)requestSuccess:(NSInteger)requestCode result:(id)responseObject object:(id)object
{
    
}

- (void)requestFailure:(NSInteger)requestCode error:(NSError *)error
{
    
}

- (void)showMBProgressHUDIndeterminate
{
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

@end
