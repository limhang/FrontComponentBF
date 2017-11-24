/*
 Name: NormalCustomSheetView.h
 Version: 0.0.2
 Created by jacob on 2017/11/10
 简介：模仿微信的底部滑出弹窗，底部弹出视图的子item个数和样式，支持自定义item
 功能：{
 输入端(主动)：传出选中的item的位置，传出选中itme的事件。
 输出端(被动)：支出外界，销毁整个遮罩层(0.0.2)
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>
typedef void(^customSheetDrivingBlock)(NSInteger index);
@interface NormalCustomSheetView : UIView

//////////////////////////////////====初始化====//////////////////////////////////
+ (instancetype)customSheetWithItemClass:(Class)class numberOfItems:(NSInteger)number itemHeight:(CGFloat)itemHeight bottomItemsSpace:(CGFloat)spaceHeight;

//////////////////////////////////====属性配置====//////////////////////////////////
/**底部item空白条的颜色**/
@property (nonatomic, copy) NSString *spaceViewColor;
/**初始化的itme数组**/
@property (nonatomic, strong) NSMutableArray *itemsArray;

//////////////////////////////////====方法配置====//////////////////////////////////
/**点击某个item事件，传出**/
@property (nonatomic, copy) customSheetDrivingBlock didSelectIndexBlock;
/**销毁整个view显示**/
- (void)contentViewdisapperar;

@end


//使用说明：
//NormalCustomSheetView *sheet = [NormalCustomSheetView customSheetWithItemClass:[xxxxxview class] numberOfItems:4 itemHeight:40 bottomItemsSpace:0];
//sheet.spaceViewColor = themeColor;
//sheet.didSelectIndexBlock = ^(NSInteger index) {
//    NSLog(@"点击的是那个%d",index);
//};
