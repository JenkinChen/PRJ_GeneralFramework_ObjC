//
//  BaseViewCtrl+Photo.h
//  SeekLeather
//
//  Created by 256app on 15/10/19.
//  Copyright © 2015年 256app. All rights reserved.
//

#import "BaseViewCtrl.h"

typedef NS_ENUM(NSInteger, TakePhotoModel) {
    TakePhotoModelCamera,               /**< 从照相机 */
    TakePhotoModelPhotoLibrarySingle,   /**< 取一张 */
    TakePhotoModelPhotoLibraryMulti,    /**< 取多张 */
};

typedef void (^TakePhotoCompleteBlock) (NSArray<UIImage *> *);

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
- (void)presentPhotoActionSheetWithTitle:(NSString *)title takePhotoModel:(NSArray *)takePhotoModel maxPhotos:(NSUInteger)maxPhoto completeBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock;

@end
