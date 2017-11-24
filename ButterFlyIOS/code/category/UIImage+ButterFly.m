//
//  UIImage+commen.m
//  Miusky
//
//  Created by 李明航 on 16/11/3.
//  Copyright © 2016年 COOLBOY. All rights reserved.
//

#import "UIImage+commen.h"
#import "UIImageView+WebCache.h"

@implementation UIImage (ButterFly)
- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImage:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

+ (instancetype)setImageWithUrl:(NSString *)url
{
    UIImage *image = [UIImage new];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        image = image;
    }];
    
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//        
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//         image = image;
//    }];
    
    return image;
}

//- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url
//                                         options:(SDWebImageOptions)options
//                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
//                                       completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;


//[[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@",[MiuConfig shareConfig].proPic]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//    
//} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//    [MiuConfig shareConfig].customerImage = image;
//    [self updateUI];
@end
