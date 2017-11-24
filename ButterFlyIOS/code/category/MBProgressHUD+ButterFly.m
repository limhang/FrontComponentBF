#import "MBProgressHUD+ButterFly.h"

@implementation MBProgressHUD (ButterFly)

#pragma mark -----loading框方法集
+(MBProgressHUD *)showCustomHudtitle:(NSString *)title {
    MBProgressHUD *hud=[[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow] ;
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.detailsLabel.text = title;
    [hud showAnimated:YES];
    return hud;
}

+(void)showAutoDissmissAlertView:(NSString *)title msg:(NSString *)msg
{
    MBProgressHUD *hud=[[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow] ;
    hud.mode=MBProgressHUDModeText;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    hud.detailsLabel.text = msg;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
}

+(void)HidHud
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
