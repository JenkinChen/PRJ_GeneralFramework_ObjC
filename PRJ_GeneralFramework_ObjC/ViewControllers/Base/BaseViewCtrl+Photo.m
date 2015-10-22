//
//  BaseViewCtrl+Photo.m
//  SeekLeather
//
//  Created by 256app on 15/10/19.
//  Copyright © 2015年 256app. All rights reserved.
//

#import "BaseViewCtrl+Photo.h"
#import <QBImagePickerController/QBImagePickerController.h>
#import <objc/runtime.h>

@interface BaseViewCtrl () <UIActionSheetDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, QBImagePickerControllerDelegate>

@end

@implementation BaseViewCtrl (Photo)

- (void)presentPhotoActionSheetWithTitle:(NSString *)title takePhotoModel:(NSArray *)takePhotoModel maxPhotos:(NSUInteger)maxPhoto completeBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock;
{
    self.takePhotoCompleteBlock = takePhotoCompleteBlock;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    for (NSInteger i = 0; i < takePhotoModel.count; i++) {
        NSString *number = takePhotoModel[i];
        
        if (number.integerValue == TakePhotoModelPhotoLibraryMulti) {
            [actionSheet addButtonWithTitle:@"从相册选择"];
            [actionSheet bk_setHandler:^{//还没做
                QBImagePickerController *imagePickerController = [QBImagePickerController new]; imagePickerController.delegate = self;
                imagePickerController.allowsMultipleSelection = YES;
                imagePickerController.maximumNumberOfSelection = maxPhoto;
                imagePickerController.showsNumberOfSelectedAssets = YES;
                [self presentViewController:imagePickerController animated:YES completion:NULL];
            } forButtonAtIndex:i + 1];
        }
        else if (number.integerValue == TakePhotoModelPhotoLibrarySingle || number.integerValue == TakePhotoModelCamera) {
            [actionSheet addButtonWithTitle:number.integerValue ? @"从相册选择" : @"拍照"];
            [actionSheet bk_setHandler:^{
                UIImagePickerControllerSourceType sourceType = number.integerValue ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable: sourceType]) {
                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
                    picker.delegate = self;
                    picker.allowsEditing = YES;//设置可编辑
                    picker.sourceType = sourceType;
                    if (SYS_IOS_VEERSION >= 8) {
                        self.modalPresentationStyle = UIModalPresentationCurrentContext;
                    }
                    [self presentViewController:picker animated:YES completion:NULL];
                }
            } forButtonAtIndex:i + 1];
        }
    }
    
    [actionSheet showInView:self.view];
}

#pragma mark - imagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        if (self.takePhotoCompleteBlock) {
            self.takePhotoCompleteBlock(@[image]);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    NSMutableArray *imageArray = [NSMutableArray array];
    for (ALAsset *asset in assets) {
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [imageArray addObject:image];
    }
    if (self.takePhotoCompleteBlock) {
        self.takePhotoCompleteBlock(imageArray);
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Runtime
- (TakePhotoCompleteBlock)takePhotoCompleteBlock
{
    return objc_getAssociatedObject(self, @selector(takePhotoCompleteBlock));
}

-(void)setTakePhotoCompleteBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock
{
    objc_setAssociatedObject(self, @selector(takePhotoCompleteBlock), takePhotoCompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
