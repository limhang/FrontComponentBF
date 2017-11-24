//
//  NormalResponsiveLab.m
//  PhotoTutorial
//
//  Created by het on 2017/11/7.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import "NormalResponsiveLab.h"

@implementation NormalResponsiveLab

- (instancetype)initWithFrame:(CGRect)frame borderWidth:(NSInteger)borderWidth cornerRadius:(NSInteger)radius borderColor:(NSString *)borderColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;//边框圆角大小
        self.layer.borderColor = [UIColor colorWithHex:borderColor].CGColor;
        self.layer.borderWidth = borderWidth;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - private methods
- (void)tapView {
    if (self.drivingBlcok) {
        self.drivingBlcok();
    }
}

@end
