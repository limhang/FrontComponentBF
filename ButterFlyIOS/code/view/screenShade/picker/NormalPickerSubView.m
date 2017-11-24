//
//  NormalPickerSubView.m
//  PhotoTutorial
//
//  Created by het on 2017/11/14.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import "NormalPickerSubView.h"
static const CGFloat subviewPickerViewHeight = 150;
static const CGFloat subviewSubmitViewHeight = 60; //2者相加的高度应该和传入的frame高度一致
@interface NormalPickerSubView()<UIPickerViewDelegate,UIPickerViewDataSource>
/**选中操作的视图【默认就是红色条，自定义】**/
@property (nonatomic, strong) UIView *submitView;
/**选中操作的数据**/
@property (nonatomic, copy) NSString *submitString;
/**单位label**/
@property (nonatomic, strong) UILabel *unitLabel;

@end

@implementation NormalPickerSubView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickerView];
        [self addSubview:self.submitView];
        [self addSubview:self.unitLabel];
    }
    return self;
}

#pragma mark - setters and getters
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, subviewSubmitViewHeight, [UIScreen mainScreen].bounds.size.width, subviewPickerViewHeight)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIView *)submitView {
    if (!_submitView) {
        _submitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, subviewSubmitViewHeight)];
        _submitView.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTap)];
        _submitView.userInteractionEnabled = YES;
        [_submitView addGestureRecognizer:tap];
    }
    return _submitView;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        CGFloat frameX = ([UIScreen mainScreen].bounds.size.width / 2) + (subviewSubmitViewHeight / 2) + 8; //8为unitLabel和选中item横向间隔
        CGFloat frameY = subviewSubmitViewHeight + (subviewPickerViewHeight / 2) - 15; //30为unitLabel的高度
        _unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(frameX, frameY, 200, (subviewSubmitViewHeight / 2))];
        _unitLabel.font = [UIFont systemFontOfSize:15];
        _unitLabel.textColor = [UIColor colorWithHex:themeColor];
    }
    return _unitLabel;
}

//单位文字内容设置
- (void)setUnitLabelText:(NSString *)unitLabelText {
    self.unitLabel.text = unitLabelText;
}

#pragma mark - private methods
- (void)chooseTap {
    //选中某个滑轮的回调
    if (self.chooseBlock) {
        //进行了选择，常规情况
        if (self.submitString.length > 0) {
            self.chooseBlock(self.submitString);
            //未进行选择，直接点击的确定
        } else {
            self.chooseBlock(self.pickerViewDataSource[0]);
        }
    }
    //销毁整个遮罩view
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
}

#pragma mark - UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerViewDataSource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 60;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerViewDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.submitString = self.pickerViewDataSource[row];
}


- (void)dealloc {
    NSLog(@"__%s",__func__);
}

@end
