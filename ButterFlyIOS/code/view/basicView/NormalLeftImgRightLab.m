/*
 说明具体功能设计，方便用户自己修改，原则上注释是代码量的三分一
 */
#import "NormalLeftImgRightLab.h"
@interface NormalLeftImgRightLab()
/**image的frame**/
@property (nonatomic, assign) CGRect imageFrame;
/**label的frame**/
@property (nonatomic, assign) CGRect LabelFrame;
/**self点击状态记录**/
@property (nonatomic, assign) LeftImgRightLabStatus Viewstatus;

@end

@implementation NormalLeftImgRightLab
- (instancetype)initWithFrame:(CGRect)frame withImageFrame:(CGRect)imageFrame withLabelFrame:(CGRect)labelFrame {
    self = [super initWithFrame:frame];
    if (self) {
        self.Viewstatus = LeftImgRightLabNormal;
        self.imageFrame = imageFrame;
        self.LabelFrame = labelFrame;
        [self addSubview:self.leftImage];
        [self addSubview:self.rightLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - private methods
- (void)tapView {
    if (self.Viewstatus == LeftImgRightLabNormal) {
        self.Viewstatus = LeftImgRightLabSelected;
        self.tapViewBlock(self.Viewstatus);
    } else {
        self.Viewstatus = LeftImgRightLabNormal;
        self.tapViewBlock(self.Viewstatus);
    }
}

#pragma mark - setters and getters
//////////////////////////////////====setter方法====//////////////////////////////////
- (void)setDefaultTextFont:(NSInteger)defaultTextFont {
    self.rightLabel.font = [UIFont systemFontOfSize:defaultTextFont];
}

- (void)setDefaultTextColor:(NSString *)defaultTextColor {
    self.rightLabel.textColor = [UIColor colorWithHex:defaultTextColor];
}

- (void)setDefaultImageUrl:(NSString *)defaultImageUrl {
    self.leftImage.image = [UIImage imageNamed:defaultImageUrl];
}

- (void)setTextInfo:(NSString *)textInfo {
    self.rightLabel.text = textInfo;
}

- (void)setSelectedImageUrl:(NSString *)selectedImageUrl {
    self.leftImage.image = [UIImage imageNamed:selectedImageUrl];
}

- (void)setSelectedTextFont:(NSInteger)selectedTextFont {
    self.rightLabel.font = [UIFont systemFontOfSize:selectedTextFont];
}

//////////////////////////////////====getter方法====//////////////////////////////////
- (UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc]initWithFrame:self.imageFrame];
    }
    return _leftImage;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]initWithFrame:self.LabelFrame];
        //超过frame的字体用省略号
    }
    return _rightLabel;
}
@end
