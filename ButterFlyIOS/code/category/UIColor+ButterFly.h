//常用分类UIColor，下方有部分使用说明

#import <UIKit/UIKit.h>
#define BFColorWithRGBA(r, g, b, a) \
{if (r > 1.0) {r = r/255.0f;}\
if (g > 1.0) {g = g/255.0f;}\
if (b > 1.0) {b = b/255.0;}\
[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]}\

#define BFColorWithHex(hex) [UIColor colorWithHex:hex]
@interface UIColor (ButterFly)
+ (UIColor *)colorWithHex:(NSString *)hex;

- (void)colorComponents:(CGFloat[4])components;

- (NSString *)hexString;

+ (UIColor *) colorFromHexRGB:(NSString *) inColorString alpha:(CGFloat)colorAlpha;

@end
