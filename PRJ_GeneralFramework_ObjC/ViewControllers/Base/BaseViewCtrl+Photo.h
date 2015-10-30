//
//  BaseViewCtrl+Photo.h
//  SeekLeather
//
//  Created by 256app on 15/10/19.
//  Copyright © 2015年 256app. All rights reserved.
//

#import "BaseViewCtrl.h"

typedef NS_OPTIONS(NSInteger, TakePhotoMode) {
    TakePhotoModeCamera             = 1 <<  0,     /**< 从照相机 */
    TakePhotoModePhotoLibrarySingle = 0 <<  16,    /**< 取一张 */
    TakePhotoModePhotoLibraryMulti  = 1 <<  16,    /**< 取多张 */
};

typedef void (^TakePhotoCompleteBlock) (NSArray<UIImage *> *images);

@interface BaseViewCtrl (Photo)

@property (nonatomic, copy, readonly) TakePhotoCompleteBlock takePhotoCompleteBlock;

/**
 *  取照片
 *
 *  @param title                  标题
 *  @param takePhotoModel         取照片（ 想“与或”取法，暂还没时间，只能用数组）
 *  @param maxPhoto               当取多张图片的时候，最大图片数量
 *  @param takePhotoCompleteBlock 取照片回调
 */
- (void)presentPhotoActionSheetWithTitle:(NSString *)title takePhotoModel:(TakePhotoMode)takePhotoMode maxPhotos:(NSUInteger)maxPhoto completeBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock;

@end
