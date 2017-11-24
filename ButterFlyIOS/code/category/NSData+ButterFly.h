//常用分类NSData，下方有部分使用说明

#import <Foundation/Foundation.h>

@interface NSData (ButterFly)
/**
 *  [YYYY--MM--DD]格式的字符串转 NSDate 类型
 *
 *  @param string [YYYY--MM--DD]格式的字符串
 *
 *  @return NSDate
 */
+ (NSDate *)stringToDate: (NSString *)string;

/**
 *  NSDate 类型转[YYYY--MM--DD]格式的字符串
 *
 *  @param string NSDate
 *
 *  @return [YYYY--MM--DD]格式的字符串
 */
+ (NSString *)dateToString: (NSDate *)date;

+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
@end

//使用说明：
//_model = model;
//NSDate *zeroTime = [NSData stringToDate:model.updateTime];  //model.updateTime需要处理的时间YYYY--MM--DD格式
//NSDate *eightTime = [NSData getNowDateFromatAnDate:zeroTime];
//以下部分其实等同于 self.updateTime.text = [NSData dateToString:eightTime]; --下面部分只是为了说明dateToString方法
//NSCalendar *calendar = [NSCalendar currentCalendar];
//NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//NSDateComponents *dateComponent = [calendar components:unitFlags fromDate: eightTime];
//NSInteger year = [dateComponent year];
//NSInteger month = [dateComponent month];
//NSInteger day = [dateComponent day];
//NSInteger hour = [dateComponent hour];
//NSInteger minute = [dateComponent minute];
//self.updateTime.text = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d",(int)year,(int)month,(int)day,(int)hour,(int)minute];

