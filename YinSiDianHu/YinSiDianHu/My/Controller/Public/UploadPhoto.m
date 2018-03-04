//
//  UploadPhoto.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "UploadPhoto.h"

@interface UploadPhoto ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//@property (strong,nonatomic) UIViewController*currentViewController;

@property (copy,nonatomic)void (^blockGetPhoto)(UIImage *selectImage, NSDictionary *responseObject);


@end
@implementation UploadPhoto

+ (instancetype)sharedClient {
    static UploadPhoto *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UploadPhoto alloc]init];
    });
    return _sharedClient;
}
-(void)choosePhotoForViewController:(UIViewController *)viewController getPhoto:(void (^)(UIImage *selectImage, NSDictionary *responseObject))photo{
    _blockGetPhoto = photo;
    //_currentViewController = viewController;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        }];
        [alertController addAction:defaultAction];
    }
    
    UIAlertAction *defultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [viewController presentViewController:imagePickerController animated:YES completion:nil];
    }];
    [alertController addAction:defultAction1];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 选择照片进入
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (_blockGetPhoto) {
        self.blockGetPhoto(image, @{});
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 取消选择照片进入
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
