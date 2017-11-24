//
//  UIImageView+commen.m
//  Miusky
//
//  Created by 李明航 on 16/10/31.
//  Copyright © 2016年 COOLBOY. All rights reserved.
//

#import "UIImageView+commen.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (ButterFly)

- (void)setCornerWith:(CGFloat)imageCornerFloat
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = imageCornerFloat;
}

- (void)setImageWithUrl:(NSString *)url
{
//    UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        
        self.image = image;
    }];
}

@end
