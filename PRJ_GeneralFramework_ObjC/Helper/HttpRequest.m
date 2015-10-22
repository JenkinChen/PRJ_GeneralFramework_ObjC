//
//  HttpRequest.m
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/7.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking/AFNetworking.h>

#define PrintLog YES

@interface HttpRequest ()
{
    NSString *_URLString;
    id _parameters;
    NSInteger _requestCode;
    BaseViewCtrl<HttpRequestDelegate> *_viewController;
    id _object;
    
    AFHTTPRequestOperationManager *_manager;
}
@end

@implementation HttpRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.requestSerializer.timeoutInterval = 30.f;
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

- (instancetype)initUrl:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode delegate:(BaseViewCtrl<HttpRequestDelegate> *)viewController object:(id)object
{
    self = [self init];
    if (self) {
        
        _URLString = [[NSString stringWithFormat:@"%@%@", kApiUrl, URLString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _parameters = parameters;
        _requestCode = requestCode;
        _viewController = viewController;
        _object = object;
        
        if (PrintLog) {
            NSLog(@"\nURL===%@", URLString);
            NSLog(@"\nparameters:%@", parameters);
        }
        
    }
    return self;
}

- (void)POST
{
    [_manager POST:_URLString parameters:_parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (PrintLog) {
            NSLog(@"\nSuccessResult:%@", responseObject);
        }
        
        if (_object == nil) {
            if ([_viewController respondsToSelector:@selector(httpRequestSuccess:result:)]) {
                [_viewController httpRequestSuccess:_requestCode result:responseObject];
            }
        }
        else {
            if ([_viewController respondsToSelector:@selector(httpRequestSuccess:result:object:)]) {
                [_viewController httpRequestSuccess:_requestCode result:responseObject object:_object];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (PrintLog) {
            NSLog(@"\nErrorResult%@", error);
        }
        
        if ([_viewController respondsToSelector:@selector(httpRequestFailure:error:)]) {
            [_viewController httpRequestFailure:_requestCode error:error];
        }
    }];
}

/*
- (void)upload
{
    [_manager POST:_URLString parameters:_parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        formData appendPartWithFileData:<#(NSData *)#> name:<#(NSString *)#> fileName:<#(NSString *)#> mimeType:<#(NSString *)#>
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
 */

+ (void)POST:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode delegate:(BaseViewCtrl<HttpRequestDelegate> *)viewController
{
    HttpRequest *request = [[[self class] alloc] initUrl:URLString parameters:parameters requestCode:requestCode delegate:viewController object:nil];
    [request POST];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode delegate:(BaseViewCtrl<HttpRequestDelegate> *)viewController object:(id)object
{
    HttpRequest *request = [[[self class] alloc] initUrl:URLString parameters:parameters requestCode:requestCode delegate:viewController object:object];
    [request POST];
}

@end
