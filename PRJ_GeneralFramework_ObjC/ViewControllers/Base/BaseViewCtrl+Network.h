//
//  BaseViewCtrl+Network.h
//  eTalk
//
//  Created by 256app on 15/9/25.
//  Copyright © 2015年 256app. All rights reserved.
//

#import "BaseViewCtrl.h"
#import "BaseViewCtrlNetworkDelegate.h"

/** 网络,需要再修改 */
@interface BaseViewCtrl (Network) 

- (void)POST:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode object:(id)object;

- (void)POST:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode;

- (void)requestSuccess:(NSInteger)requestCode result:(id)responseObject object:(id)object;

- (void)requestFailure:(NSInteger)requestCode error:(NSError *)error;

@end
