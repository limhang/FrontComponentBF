//常用分类NSString，下方有部分使用说明

#import <Foundation/Foundation.h>

@interface NSString (ButterFly)
//////////////////////////////////====01====//////////////////////////////////
+ (BOOL)isMobileNumber:(NSString *)mobileNum;//手机号验证

+(BOOL)isValidEmail:(NSString *)emailStr;//检查邮箱是否有效

+(BOOL)isValidPassword:(NSString *)passwordStr;//检查密码格式是否正确

+ (BOOL)isContainsEmoji:(NSString *)string;//检查时候包含emoji

+ (NSString *)removeEmojiString:(NSString *)string;//去除emoji

//////////////////////////////////====02====//////////////////////////////////
/*返回URL的正则表达式*/
- (NSString *)URLPattern;

/*判断是否为URL*/
- (BOOL)isURL;

/*返回其中包含的URL列表*/
- (NSArray *)URLList;

/*去除空格*/
- (NSString *)trimWhitespace;

/*去除左右空格*/
- (NSString *)trimLeftAndRightWhitespace;
@end
