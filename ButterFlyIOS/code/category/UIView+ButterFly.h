

#import <UIKit/UIKit.h>


@interface UIView (ButterFly)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat bf_x;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat bf_y;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat bf_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bf_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat bf_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat bf_height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat bf_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat bf_centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat bf_screenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat bf_screenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat bf_screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat bf_screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect bf_screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint bf_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize bf_size;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat bf_orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat bf_orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 Attaches the given block for a single tap action to the receiver.
 @param block The block to execute.
 */
- (void)setTapActionWithBlock:(void (^)(void))block;

/**
 Attaches the given block for a long press action to the receiver.
 @param block The block to execute.
 */
- (void)setLongPressActionWithBlock:(void (^)(void))block;

/**
 *  find the viewController
 */
- (UIViewController*)viewController;

/**
 *  为一个view添加顶部线
 */
-(void)bf_addTopLine;
/**
 *  为一个view添加底部线
 */
-(void)bf_addBottomLine;

@end


//使用说明：
//- (UIImageView *)saveImageView {
//    if (!_saveImageView) {
//        _saveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//        _saveImageView.image = [UIImage imageNamed:@"default_200"];
//        [_saveImageView bf_addBottomLine];
//        [_saveImageView setTapActionWithBlock:^{
//            NSLog(@"点击了这个东西");
//        }];
//
//        [_saveImageView setLongPressActionWithBlock:^{
//            NSLog(@"长按了这个东西");
//        }];
//    }
//    return _saveImageView;
//}

