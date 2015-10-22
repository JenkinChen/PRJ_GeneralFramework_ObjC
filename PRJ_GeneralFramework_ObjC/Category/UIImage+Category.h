//
//  UIImage+Category.h
//  eTalk
//
//  Created by 256app on 15/9/8.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/**
 *  颜色转化图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWith:(UIColor *)color size:(CGSize)size;

/**
 *  压缩裁剪图片
 *
 *  @param image              原图片
 *  @param compressionQuality 压缩质量
 *  @param newSize            新图片大小
 *
 *  @return 新图片
 */
- (UIImage *)compressionQuality:(CGFloat)compressionQuality scaledToSize:(CGSize)newSize;

@end
