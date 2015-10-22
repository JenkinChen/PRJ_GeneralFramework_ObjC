//
//  UIImage+Category.m
//  eTalk
//
//  Created by 256app on 15/9/8.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

+ (UIImage *)imageWith:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)compressionQuality:(CGFloat)compressionQuality scaledToSize:(CGSize)newSize
{
    NSData *imageData = UIImageJPEGRepresentation(self, compressionQuality);
    UIImage *newImage = [UIImage imageWithData:imageData];
    
    
    CGSize oldsize = newImage.size;
    CGRect rect;
    if (newSize.width/newSize.height > oldsize.width/oldsize.height) {
        rect.size.width = newSize.height*oldsize.width/oldsize.height;
        rect.size.height = newSize.height;
        rect.origin.x = (newSize.width - rect.size.width)/2;
        rect.origin.y = 0;
    }
    else{
        rect.size.width = newSize.width;
        rect.size.height = newSize.width*oldsize.height/oldsize.width;
        rect.origin.x = 0;
        rect.origin.y = (newSize.height - rect.size.height)/2;
    }
    
    UIGraphicsBeginImageContext(newSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));//clear background
    [self drawInRect:rect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
