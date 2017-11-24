/*
 Name: PopularTopElasticNavView.h
 Version: 0.0.1
 Created by jacob on 2017/11/4
 简介：顶部的导航，超过一个屏幕的宽度，具有有多少个item，视创建该对象参数而定，选中的item高亮底部下划线高亮，默认高亮第一个item。
 功能：{
 输入端(主动)：传出选中的item的位置，传出选中itme的事件。
 输出端(被动)：支持外部控制选中某个item高亮。
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>
typedef void(^SelectedItemBlock)(NSInteger selectedNum);
@interface PopularTopElasticNavView : UIView
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
@interface PopularTopElasticNavViewCC : UICollectionViewCell
/**居中的item文字**/
@property (nonatomic, strong) UILabel *itemWordLabel;
@end

//使用例子
//初始设置：
//- (PopularTopElasticNavView *)topElasticNavView {
//    if (!_topElasticNavView) {
//        __weak typeof(self) weakSelf = self;
//        _topElasticNavView = [[PopularTopElasticNavView alloc]initWithDataArray:@[@"器材",@"基础",@"人像",@"夜景",@"风光",@"运动",@"微距",@"闪光"] withFrame:CGRectMake(0, 64, SCREEN_WIDTH, topNavCollectionHeight)];
//        _topElasticNavView.selectedColor = themeColor;
//        _topElasticNavView.defaultColor = titleColor;
//        _topElasticNavView.fontSize = 16;
//        _topElasticNavView.SelectedBlock = ^(NSInteger selectedNum) {
//            [weakSelf.mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedNum inSection:0] atScrollPosition:0 animated:NO];
//        };
//    }
//    return _topElasticNavView;
//}
//方法调用：
//[self.topElasticNavView seletedHighlightItem:i];
//}
