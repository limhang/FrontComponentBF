/*
 Name: NormalCustomSheetView.h
 Version: 0.0.1
 Created by jacob on 2017/11/10
 简介：常用的单列表pickerView，带单位，可配置
 功能：{
 输入端(主动)：传出选中cell的数据，给外界控制
 输出端(被动)：
 }
 依赖的文件：NormalCustomSheetView和NormalPickerSubView
 */

#import <UIKit/UIKit.h>
typedef void(^PopularPickerViewDrivingBlcok)(NSString *submitString);
@interface PopularPickerView : NSObject
//////////////////////////////////====初始化====//////////////////////////////////
+ (void)showPickerViewWithData:(NSArray *)pickerData submitCallBack:(PopularPickerViewDrivingBlcok)submitBlock;
@end

//使用说明：
//[PopularPickerView showPickerViewWithData:@[@"w",@"s",@"fas",@"fsadfa",@"ft",@"o",@"p"] submitCallBack:^(NSString *submitString) {
//    NSLog(@"选中的是%@",submitString);
//}];

