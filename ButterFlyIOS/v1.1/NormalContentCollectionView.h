/*
 Name: NormalContentCollectionView.h
 Version: 0.0.1
 Created by jacob on 2017/12/18
 简介：多屏展示的内容容器，容器使用的collectionView，每一屏宽度为屏幕宽度，高度位置自定义
 功能：{
 输入端(被动)：1、每屏的item(collectionView的cell)；2、外界选中某一屏(index指向位置)
 输出端(主动)：每次屏幕切换，传递出该屏所在index
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>
typedef void(^SelectedItemBlock)(NSInteger selectedNum);
@interface NormalContentCollectionView : UIView
/**初始化方法，传入需要展示的多屏数组(传入collectionView的cell类名)**/
- (instancetype)initWithDataArray:(NSArray *)contentClassNameArray withFrame:(CGRect)frame;

//////////////////////////////////====属性设计====//////////////////////////////////
/**容器是否可以左右滑动(只能依靠外界控制屏显) -- 默认支持**/
@property (nonatomic, assign) BOOL enableLeftRightScroll;

//////////////////////////////////====方法调用====//////////////////////////////////
/**主动输入当前选中的item**/
@property (nonatomic, copy) SelectedItemBlock SelectedBlock;
/**被动修改选中某个item**/
- (void)seletedHighlightItem:(NSInteger)number;
@end


//使用例子
//初始设置：
//- (NormalContentCollectionView *)BFcontentView {
//    if (!_BFcontentView) {
//        __weak __typeof(self)weakSelf = self;
//        _BFcontentView = [[NormalContentCollectionView alloc]initWithDataArray:@[[MPmodelProcess class],[MPhistoryRecord class]] withFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
//        _BFcontentView.enableLeftRightScroll = NO;
//        _BFcontentView.SelectedBlock = ^(NSInteger selectedNum) {
//            [weakSelf.ppView seletedHighlightItem:selectedNum];
//        };
//    }
//    return _BFcontentView;
//}

//方法调用：
//[weakSelf.BFcontentView seletedHighlightItem:number];


