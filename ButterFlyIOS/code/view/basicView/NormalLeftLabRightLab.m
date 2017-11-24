//
//  NormalLeftLabRightLab.m
//  PhotoTutorial
//
//  Created by het on 2017/11/7.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import "NormalLeftLabRightLab.h"
@interface NormalLeftLabRightLab()
/**leftLabFrame**/
@property (nonatomic, assign) CGRect leftLabFrame;
/**rightLabFrame**/
@property (nonatomic, assign) CGRect rightLabFrame;
@end

@implementation NormalLeftLabRightLab
- (instancetype)initWithFrame:(CGRect)frame withLeftLabFrame:(CGRect)leftLabFrame withRightLabelFrame:(CGRect)rightLabelFrame {
    self = [super initWithFrame:frame];
    if (self) {
        self.leftLabFrame = leftLabFrame;
        self.rightLabFrame = rightLabelFrame;
        [self addSubview:self.leftLab];
        [self addSubview:self.rightLab];
    }
    return self;
}

#pragma mark - setters and getters
//////////////////////////////////====setter====//////////////////////////////////
- (void)setLeftLabFont:(NSInteger)leftLabFont {
    self.leftLab.font = [UIFont systemFontOfSize:leftLabFont];
}

- (void)setLeftLabTextcolor:(NSString *)leftLabTextcolor {
    self.leftLab.textColor = [UIColor colorWithHex:leftLabTextcolor];
}

- (void)setRightLabFont:(NSInteger)rightLabFont {
    self.rightLab.font = [UIFont systemFontOfSize:rightLabFont];
}

- (void)setRightLabTextcolor:(NSString *)rightLabTextcolor {
    self.rightLab.textColor = [UIColor colorWithHex:rightLabTextcolor];
}

- (void)setLeftTextInfo:(NSString *)leftTextInfo {
    self.leftLab.text = leftTextInfo;
}

- (void)setRightTextInfo:(NSString *)rightTextInfo {
    self.rightLab.text = rightTextInfo;
}

//上部，设置为单行或者多行固定
- (void)setLeftLabLine:(NSInteger)leftLabLine {
    self.leftLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.leftLab.numberOfLines = leftLabLine;
}

//下部，设置为单行或者多行固定
- (void)setRightLabLine:(NSInteger)rightLabLine {
    self.rightLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.rightLab.numberOfLines = rightLabLine;
}

//////////////////////////////////====getter====//////////////////////////////////
- (UILabel *)leftLab {
    if (!_leftLab) {
        _leftLab = [[UILabel alloc]initWithFrame:self.leftLabFrame];
        _leftLab.numberOfLines = 0;
    }
    return _leftLab;
}

- (UILabel *)rightLab {
    if (!_rightLab) {
        _rightLab = [[UILabel alloc]initWithFrame:self.rightLabFrame];
        _rightLab.numberOfLines = 0;
    }
    return _rightLab;
}

@end
