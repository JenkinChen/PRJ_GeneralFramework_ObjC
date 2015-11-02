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

@property (nonatomic, copy) TakePhotoCompleteBlock takePhotoCompleteBlock;

@end

@implementation BaseViewCtrl (Photo)

- (void)presentPhotoActionSheetWithTitle:(NSString *)title takePhotoModel:(TakePhotoMode)takePhotoMode maxPhotos:(NSUInteger)maxPhoto completeBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock
{
    self.takePhotoCompleteBlock = takePhotoCompleteBlock;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    if (takePhotoMode & TakePhotoModeCamera) {
        [actionSheet addButtonWithTitle:@"拍照"];
        [actionSheet bk_setHandler:^{
            NSLog(@"拍照");
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
                picker.delegate = self;
                picker.allowsEditing = YES;//设置可编辑
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                if (SYS_IOS_VEERSION >= 8) {
                    self.modalPresentationStyle = UIModalPresentationCurrentContext;
                }
                [self presentViewController:picker animated:YES completion:NULL];
            }
        } forButtonAtIndex:1];
    }
    if ((takePhotoMode >> 16 & 0xf) == 0) {
        [actionSheet addButtonWithTitle:@"单选"];
        [actionSheet bk_setHandler:^{
            NSLog(@"单选");
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
                picker.delegate = self;
                picker.allowsEditing = YES;//设置可编辑
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                if (SYS_IOS_VEERSION >= 8) {
                    self.modalPresentationStyle = UIModalPresentationCurrentContext;
                }
                [self presentViewController:picker animated:YES completion:NULL];
            }
        } forButtonAtIndex:2];
    }
    else if ((takePhotoMode >> 16 & 0xf) == 1) {
        if (takePhotoMode & TakePhotoModePhotoLibraryMulti) {
            [actionSheet addButtonWithTitle:@"多选"];
            [actionSheet bk_setHandler:^{
                NSLog(@"多选");
                QBImagePickerController *imagePickerController = [QBImagePickerController new]; imagePickerController.delegate = self;
                imagePickerController.allowsMultipleSelection = YES;
                imagePickerController.maximumNumberOfSelection = maxPhoto;
                imagePickerController.showsNumberOfSelectedAssets = YES;
                [self presentViewController:imagePickerController animated:YES completion:NULL];
            } forButtonAtIndex:2];
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
