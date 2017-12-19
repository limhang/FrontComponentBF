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
/**放置item的容器,contentView**/
@property (nonatomic, strong) UIView *BFcontentView;
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
    }
    return self;
}


#pragma mark - event handle
- (void)contentViewAppear {
    self.frame = CGRectMake(0, self.locationY, self.itemWidth, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:animateAppearTime animations:^{
        //动画效果做contentView的frame
        self.BFcontentView.frame = CGRectMake(0, 0, self.itemWidth, self.itemHeight);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)contentViewdisapperar {
    [UIView animateWithDuration:animateDisappearTime animations:^{
        //动画效果做contentView的frame
        self.BFcontentView.frame = CGRectMake(0, -self.itemHeight, self.itemWidth, self.itemHeight);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, self.itemWidth, [UIScreen mainScreen].bounds.size.height);
    }];
}




@end
