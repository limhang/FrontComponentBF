
#import "PopularPickerView.h"
#import "NormalCustomSheetView.h"
#import "NormalPickerSubView.h"

@implementation PopularPickerView

+ (void)showPickerViewWithData:(NSArray *)pickerData submitCallBack:(PopularPickerViewDrivingBlcok)submitBlock {
    NormalCustomSheetView *sheetView = [NormalCustomSheetView customSheetWithItemClass:[NormalPickerSubView class] numberOfItems:1 itemHeight:210 bottomItemsSpace:0];
    sheetView.spaceViewColor = themeColor;
    sheetView.didSelectIndexBlock = ^(NSInteger index) {
        NSLog(@"点击的是那个%d",index);
    };
    //设置item的属性方法之类
    //1.获取item的视图
    NormalPickerSubView *normalPickerView = sheetView.itemsArray[0];
    //2.1.设置item中pickView选中某个cell的回调
    normalPickerView.chooseBlock = submitBlock;
    //2.2.设置item中选中完成，销毁遮罩层的回调
    __weak typeof(sheetView) weakSheetView = sheetView;
    normalPickerView.dismissBlock = ^{
        [weakSheetView contentViewdisapperar];
    };
    //3.1.设置item中pickView的数据源
    normalPickerView.pickerViewDataSource = pickerData;
    //3.2.设置item的单位名称
    normalPickerView.unitLabelText = @"厘米";
    //4.设置完成item中pickView数据源，后刷新pickView
    [normalPickerView.pickerView reloadAllComponents];
}

- (void)dealloc {
    NSLog(@"__%s",__func__);
}

@end


