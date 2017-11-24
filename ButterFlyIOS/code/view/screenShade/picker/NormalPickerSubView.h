/*
 Name: NormalPickerSubView.h
 Version: 0.0.1
 Created by jacob on 2017/11/10
 简介：单列表的pickerView子视图
 功能：{
 输入端(主动)：传出选中cell的数据，给外界控制
 输出端(被动)：销毁整个遮罩层方法
 }
 依赖的文件：暂无，【主要是给PopularPickerView使用】
 */

#import <UIKit/UIKit.h>
typedef void(^BFNormalPickerViewDrivingBlock)(NSString *chooseStr);
typedef void(^BFNormalPickerViewDismissBlock)();
@interface NormalPickerSubView : UIView

//////////////////////////////////====属性配置====//////////////////////////////////
/**选择器的数据源**/
@property (nonatomic, copy) NSArray *pickerViewDataSource;
/**选择器视图**/
@property (nonatomic, strong) UIPickerView *pickerView;
/**单位的名称**/
@property (nonatomic, copy) NSString *unitLabelText;

//////////////////////////////////====方法调用====//////////////////////////////////
/**选择器选中的数据的block回调**/
@property (nonatomic, copy) BFNormalPickerViewDrivingBlock chooseBlock;
/**销毁整个遮罩层的block回调**/
@property (nonatomic, copy) BFNormalPickerViewDismissBlock dismissBlock;

@end


//使用说明：
////设置item的属性方法之类
////1.获取item的视图
//NormalPickerSubView *normalPickerView = sheetView.itemsArray[0];
////2.1.设置item中pickView选中某个cell的回调
//normalPickerView.chooseBlock = submitBlock;
////2.2.设置item中选中完成，销毁遮罩层的回调
//__weak typeof(sheetView) weakSheetView = sheetView;
//normalPickerView.dismissBlock = ^{
//    [weakSheetView contentViewdisapperar];
//};
////3.1.设置item中pickView的数据源
//normalPickerView.pickerViewDataSource = pickerData;
////3.2.设置item的单位名称
//normalPickerView.unitLabelText = @"厘米";
////4.设置完成item中pickView数据源，后刷新pickView
//[normalPickerView.pickerView reloadAllComponents];

