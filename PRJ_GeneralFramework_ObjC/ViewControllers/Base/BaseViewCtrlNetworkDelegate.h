//
//  BaseViewCtrlNetworkDelegate.h
//  PRJ_GeneralFramework_ObjC
//
//  Created by C on 15/10/28.
//  Copyright © 2015年 C. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewCtrlNetworkDelegate <NSObject>

@optional
- (void)requestSuccess:(NSInteger)requestCode result:(id)responseObject object:(id)object;

- (void)requestFailure:(NSInteger)requestCode error:(NSError *)error;

@end
