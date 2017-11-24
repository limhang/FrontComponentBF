/*
 Name: NormalSearchView.h
 Version: 0.0.1
 Created by jacob on 2017/11/4
 简介：通用型search框，搜索框中放大镜和叉叉图片可被替换，搜索支持字数限制
 功能：{
 输入端(主动)：点击确认按钮，给外界提供方法
 输出端(被动)：键盘的弹出和消失
 }
 依赖的文件：暂无
 */
#import <UIKit/UIKit.h>
typedef void(^DrivingBlock) ();
@interface NormalSearchView : UIView
//////////////////////////////////====初始化====//////////////////////////////////
- (instancetype)initUseDefaultMessage:(NSString *)info searchImage:(NSString *)search cancleImage:(NSString *)cancle WithFrame:(CGRect)frame;

//////////////////////////////////====属性配置====//////////////////////////////////
/**限制字数长度--可不配置走默认**/
@property (nonatomic, assign) NSInteger textLength;

//////////////////////////////////====方法调用====//////////////////////////////////
/**点击确认按钮，主动传出的事件**/
@property (nonatomic, copy) DrivingBlock searchBlock;
/**点击取消按钮，主动传输的事件**/
@property (nonatomic, copy) DrivingBlock cancelBlcok;

- (void)searchKeyboard:(BOOL)hidden;

@end

//使用例子
//初始设置：
//- (NormalSearchView *)NormalSearchView {
//    __weak typeof(self) weakSelf = self;
//    if (!_NormalSearchView) {
//        _NormalSearchView = [[NormalSearchView alloc]initUseDefaultMessage:@"请输入搜索内容" searchImage:@"title_icon_search" cancleImage:@"title_text_x" WithFrame:CGRectMake(0,0,self.view.frame.size.width,64)];
//        _NormalSearchView.backgroundColor = [UIColor colorWithHex:themeColor];
//        _NormalSearchView.searchBlock = ^{
//            NSLog(@"点击搜索");
//        };
//        _NormalSearchView.cancelBlcok = ^{
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        };
//    }
//    return _NormalSearchView;
//}
//方法调用：
//[self.NormalSearchView searchKeyboard:YES];



