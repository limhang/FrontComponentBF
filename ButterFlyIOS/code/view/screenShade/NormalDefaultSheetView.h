/*
 Name: NormalDefaultSheetView.h
 Version: 0.0.1
 Created by jacob on 2017/11/13
 简介：与NormalCustomSheetView不同，这个是默认sheet样式，底部最后一个item为红色，底部二个item之间有间隔
 功能：{
 输入端(主动)：传出选中的item的位置，传出选中itme的事件（在click回调中）
 输出端(被动)：暂无
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>

@interface NormalDefaultSheetView : UIView
//////////////////////////////////====初始化====//////////////////////////////////
+(instancetype)sheetCancelTitile:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)titles;

//////////////////////////////////====属性配置====//////////////////////////////////
/**最底部item的颜色**/
@property (nonatomic, copy) NSString *bottomItemColor;
/**除底部item外，其他item颜色**/
@property (nonatomic, copy) NSString *customItemColor;
/**最底部item字体**/
@property (nonatomic, assign) NSInteger bottomItemFont;
/**除底部item外，其他item字体**/
@property (nonatomic, assign) NSInteger customItemFont;

//////////////////////////////////====方法调用====//////////////////////////////////
-(void)showInView:(UIView *)view click:(void (^)(NSInteger index))click;
@end


//使用说明：
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NormalDefaultSheetView *defaultSheetView = [NormalDefaultSheetView sheetCancelTitile:@"取消" otherTitles:@[@"第一行",@"第二行",@"第三行"]];
//    defaultSheetView.customItemColor = themeColor;
//    defaultSheetView.customItemFont = 14;
//    defaultSheetView.bottomItemColor = @"000000";
//    defaultSheetView.bottomItemFont = 18;
//    [defaultSheetView showInView:self.view click:^(NSInteger index) {
//        NSLog(@"点击的%d",index);
//    }];
//}

