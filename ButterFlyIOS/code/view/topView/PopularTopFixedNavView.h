/*
 Name: PopularTopFixedNavView.h
 Version: 0.0.2
 Created by jacob on 2017/11/4
 简介：顶部的导航，宽度支持自定义，具有有多少个item，视创建该对象参数而定，选中的item高亮底部下划线高亮，默认高亮第一个item。
 功能：{
     输入端(主动)：传出选中的item的位置，传出选中itme的事件。
     输出端(被动)：支持外部控制选中某个item高亮。
 }
 依赖的文件：暂无
*/
#import <UIKit/UIKit.h>
typedef void(^SelectedItemBlock)(NSInteger selectedNum);
@interface PopularTopFixedNavView : UIView
/**初始化方法，传入想要展示的items**/
- (instancetype)initWithDataArray:(NSArray *)dataArray
                        withFrame:(CGRect)frame withFixedBottomLineWidth:(CGFloat)bottomLineWidth;

//////////////////////////////////====属性设计====//////////////////////////////////
/**选中的颜色**/
@property (nonatomic, copy) NSString *selectedColor;
/**默认的颜色**/
@property (nonatomic, copy) NSString *defaultColor;
/**字体大小设置**/
@property (nonatomic, assign) NSInteger fontSize;
/**新增模式添加固定长度**/
@property (nonatomic, assign) CGFloat fixedWidthForBottomLine;


//////////////////////////////////====方法调用====//////////////////////////////////
/**主动输入选中的item**/
@property (nonatomic, copy) SelectedItemBlock SelectedBlock;
/**被动修改某个item高亮**/
- (void)seletedHighlightItem:(NSInteger)number;
@end


//自带依赖UICollectionViewCell
@interface DependencyItemCC : UICollectionViewCell
/**居中的item文字**/
@property (nonatomic, strong) UILabel *itemWordLabel;

@end


//使用例子
//初始设置：
//其中如果不设置withFixedBottomLineWidth长度，默认为item那个长
//- (PopularTopFixedNavView *)middleSwitchView {
//    if (!_middleSwitchView) {
//        CGSize sizeword = [@"建模进度" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]}];
//        _middleSwitchView = [[PopularTopFixedNavView alloc]initWithDataArray:@[@"物品属性",@"物品成分"] withFrame:CGRectMake(20 * NewBasicWidth, 164, ScreenWidth, 36) withFixedBottomLineWidth:sizeword.width];
//        _middleSwitchView.defaultColor = @"848484";
//        _middleSwitchView.selectedColor = themeColor;
//        _middleSwitchView.fontSize = 16;
//        _middleSwitchView.SelectedBlock = ^(NSInteger number) {
//            NSLog(@"%d点击的第几个",number);
//        };
//    }
//    return _middleSwitchView;
//}
//
//方法调用：
//if (i > 3) {
//    [self.ppView seletedHighlightItem:1];
//} else {
//    [self.ppView seletedHighlightItem:0];
//}

