/*
 Name: NormalTopImgBottomLab.h
 Version: 0.0.1
 Created by jacob on 2017/11/7
 简介：通用展示View,上方是img，下方是label，frame动态可配置
 功能：{
 输入端(主动)：点击事件可传出
 输出端(被动)：暂无
 }
 依赖的文件：暂无
 */

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TopImgBottomLabStatus) {
    TopImgBottomLabNormal = 1,
    TopImgBottomLabSelected = 2
};
typedef void(^TopImgBottomLabDrivingBlock) (TopImgBottomLabStatus status);
@interface NormalTopImgBottomLab : UIView
//////////////////////////////////====初始化====//////////////////////////////////
- (instancetype)initWithFrame:(CGRect)frame withImageFrame:(CGRect)imageFrame withLabelFrame:(CGRect)labelFrame;

//////////////////////////////////====属性配置====//////////////////////////////////
/**image**/
@property (nonatomic, strong) UIImageView *topImage;
/**label**/
@property (nonatomic, strong) UILabel *bottomLabel;
/**正常显示图片**/
@property (nonatomic, copy) NSString *defaultImageUrl;
/**选中显示图片**/
@property (nonatomic, copy) NSString *selectedImageUrl;
/**正常显示文字颜色**/
@property (nonatomic, copy) NSString *defaultTextColor;
/**正常显示文字字体**/
@property (nonatomic, assign) NSInteger defaultTextFont;
/**选中显示文字字体**/
@property (nonatomic, assign) NSInteger selectedTextFont;
/**文字内容**/
@property (nonatomic, copy) NSString *textInfo;
//////////////////////////////////====方法调用====//////////////////////////////////
/**主动输入点击事件**/
@property (nonatomic, copy) TopImgBottomLabDrivingBlock tapViewBlock;
@end

//使用说明
//- (NormalTopImgBottomLab *)xxview {
//    if (!_xxview) {
//        __weak typeof(self) weakSelf = self;
//        _xxview = [[NormalTopImgBottomLab alloc]initWithFrame:CGRectMake(0, 200, 60, 100) withImageFrame:CGRectMake(5, 5, 50, 50) withLabelFrame:CGRectMake(5, 60, 50, 40)];
//        _xxview.defaultImageUrl = @"default_200";
//        _xxview.defaultTextColor = themeColor;
//        _xxview.defaultTextFont = 15;
//        _xxview.textInfo = @"问号";
//        _xxview.tapViewBlock = ^(TopImgBottomLabStatus status) {
//            if (status == TopImgBottomLabNormal) {
//                weakSelf.xxview.defaultTextFont = 15;
//                weakSelf.xxview.defaultImageUrl = @"default_200";
//            } else if (status == TopImgBottomLabSelected) {
//                weakSelf.xxview.selectedTextFont = 17;
//                weakSelf.xxview.selectedImageUrl = @"icon_video";
//            }
//        };
//    }
//}

