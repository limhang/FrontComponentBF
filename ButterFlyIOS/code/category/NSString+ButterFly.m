
#import "NSString+ButterFly.h"

@implementation NSString (ButterFly)
//////////////////////////////////====01====//////////////////////////////////
+(BOOL)isValidPassword:(NSString *)passwordStr
{
    NSString * regex = @"^[A-Za-z0-9]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:passwordStr];
    return isMatch;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,184,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0125-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,147,150,151,157,158,159,182,187,188,178,1705
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[7]|5[017-9]|8[23478]|78)\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,176,1709
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181,177,1700
     22         */
    NSString * CT = @"^1((33|53|8[019]|77)[0-9]|349|70[059])\\d{7}$";
    //178 1705 1709 176  177 1700
    NSString *newMobile = @"^17(8[0-9]|0[059]|6[0-9]|7[0-9])\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextesnewMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", newMobile];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextesnewMobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//检查邮箱是否有效
+(BOOL)isValidEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

//检查时候包含emoji
+ (BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

+ (NSString *)removeEmojiString:(NSString *)string{
    __block NSMutableString *str = [NSMutableString string];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (![NSString isContainsEmoji:substring]) {
            [str appendString:substring];
        }
    }];
    return [str copy];
}

//////////////////////////////////====02====//////////////////////////////////
- (NSString *)URLPattern {
    static NSString *urlPattern = @"(?i)\\b((?:[a-z][\\w-]+:(?:/{1,3}|[a-z0-9%])|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:\'\".,<>?«»“”‘’]))";
    return urlPattern;
}

- (BOOL)isURL {
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [self URLPattern]];
    return [urlTest evaluateWithObject:self];
}

- (NSArray *)URLList {
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:[self URLPattern]
                                                                         options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionDotMatchesLineSeparators
                                                                           error:nil];
    NSArray *matches = [reg matchesInString:self
                                    options:NSMatchingReportCompletion
                                      range:NSMakeRange(0, self.length)];
    
    NSMutableArray *URLs = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *result in matches) {
        [URLs addObject:[self substringWithRange:result.range]];
    }
    return URLs;
}

- (NSString *)trimWhitespace {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimLeftAndRightWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
