//
//  NormalTopLabBottomLab.m
//  PhotoTutorial
//
//  Created by het on 2017/11/7.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import "NormalTopLabBottomLab.h"
@interface NormalTopLabBottomLab()
/**topLabFrame**/
@property (nonatomic, assign) CGRect topLabFrame;
/**bottomLabFrame**/
@property (nonatomic, assign) CGRect bottomLabFrame;
@end

@implementation NormalTopLabBottomLab
- (instancetype)initWithFrame:(CGRect)frame withTopLabFrame:(CGRect)topLabFrame withBottomLabelFrame:(CGRect)bottomLabelFrame {
    self = [super initWithFrame:frame];
    if (self) {
        self.topLabFrame = topLabFrame;
        self.bottomLabFrame = bottomLabelFrame;
        [self addSubview:self.topLab];
        [self addSubview:self.bottomLab];
    }
    return self;
}

#pragma mark - setters and getters
//////////////////////////////////====setter====//////////////////////////////////
- (void)setTopLabFont:(NSInteger)topLabFont {
    self.topLab.font = [UIFont systemFontOfSize:topLabFont];
}

- (void)setTopLabTextcolor:(NSString *)topLabTextcolor {
    self.topLab.textColor = [UIColor colorWithHex:topLabTextcolor];
}

- (void)setBottomLabFont:(NSInteger)bottomLabFont {
    self.bottomLab.font = [UIFont systemFontOfSize:bottomLabFont];
}

- (void)setBottomLabTextcolor:(NSString *)bottomLabTextcolor {
    self.bottomLab.textColor = [UIColor colorWithHex:bottomLabTextcolor];
}

- (void)setTopTextInfo:(NSString *)topTextInfo {
    self.topLab.text = topTextInfo;
}

- (void)setBottomTextInfo:(NSString *)bottomTextInfo {
    self.bottomLab.text = bottomTextInfo;
}

//上部，设置为单行或者多行固定
- (void)setTopLabLine:(NSInteger)topLabLine {
    self.topLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.topLab.numberOfLines = topLabLine;
}

//下部，设置为单行或者多行固定
- (void)setBottomLabLine:(NSInteger)bottomLabLine {
    self.bottomLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.bottomLab.numberOfLines = bottomLabLine;
}

//////////////////////////////////====getter====//////////////////////////////////
- (UILabel *)topLab {
    if (!_topLab) {
        _topLab = [[UILabel alloc]initWithFrame:self.topLabFrame];
        _topLab.numberOfLines = 0;
    }
    return _topLab;
}

- (UILabel *)bottomLab {
    if (!_bottomLab) {
        _bottomLab = [[UILabel alloc]initWithFrame:self.bottomLabFrame];
        _bottomLab.numberOfLines = 0;
    }
    return _bottomLab;
}

@end
