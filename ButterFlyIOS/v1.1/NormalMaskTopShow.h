/*
 Name: NormalCustomSheetView.h
 Version: 0.0.1
 Created by jacob on 2017/12/19
 简介：点击某个按钮，从上往下，滑出视图，底色遮罩mask，该组件和底部弹出mask遮罩全屏，有明显不同，不能使用添加view到window的方案，
 由于底部弹出遮罩全屏，所有交互全发生在组件中，所以可以做到方法调用(类方法调用)的形式（类似系统组件alert）。该组件支持外部控制显示，和外部控制消失，所以，
 在外部一定会有一个该组件的强指针指向。故而，该组件加载在caller的view上，不能做成方法调用形式(web组件alert，sheet多为function调用)。
 注意点：该组件需要放在celler最上层
 功能：{
 输入端(主动)：1、contentview显示部分(该组件只是一个容器)；2、组件的消失和显示
 输出端(被动)：暂无
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>

@interface NormalMaskTopShow : UIView

//////////////////////////////////====初始化====//////////////////////////////////
- (instancetype)initWithFrame:(CGRect)frame contentViewClass:(Class)class;
//////////////////////////////////====属性配置====//////////////////////////////////


//////////////////////////////////====方法配置====//////////////////////////////////
/**显示出content**/
- (void)contentViewAppear;
/**隐藏起content**/
- (void)contentViewdisapperar;

@end


//使用说明：
//初始化
//- (NormalMaskTopShow *)dropContent {
//    if (!_dropContent) {
//        _dropContent = [[NormalMaskTopShow alloc]initWithFrame:CGRectMake(0, 50*NewBasicHeight, self.frame.size.width, 200) contentViewClass:[DropMenuView class]];
//    }
//    return _dropContent;
//}

//方法调用
//[self.dropContent contentViewAppear];
//[self.dropContent contentViewdisapperar];



