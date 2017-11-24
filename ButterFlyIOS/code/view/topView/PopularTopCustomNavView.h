/*
 Name: PopularTopCustomNavView.h
 Version: 0.0.1
 Created by jacob on 2017/11/4
 简介：顶部的导航，自定义高宽，具有有多少个item，可多行可单行，视创建该对象参数而定，这个类和PopularTopFixedNavView主要区别是item可自定义，也非整屏
 默认隐藏部分item分割线，下方导航条
 功能：{
 输入端(主动)：传出选中的item的位置，传出选中itme的事件。
 输出端(被动)：支持外部控制选中某个item高亮。
 }
 依赖的文件：暂无
 */
#import <UIKit/UIKit.h>
typedef void(^PopularTopCustomNavDrivingBlock) (NSInteger index);
@interface PopularTopCustomNavView : UIView
//////////////////////////////////====初始化====//////////////////////////////////
- (instancetype)initWithFrame:(CGRect)Frame itemViewArray:(NSArray *)itemViewArray numberOfHorizontal:(NSInteger)horiontalNum;
//////////////////////////////////====属性配置====//////////////////////////////////
/**itemViewDataSource**/
@property (nonatomic, copy) NSArray *dataSource;

//暂时未用到的属性
/**Item分割线设置--颜色**/
@property (nonatomic, copy) NSString *seperateLineColor;
/**Item分割线设置--高度**/
@property (nonatomic, assign) NSInteger seperateLineHeight;
/**Item分割线设置--宽度**/
@property (nonatomic, assign) NSInteger seperateLineWidht;
/**下方导航条设置--颜色**/
@property (nonatomic, copy) NSString *navLineColor;
/**下发导航条设置--高度**/
@property (nonatomic, assign) NSInteger navLineHeight;
//暂时未用到的属性

//////////////////////////////////====方法调用====//////////////////////////////////
/**点击某个item,传出事件实现block**/
@property (nonatomic, copy) PopularTopCustomNavDrivingBlock tapItemViewBlock;
/**更改数据源，需要用户，手动设置【考虑再三，未用代理】**/
@end


//使用说明：【传递给容器的item，本身类似于系统cell，可做成View类后，传入，也可以简单外部处理】
//- (PopularTopCustomNavView *)customView {
//    __weak typeof(self) weakSelf = self;
//    if (!_customView) {
//////////////////////////////////====生成item内容传递给容器====//////////////////////////////////
//        NSMutableArray *datasource = [NSMutableArray new];
//        for (NSInteger i = 0; i < 7; i++) {
//            NormalResponsiveLab *view = [[NormalResponsiveLab alloc]initWithFrame:CGRectMake(0, 0, 70, 40) borderWidth:3 cornerRadius:20 borderColor:themeColor];
//            view.font = [UIFont systemFontOfSize:16];
//            view.textColor = [UIColor colorWithHex:titleColor];
//            view.backgroundColor = [UIColor colorWithHex:@"f7f7f7"];
//            view.text = @"牛肉面";
//            view.userInteractionEnabled = NO;
//            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(70, 0, 10, 40)];
//            lineView.backgroundColor = [UIColor colorWithHex:titleColor];
//            UIView *contentView = [[UIView alloc]init];
//            [contentView addSubview:view];
//            [contentView addSubview:lineView];
//            [datasource addObject:contentView];
//        }
//////////////////////////////////====初始化确定frame====//////////////////////////////////
//        _customView = [[PopularTopCustomNavView alloc]initWithFrame:CGRectMake(0, 200, 320, 80) itemViewArray:datasource numberOfHorizontal:5];
//////////////////////////////////====点击某个item回调，记得如果item本身有点击事件，则要在上一步中消除其点击事件====//////////////////////////////////
//        _customView.tapItemViewBlock = ^(NSInteger index) {
//            NSLog(@"点击了某处,%d",index);
//            if (index == 2) {
//                UIView *view = weakSelf.customView.dataSource[index];
//                NormalResponsiveLab *lab = view.subviews[0];
//                lab.text = @"哈哈";
//            }
//        };
//    }
//    return _customView;
//}


//////////////////////////////////====数据源更新，修改item显示内容====//////////////////////////////////
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    for (NSInteger i = 0 ; i < self.customView.dataSource.count; i++) {
//        UIView *view = self.customView.dataSource[i];
//        NormalResponsiveLab *lab = view.subviews[0];
//        if (i == 3) {
//            lab.text = @"肉干";
//            view.subviews[1].backgroundColor = [UIColor redColor];
//        } else {
//            lab.text = @"方便面";
//        }
//
//    }
//});

