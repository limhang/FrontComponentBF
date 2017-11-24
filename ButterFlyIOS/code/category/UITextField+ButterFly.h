/*
 Name: UITextField (ButterFly)
 Version: 0.0.1
 Created by jacob on 2017/11/9
 简介：UITextField分类，1.实现最大字符限制。2.实现去掉emoji表情，都是通过属性值控制的，BL是ButterFly的缩写
 功能：{
 输入端(主动)：暂无
 输出端(被动)：暂无
 }
 依赖的文件：暂无
 【注意事项】：
 1.由于text赋值特性，导致如果想要让textFieldChanged方法，在uitextfiled刚初始化的时候就被用上，必须对uitextfeild的text属性赋值，如果真没有值给的话，可以为xxx.text = @"" -- 【这个可以算是bug】
 2.emoji输入时候，光标偏移，这个问题，已经解决，见实现文件
 */

#import <UIKit/UIKit.h>

@interface UITextField (ButterFly)
//////////////////////////////////====初始化====//////////////////////////////////
//该分类，采用实现(点m)文件，重写load的方式，完成初始化配置，本身不做便捷初始化重写

//////////////////////////////////====属性配置====//////////////////////////////////
/**最大字符串**/
@property (nonatomic, assign)NSInteger BLMaxlength;
/**是否支持emoji表情**/
@property (nonatomic, assign)BOOL BLemojiEnable;

//////////////////////////////////====方法调用====//////////////////////////////////
/**暂无**/
@end


//使用说明：
//初始化：
//self.xxtextFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 200, 200, 80)];
//self.xxtextFiled.backgroundColor = [UIColor blueColor];
//self.xxtextFiled.text = @"";
//self.xxtextFiled.BLMaxlength = 10;
//self.xxtextFiled.BLemojiEnable = NO;
//[self.view addSubview:self.xxtextFiled];

