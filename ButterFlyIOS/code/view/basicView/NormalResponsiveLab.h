/*
 Name: NormalResponsiveLab.h
 Version: 0.0.1
 Created by jacob on 2017/11/7
 简介：通用性Label，可响应用户点击，边框可配置，背景色可配置
 功能：{
 输入端(主动)：传出Label的点击事件
 输出端(被动)：暂无
 }
 依赖的文件：暂无
 */
typedef void(^NormalResponsiveLabDrivingBlock)();
#import <UIKit/UIKit.h>

@interface NormalResponsiveLab : UILabel
//////////////////////////////////====初始化====//////////////////////////////////
- (instancetype)initWithFrame:(CGRect)frame borderWidth:(NSInteger)borderWidth cornerRadius:(NSInteger)radius borderColor:(NSString *)borderColor;

//////////////////////////////////====属性配置====//////////////////////////////////

//////////////////////////////////====方法调用====//////////////////////////////////
/**点击label，主动将控制权移交给外界**/
@property (nonatomic, copy) NormalResponsiveLabDrivingBlock drivingBlcok;
@end
