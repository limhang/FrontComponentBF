#import "MBProgressHUD.h"

@interface MBProgressHUD (ButterFly)

+(MBProgressHUD *)showCustomHudtitle:(NSString *)title;
+(void)showAutoDissmissAlertView:(NSString *)title msg:(NSString *)msg;
+(void)HidHud;

@end
