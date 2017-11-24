/*
 Name: NormalLeftLabRightLab.h
 Version: 0.0.1
 Created by jacob on 2017/11/7
 简介：通用展示View,上方是lab，下方是label，frame动态可配置
 关于label显示分类：1、单行(满显省略号都一样),2、多行(动态满显，高度外边计算),3、多行固定行数
 总结label分类，下面配置属性中，可归纳为2种，1、单行和固定行数可归一类，传行数，满了用省略号，2、多行动态为一类，外面设置好frame后，无需其他配置（默认）
 功能：{
 输入端(主动)：暂无
 输出端(被动)：暂无
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>

@interface NormalLeftLabRightLab : UIView
//////////////////////////////////====初始化====//////////////////////////////////
- (instancetype)initWithFrame:(CGRect)frame withLeftLabFrame:(CGRect)leftLabFrame withRightLabelFrame:(CGRect)rightLabelFrame;

//////////////////////////////////====属性配置====//////////////////////////////////
/**leftLab**/
@property (nonatomic, strong) UILabel *leftLab;
/**rightlabel**/
@property (nonatomic, strong) UILabel *rightLab;
/**leftLab字体**/
@property (nonatomic, assign) NSInteger leftLabFont;
/**leftLab颜色**/
@property (nonatomic, copy) NSString *leftLabTextcolor;
/**rightLab字体**/
@property (nonatomic, assign) NSInteger rightLabFont;
/**rightLab颜色**/
@property (nonatomic, copy) NSString *rightLabTextcolor;
/**上部，固定单行或者多行固定**/
@property (nonatomic, assign) NSInteger leftLabLine;
/**下部，固定单行或者多行固定**/
@property (nonatomic, assign) NSInteger rightLabLine;
/**上部，文字内容**/
@property (nonatomic, copy) NSString *leftTextInfo;
/**下部，文字内容**/
@property (nonatomic, copy) NSString *rightTextInfo;
//////////////////////////////////====方法调用====//////////////////////////////////
@end

//使用说明：
//初始化：
//- (NormalLeftLabRightLab *)xxview {
//    if (!_xxview) {
//        _xxview = [[NormalLeftLabRightLab alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50) withLeftLabFrame:CGRectMake(0, 0, 100, 50) withRightLabelFrame:CGRectMake(100, 0, 100, 50)];
//    }
//    return _xxview;
//}
//配置：
//- (void)topLabBottomDefaultSetting {
//    NSString *leftMessage = [NSString stringWithFormat:@"%@",@"各念"];
//    self.xxview.leftTextInfo = leftMessage;
//    NSString *rightMessage = [NSString stringWithFormat:@"%@",@"首食计划。"];
//    self.xxview.rightTextInfo = rightMessage;
//    //配置
//    self.xxview.leftLabFont = 16;
//    self.xxview.rightLabFont = 14;
//    self.xxview.leftLabTextcolor = themeColor;
//    self.xxview.rightLabTextcolor = titleColor;
//}


