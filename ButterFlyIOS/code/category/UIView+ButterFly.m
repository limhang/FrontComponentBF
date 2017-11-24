

#import "UIView+ButterFly.h"
#import <objc/runtime.h>

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

@implementation UIView (Utils)


- (CGFloat)bf_x {
    return self.frame.origin.x;
}



- (void)setbf_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}



- (CGFloat)bf_y {
    return self.frame.origin.y;
}



- (void)setbf_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}



- (CGFloat)bf_right {
    return self.frame.origin.x + self.frame.size.width;
}



- (void)setbf_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}



- (CGFloat)bf_bottom {
    return self.frame.origin.y + self.frame.size.height;
}



- (void)setbf_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



- (CGFloat)bf_centerX {
    return self.center.x;
}



- (void)setbf_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}



- (CGFloat)bf_centerY {
    return self.center.y;
}



- (void)setbf_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}



- (CGFloat)bf_width {
    return self.frame.size.width;
}



- (void)setbf_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}



- (CGFloat)bf_height {
    return self.frame.size.height;
}



- (void)setbf_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}



- (CGFloat)bf_screenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.bf_x;
    }
    return x;
}



- (CGFloat)bf_screenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.bf_y;
    }
    return y;
}



- (CGFloat)bf_screenViewX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.bf_x;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}



- (CGFloat)bf_screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.bf_y;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}



- (CGRect)bf_screenFrame {
    return CGRectMake(self.bf_screenViewX, self.bf_screenViewY, self.bf_width, self.bf_height);
}



- (CGPoint)bf_origin {
    return self.frame.origin;
}



- (void)setbf_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}



- (CGSize)bf_size {
    return self.frame.size;
}



- (void)setbf_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}



- (CGFloat)bf_orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.bf_height : self.bf_width;
}



- (CGFloat)bf_orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.bf_width : self.bf_height;
}



- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}



- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}



- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}



- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0.0f, y = 0.0f;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.bf_x;
        y += view.bf_y;
    }
    return CGPointMake(x, y);
}


- (void)setTapActionWithBlock:(void (^)(void))block
{
	UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    self.userInteractionEnabled = YES;
	if (!gesture)
	{
		gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    //存储起来【set方法】，传递进来的block属性，以便方法中调用
	objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateRecognized)
	{
        //调用之前存储起来的block
		void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
		if (action)
		{
			action();
		}
	}
}

- (void)setLongPressActionWithBlock:(void (^)(void))block
{
	UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    self.userInteractionEnabled = YES;
	if (!gesture)
	{
		gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    
	objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
		if (action)
		{
			action();
		}
	}
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
        
    }
    return nil;
}

static const void *bfAddBottomLine = &bfAddBottomLine;
static const void *bfAddTopLine = &bfAddTopLine;
//这个地方是设置UIView的底部和底部下划线的，其实不用运行时，也可以设置，只是用了运行时后，可以有存储功能，那么我们就不会重复加载line到self上【就是多了一个if(!line)判断】
-(void)bf_addBottomLine{
    self.translatesAutoresizingMaskIntoConstraints = YES;
    UIView *line = objc_getAssociatedObject(self, bfAddBottomLine);
    if (!line) {
        line = [UIView new];
        line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
        [self addSubview:line];
        objc_setAssociatedObject(self, bfAddBottomLine, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(0.5f);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

-(void)bf_addTopLine{
    
    UIView *line = objc_getAssociatedObject(self, bfAddTopLine);
    if (!line) {
        line = [UIView new];
        line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
        [self addSubview:line];
        objc_setAssociatedObject(self, bfAddTopLine, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(0.5f);
        make.top.equalTo(self.mas_top);
    }];
}

@end
