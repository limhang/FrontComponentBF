/*
 Name: PopularChooseImageManager.h
 Version: 0.0.1
 Created by jacob on 2017/11/13
 简介：主流的选择图片管理类，支持选中图片回调功能，支持选中图片回调并保存本地功能
 功能：{
 输入端(主动)：传出选中的image给外部回调
 输出端(被动)：暂无
 }
 依赖的文件：Vendors中的MBProgressHUD，MBProgressHUD+ButterFly和RSKImageCropper，3个依赖
 */

#import <UIKit/UIKit.h>

@interface PopularChooseImageManager : NSObject
//////////////////////////////////====初始化====//////////////////////////////////
+(instancetype)manageTo:(UIViewController *)vc;

//////////////////////////////////====属性配置====//////////////////////////////////
@property (strong,nonatomic)UIColor *cancelLabelColor;

//////////////////////////////////====方法调用====//////////////////////////////////
/**
 *  只包含选照片什么的，没有存照片
 *
 */
-(void)chooseImageSuccess:(void(^)(UIImage *image))chooseImage;

/**
 *  包含存照片
 *
 *  @param image       需要存的照片
 *  @param chooseImage 选择好的照片（不包含存的照片）
 */
-(void)chooseCanSaveImage:(UIImage *)image success:(void(^)(UIImage *image))chooseImage;
@end


//使用指南：
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    __weak typeof(self) weakSelf = self;
//    self.imageManager = [PopularChooseImageManager manageTo:self];
//二选一
//1.
//    [self.imageManager chooseImageSuccess:^(UIImage *image) {
//        NSLog(@"图片是:%@",image);
//        weakSelf.saveImageView.image = image;
//    }];
//2.
//    [self.imageManager chooseCanSaveImage:self.saveImageView.image success:^(UIImage *image) {
//        NSLog(@"图片是:%@",image);
//        weakSelf.saveImageView.image = image;
//    }];
//}

//使用注意点：
//1.一定要在使用的类中，设置PopularChooseImageManager类型的对象为属性，strong类型的，如果不设置，则为局部变量，选择完照片后，直接就销毁了，无法进行其他操作
//2.block回调中的self要设置为weakSelf，如果不设置的话，有循环引用，PopularChooseImageManager中有self（vc），self中有PopularChooseImageManager的强属性类型
//3.如果设置保存图片那个回调，则参数image一定要有图片，不然后就直接返回了

