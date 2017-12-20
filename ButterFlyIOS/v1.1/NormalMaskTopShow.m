//
//  NormalMaskTopShow.m
//  SoilDetector
//
//  Created by het on 2017/12/19.
//  Copyright © 2017年 kaka. All rights reserved.
//

#import "NormalMaskTopShow.h"
#import <SAMCategories.h>
static const CGFloat backgroundAlpha = 0.3;
static const CGFloat animateAppearTime = 0.3;
static const CGFloat animateDisappearTime = 0.1;
@interface NormalMaskTopShow()
/**item高度**/
@property (nonatomic, assign) CGFloat itemHeight;
/**locationY**/
@property (nonatomic, assign) CGFloat locationY;
/**item宽度**/
@property (nonatomic, assign) CGFloat itemWidth;

@end
@implementation NormalMaskTopShow
- (instancetype)initWithFrame:(CGRect)frame contentViewClass:(Class)class {
    self = [super initWithFrame:CGRectMake(frame.origin.x, -[UIScreen mainScreen].bounds.size.height, frame.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        //属性配置
        self.itemHeight = frame.size.height; //item的高度
        self.locationY = frame.origin.y;
        self.itemWidth = frame.size.width;
        self.backgroundColor = [[UIColor sam_colorWithHex:@"101010"] colorWithAlphaComponent:backgroundAlpha]; //背景色
        //核心ui部分设置
        self.BFcontentView = [[class alloc]initWithFrame:CGRectMake(0, -self.itemHeight, self.itemWidth, self.itemHeight)];
        [self addSubview:self.BFcontentView];

        //点击自身销退视图
        UIView *maskDisappearView = [[UIView alloc]initWithFrame:CGRectMake(0, self.itemHeight, self.itemWidth, [UIScreen mainScreen].bounds.size.height - self.locationY)];
        maskDisappearView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSelectedMaskDisappear)];
        [maskDisappearView addGestureRecognizer:tap];
        [self addSubview:maskDisappearView];
    }
    return self;
}


#pragma mark - event handle
- (void)contentViewAppear {
    self.frame = CGRectMake(0, self.locationY, self.itemWidth, [UIScreen mainScreen].bounds.size.height);
    self.BFcontentView.frame = CGRectMake(0, 0, self.itemWidth, 0);
    self.BFcontentView.subviews[0].frame = CGRectMake(0, 0, self.itemWidth, 0);

    [UIView animateWithDuration:animateAppearTime animations:^{
        //动画效果做contentView的frame
        self.BFcontentView.frame = CGRectMake(0, 0, self.itemWidth, self.itemHeight);
        self.BFcontentView.subviews[0].frame = CGRectMake(0, 0, self.itemWidth, self.itemHeight);

    } completion:^(BOOL finished) {
        
    }];
}

- (void)contentViewdisapperar {
    [UIView animateWithDuration:animateDisappearTime animations:^{
        //动画效果做contentView的frame
        self.BFcontentView.frame = CGRectMake(0, 0, self.itemWidth, 0);
        self.BFcontentView.subviews[0].frame = CGRectMake(0, 0, self.itemWidth, 0);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, self.itemWidth, [UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)didSelectedMaskDisappear {
    [self contentViewdisapperar];
    if (self.disappearBlock) {
        self.disappearBlock();
    }
}

@end
