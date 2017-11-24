//
//  NormalTopImgBottomLab.m
//  PhotoTutorial
//
//  Created by het on 2017/11/7.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import "NormalTopImgBottomLab.h"

@interface NormalTopImgBottomLab()
/**image的frame**/
@property (nonatomic, assign) CGRect imageFrame;
/**label的frame**/
@property (nonatomic, assign) CGRect LabelFrame;
/**self点击状态记录**/
@property (nonatomic, assign) TopImgBottomLabStatus Viewstatus;

@end

@implementation NormalTopImgBottomLab
- (instancetype)initWithFrame:(CGRect)frame withImageFrame:(CGRect)imageFrame withLabelFrame:(CGRect)labelFrame {
    self = [super initWithFrame:frame];
    if (self) {
        self.Viewstatus = TopImgBottomLabNormal;
        self.imageFrame = imageFrame;
        self.LabelFrame = labelFrame;
        [self addSubview:self.topImage];
        [self addSubview:self.bottomLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - private methods
- (void)tapView {
    if (self.Viewstatus == TopImgBottomLabNormal) {
        self.Viewstatus = TopImgBottomLabSelected;
        self.tapViewBlock(self.Viewstatus);
    } else {
        self.Viewstatus = TopImgBottomLabNormal;
        self.tapViewBlock(self.Viewstatus);
    }
}

#pragma mark - setters and getters
//////////////////////////////////====setter方法====//////////////////////////////////
- (void)setDefaultTextFont:(NSInteger)defaultTextFont {
    self.bottomLabel.font = [UIFont systemFontOfSize:defaultTextFont];
}

- (void)setDefaultTextColor:(NSString *)defaultTextColor {
    self.bottomLabel.textColor = [UIColor colorWithHex:defaultTextColor];
}

- (void)setDefaultImageUrl:(NSString *)defaultImageUrl {
    self.topImage.image = [UIImage imageNamed:defaultImageUrl];
}

- (void)setTextInfo:(NSString *)textInfo {
    self.bottomLabel.text = textInfo;
}

- (void)setSelectedImageUrl:(NSString *)selectedImageUrl {
    self.topImage.image = [UIImage imageNamed:selectedImageUrl];
}

- (void)setSelectedTextFont:(NSInteger)selectedTextFont {
    self.bottomLabel.font = [UIFont systemFontOfSize:selectedTextFont];
}

//////////////////////////////////====getter方法====//////////////////////////////////
- (UIImageView *)topImage {
    if (!_topImage) {
        _topImage = [[UIImageView alloc]initWithFrame:self.imageFrame];
    }
    return _topImage;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]initWithFrame:self.LabelFrame];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        //超过frame的字体用省略号
    }
    return _bottomLabel;
}

@end
