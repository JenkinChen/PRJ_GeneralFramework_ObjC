//
//  BaseViewCtrl+Photo.h
//  SeekLeather
//
//  Created by 256app on 15/10/19.
//  Copyright © 2015年 256app. All rights reserved.
//

#import "BaseViewCtrl.h"

typedef NS_ENUM(NSInteger, TakePhotoModel) {
    TakePhotoModelCamera,
    TakePhotoModelPhotoLibrarySingle,
    TakePhotoModelPhotoLibraryMulti,
};

typedef void (^TakePhotoCompleteBlock) (NSArray<UIImage *> *);

@interface BaseViewCtrl (Photo)

@property (nonatomic, copy, readonly) TakePhotoCompleteBlock takePhotoCompleteBlock;

- (void)presentPhotoActionSheetWithTitle:(NSString *)title takePhotoModel:(NSArray *)takePhotoModel maxPhotos:(NSUInteger)maxPhoto completeBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock;

@end
