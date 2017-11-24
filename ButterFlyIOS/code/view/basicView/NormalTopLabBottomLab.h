/*
 Name: NormalTopImgBottomLab.h
 Version: 0.0.2
 Created by jacob on 2017/11/7
 简介：通用展示View,上方是img，下方是label，frame动态可配置
 关于label显示分类：1、单行(满显省略号都一样),2、多行(动态满显，高度外边计算),3、多行固定行数
 总结label分类，下面配置属性中，可归纳为2种，1、单行和固定行数可归一类，传行数，满了用省略号，2、多行动态为一类，外面设置好frame后，无需其他配置（默认）
 功能：{
 输入端(主动)：暂无
 输出端(被动)：暂无
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>

@interface NormalTopLabBottomLab : UIView
//////////////////////////////////====初始化====//////////////////////////////////
- (instancetype)initWithFrame:(CGRect)frame withTopLabFrame:(CGRect)topLabFrame withBottomLabelFrame:(CGRect)bottomLabelFrame;

//////////////////////////////////====属性配置====//////////////////////////////////
/**topLab**/
@property (nonatomic, strong) UILabel *topLab;
/**bottomlabel**/
@property (nonatomic, strong) UILabel *bottomLab;
/**topLab字体**/
@property (nonatomic, assign) NSInteger topLabFont;
/**topLab颜色**/
@property (nonatomic, copy) NSString *topLabTextcolor;
/**bottomLab字体**/
@property (nonatomic, assign) NSInteger bottomLabFont;
/**bottomLab颜色**/
@property (nonatomic, copy) NSString *bottomLabTextcolor;
/**上部，固定单行或者多行固定**/
@property (nonatomic, assign) NSInteger topLabLine;
/**下部，固定单行或者多行固定**/
@property (nonatomic, assign) NSInteger bottomLabLine;
/**上部，文字内容**/
@property (nonatomic, copy) NSString *topTextInfo;
/**下部，文字内容**/
@property (nonatomic, copy) NSString *bottomTextInfo;
//////////////////////////////////====方法调用====//////////////////////////////////
@end

//使用说明
//初始化：
//- (NormalTopLabBottomLab *)topBottomLab {
//    if (!_topBottomLab) {
//        _topBottomLab = [[NormalTopLabBottomLab alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) withTopLabFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) withBottomLabelFrame:CGRectMake(0, 40, SCREEN_WIDTH, 60)];
//    }
//    return _topBottomLab;
//}

//默认模式下的配置【多行动态】：
//- (void)topLabBottomDefaultSetting {
//    NSString *topMessage = [NSString stringWithFormat:@"Q: %@",@"市场上有各类不同的减肥理念、减肥产品，请审慎选择。过度、过快减肥会对身体有不良影响。采纳科学的正确的减肥方式，警惕对于假设阶段、未经证明的减肥观念"];
//    self.topBottomLab.topTextInfo = topMessage;
//    NSString *bottomMessage = [NSString stringWithFormat:@"A: %@",@"首先应控制饮食，将摄入的能量总量限制在1000-1500kcal/天，减少脂肪摄入，脂肪摄入量应为总能量的25%-35%，饮食中富含水果和蔬菜、膳食纤维；以瘦肉和植物蛋白作为蛋白源。减肥膳食中应有充足的优质蛋白质，除了补充必要的营养物质，还需要补充必要的维生素、矿物质及充足的水分。还要改变饮食习惯，在吃东西时需要细嚼慢咽，这样可以减慢营养物质吸收，控制能量摄入。饮食控制目标是每月体重下降控制在0.5～1公斤左右，6个月体重下降7-8%。肥胖患者最好在专门的营养师指导下制定严格的饮食计划。"];
//    self.topBottomLab.bottomTextInfo = bottomMessage;
//    //配置
//    self.topBottomLab.topLabFont = 14;
//    self.topBottomLab.bottomLabFont = 16;
//    self.topBottomLab.topLabTextcolor = themeColor;
//    self.topBottomLab.bottomLabTextcolor = titleColor;
//    //设置label左右两边的间距
//    CGFloat labelBorderSpace = 10;
//    //计算lable的高度
//    CGFloat topLabheight = [topMessage boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - labelBorderSpace * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//    CGFloat bottomLabheight = [bottomMessage boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - labelBorderSpace * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
//    //设置2个Label的间距
//    CGFloat topBottomSpace = 10;
//    self.topBottomLab.frame = CGRectMake(0, 0, SCREEN_WIDTH, topLabheight + bottomLabheight + topBottomSpace);
//    self.topBottomLab.topLab.frame = CGRectMake(labelBorderSpace, 0,SCREEN_WIDTH - labelBorderSpace * 2, topLabheight);
//    self.topBottomLab.bottomLab.frame = CGRectMake(labelBorderSpace, topLabheight + topBottomSpace, SCREEN_WIDTH - labelBorderSpace * 2, bottomLabheight);
//}

//单行和固定行数可归一类，传行数，满了用省略号【单行固定多行】：
//- (void)topLabBottomSetting {
//    NSString *topMessage = [NSString stringWithFormat:@"Q: %@",@"市的减肥观念"];
//    self.topBottomLab.topTextInfo = topMessage;
//    NSString *bottomMessage = [NSString stringWithFormat:@"A: %@",@"首先应控制饮食，将摄入的能量总量限制在1000-1500kcal/天，减少脂肪摄入，脂肪摄入量应为总能量的25%-35%，饮食中富含水果和蔬菜、膳食纤维；以瘦肉和植物蛋白作为蛋白源。减肥膳食中应有充足的优质蛋白质，除了补充必要的营养物质，还需要补充必要的维生素、矿物质及充足的水分。还要改变饮食习惯，在吃东西时需要细嚼慢咽，这样可以减慢营养物质吸收，控制能量摄入。饮食控制目标是每月体重下降控制在0.5～1公斤左右，6个月体重下降7-8%。肥胖患者最好在专门的营养师指导下制定严格的饮食计划。"];
//    self.topBottomLab.bottomTextInfo = bottomMessage;
//    //配置
//    self.topBottomLab.topLabFont = 14;
//    self.topBottomLab.bottomLabFont = 14;
//    self.topBottomLab.topLabTextcolor = themeColor;
//    self.topBottomLab.bottomLabTextcolor = titleColor;
//    self.topBottomLab.topLabLine = 1;
//    self.topBottomLab.bottomLabLine = 4;
//    //设置label左右两边的间距
//    CGFloat labelBorderSpace = 10;
//    //计算lable的高度
//    CGFloat lineOne = [@"我是单行" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - labelBorderSpace * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//    //设置2个Label的间距
//    CGFloat topBottomSpace = 10;
//    self.topBottomLab.frame = CGRectMake(0, 0, SCREEN_WIDTH, lineOne * 1 + lineOne * 4 + topBottomSpace);
//    self.topBottomLab.topLab.frame = CGRectMake(labelBorderSpace, 0,SCREEN_WIDTH - labelBorderSpace * 2, lineOne * 1);
//    self.topBottomLab.bottomLab.frame = CGRectMake(labelBorderSpace, lineOne * 1 + topBottomSpace, SCREEN_WIDTH - labelBorderSpace * 2,  lineOne * 4);
//}

//一个猜想验证【多行就是单行乘以行数--证明如下，结果是对的】
//     CGFloat lineOne = [@"我是单行" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - labelBorderSpace * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//     CGFloat lineTwo = [@"市场上有各类不同的减肥理念、减肥产品，请审慎选择。过度、过快" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - labelBorderSpace * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//     CGFloat lineThree = [@"市场上有各类不同的减肥理念、减肥产品，请审慎选择。过度、过快减肥会对身体有不良影响。采纳科学的正确的减肥方式，警惕" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - labelBorderSpace * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//     CGFloat lineFour = [@"市场上有各类不同的减肥理念、减肥产品，请审慎选择。过度、过快减肥会对身体有不良影响。采纳科学的正确的减肥方式，警惕对于假设阶段、未经证明的减肥观念" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - labelBorderSpace * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
//     NSLog(@"一行的高度是：%lf,二行的高度是：%lf,二行的高度是：%lf,二行的高度是：%lf",lineOne,lineTwo,lineThree,lineFour);
//     2017-11-07 16:53:26.356 PhotoTutorial[7516:1294174] 一行的高度是：16.707031,二行的高度是：33.414062,三行的高度是：50.121094,四行的高度是：66.828125
