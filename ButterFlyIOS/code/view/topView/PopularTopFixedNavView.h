/*
 Name: PopularTopFixedNavView.h
 Version: 0.0.1
 Created by jacob on 2017/11/4
 简介：顶部的导航，占满一个屏幕的宽度，具有有多少个item，视创建该对象参数而定，选中的item高亮底部下划线高亮，默认高亮第一个item。
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
                        withFrame:(CGRect)frame;

//////////////////////////////////====属性设计====//////////////////////////////////
/**选中的颜色**/
@property (nonatomic, copy) NSString *selectedColor;
/**默认的颜色**/
@property (nonatomic, copy) NSString *defaultColor;
/**字体大小设置**/
@property (nonatomic, assign) NSInteger fontSize;


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
//PopularTopFixedNavView *ppView = [[PopularTopFixedNavView alloc]initWithDataArray:@[@"fasfd",@"fasdfa"] withFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
//ppView.selectedColor = themeColor;
//self.ppView = ppView;
//ppView.defaultColor = @"000000";
//ppView.fontSize = 17;
//ppView.SelectedBlock = ^(NSInteger number) {
//    NSLog(@"%d点击的第几个",number);
//};
//[self.view addSubview:ppView];
//
//方法调用：
//if (i > 3) {
//    [self.ppView seletedHighlightItem:1];
//} else {
//    [self.ppView seletedHighlightItem:0];
//}

