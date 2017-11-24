
#import "PopularChooseImageManager.h"
#import "RSKImageCropViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NormalDefaultSheetView.h"
#import "MBProgressHUD+ButterFly.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@interface PopularChooseImageManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate>{
}
@property (nonatomic,weak)UIViewController *vc;
@property (nonatomic,copy)void ((^chooseImage)(UIImage *image));
@property (nonatomic,strong)UIImage *needSaveImage;
@end

@implementation PopularChooseImageManager
+(instancetype)manageTo:(UIViewController *)vc{
    PopularChooseImageManager *manager = [PopularChooseImageManager new];
    manager.vc = vc;
    return manager;
}

-(void)chooseImageSuccess:(void(^)(UIImage *image))chooseImage{
    
    NormalDefaultSheetView * actionSheet = [NormalDefaultSheetView sheetCancelTitile:@"取 消" otherTitles:@[@"拍 照",@"手机相册选择"]];
    [actionSheet showInView:self.vc.view click:^(NSInteger index) {
        [self didClickOnButtonIndex:index];
    }];
    
    self.chooseImage = chooseImage;
}
-(void)chooseCanSaveImage:(UIImage *)image success:(void (^)(UIImage *))chooseImage{
    if (!image) {
        return;
    }
    self.needSaveImage = image;
    NormalDefaultSheetView * actionSheet = [NormalDefaultSheetView sheetCancelTitile:@"取 消" otherTitles:@[@"保存图片",@"拍 照",@"手机相册选择"]];
    [actionSheet showInView:self.vc.view click:^(NSInteger index) {
        [self didClickOnButtonIndex:index];
    }];
    
    self.chooseImage = chooseImage;
}

#pragma mark - CCActionSheetDelegate

- (void)didClickOnButtonIndex:(NSInteger )buttonIndex
{
//    @weakify(self);
    
    BOOL (^canUsePhotoLibrary)(void) =  ^BOOL(void){
        BOOL canUse = YES;
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
        canUse = !(author == PHAuthorizationStatusRestricted || author == PHAuthorizationStatusDenied);
#else
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        canUse = !(author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied);
#endif
        if (!canUse) {
            [MBProgressHUD HidHud];
            [MBProgressHUD showAutoDissmissAlertView:nil msg:@"请您设置允许APP访问您的照片->设置->隐私->照片"];
        }
        return canUse;
    };
    
    void (^fromtakePhoto)(void) =^{
        // 拍照
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            [MBProgressHUD HidHud];
            [MBProgressHUD showAutoDissmissAlertView:nil msg:@"请您设置允许APP访问您的相机->设置->隐私->相机"];
            return ;
        }
//        @strongify(self);
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([self isFrontCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self.vc presentViewController:controller animated:YES completion:^{
            [MBProgressHUD HidHud];
        }];
    };
    void (^fromPhotoLibrary)(void) =^{
        // 从相册中选取
//        @strongify(self);
        if (!canUsePhotoLibrary()) {
            return ;
        }
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.navigationBar.barTintColor = self.vc.navigationController.navigationBar.barTintColor;
        controller.navigationBar.titleTextAttributes = self.vc.navigationController.navigationBar.titleTextAttributes;
        controller.navigationBar.tintColor = [UIColor whiteColor];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self.vc presentViewController:controller animated:YES completion:^{
            [MBProgressHUD HidHud];
        }];
    };
    
    
    
    [MBProgressHUD showCustomHudtitle:@"请稍后"];
    
    if (self.needSaveImage) {
        if (buttonIndex == 0) {
            if (!canUsePhotoLibrary()) {
                return ;
            }
            UIImageWriteToSavedPhotosAlbum(self.needSaveImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), NULL);
            return;
        }else if (buttonIndex == 1&&
                  [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]&&
                  [self doesCameraSupportTakingPhotos]) {
            fromtakePhoto();
            return;
        } else if (buttonIndex == 2 && [self isPhotoLibraryAvailable]) {
            fromPhotoLibrary();
            return;
        }
    }
    
    
    if (buttonIndex == 0&&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]&&
        [self doesCameraSupportTakingPhotos]) {
        fromtakePhoto();
        return;
    } else if (buttonIndex == 1 && [self isPhotoLibraryAvailable]) {
        fromPhotoLibrary();
        return;
    }
    [MBProgressHUD HidHud];
}


- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [MBProgressHUD HidHud];
    [MBProgressHUD showAutoDissmissAlertView:nil msg:error? @"图片保存失败":@"图片保存成功"];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];//UIImagePickerControllerEditedImage];
        // 裁剪
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:portraitImg cropMode:RSKImageCropModeSquare];
        imageCropVC.delegate = self;
        //弹出RSKImage视图（截取image）,由于从哪个视图弹出不确定，所以安全的做法是pop
//        [self.vc.navigationController pushViewController:imageCropVC animated:YES];
        [self.vc.navigationController presentViewController:imageCropVC animated:YES completion:nil];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller{
    [self.vc.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect{
    UIImage *image = [self scaleToSize:croppedImage size:CGSizeMake(croppedImage.size.width * controller.zoomScale, croppedImage.size.height * controller.zoomScale)];
//    [self.vc.navigationController popViewControllerAnimated:YES];
    [self.vc.navigationController dismissViewControllerAnimated:YES completion:nil];
    !self.chooseImage?:self.chooseImage(image);
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //    // bug fixes: UIIMagePickerController使用中偷换StatusBar颜色的问题
    //    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
    //        ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
    //
    //        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //
    //    }
    //bugfix: 有情况导致按钮选择会变成别的颜色
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    if (self.cancelLabelColor) {
        viewController.navigationItem.rightBarButtonItem.tintColor = self.cancelLabelColor;
    }
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // bug fixes: UIIMagePickerController使用中偷换StatusBar颜色的问题
    //    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
    //        ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
    //
    //        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //    }
    
}


#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
-(void)dealloc{
    NSLog(@"%s",__func__);
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
