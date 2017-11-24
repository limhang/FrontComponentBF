/*
 Name: ButterFlyLocationManager.h
 Version: 0.0.1
 Created by jacob on 2017/11/13
 简介：常用的获取地理位置类，回调函数中有在该类中定义的数据模型类（国家到街道）
 功能：{
 输入端(主动)：传出地理位置模型类
 输出端(被动)：暂无
 }
 依赖的文件：Vendors中的MBProgressHUD，MBProgressHUD+ButterFly这2个依赖
 */

#import <Foundation/Foundation.h>
@class ButterFlyLocationModel;
typedef void(^ButterFlyLocationManagerDrivingBlock)(ButterFlyLocationModel *model);
@interface ButterFlyLocationManager : NSObject
//////////////////////////////////====初始化====//////////////////////////////////
- (instancetype)init;

//////////////////////////////////====方法调用====//////////////////////////////////
/**返回地理位置**/
- (void)getLocation:(ButterFlyLocationManagerDrivingBlock)locationModelBlock;

@end

@interface ButterFlyLocationModel : NSObject
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *street;
@end

//使用说明：
//if (!self.locationManager) {
//    self.locationManager = [[ButterFlyLocationManager alloc]init];
//}
//[self.locationManager getLocation:^(ButterFlyLocationModel *model) {
//    NSLog(@"地理位置模型是:%@",model);
//}];

//注意事项：
//1.需要在使用类中，有一个强引用的ButterFlyLocationManager属性
//2.最好使用懒加载

