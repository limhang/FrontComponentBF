//适用较为通用的情况，用户可定制化程度较低，只能修改每个item的颜色和字体

#import "NormalDefaultSheetView.h"
/**
 *  每一个按钮的高度
 */
static CGFloat kActionSheetHeight = 54.f;

/**
 *  动画时间
 */
static CGFloat kActionSheetTime = 0.25f;

@interface NormalDefaultSheetView(){
    UIView *_backView;
}

@property (nonatomic,copy)NSString *cancelTitle;
@property (nonatomic,copy)NSArray<NSString *> *titles;
@property (nonatomic,copy)void (^click)(NSInteger);
/**除底部item外的item集合**/
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation NormalDefaultSheetView


+(instancetype)sheetCancelTitile:(NSString *)cancelTitle otherTitles:(NSArray<NSString *> *)titles{
    NormalDefaultSheetView *sheet = [NormalDefaultSheetView new];
    sheet.cancelTitle = cancelTitle;
    sheet.titles = titles;
    sheet.dataSourceArray = [NSMutableArray new];
    [sheet initializeUIs];
    return sheet;
}
-(void)initializeUIs{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [[UIColor colorWithHex:@"000000"] colorWithAlphaComponent:0.4f];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self addGestureRecognizer:tapGesture];
    
    _backView = [UIView new];
    [self addSubview:_backView];
    
    //取消btn
    UIButton *backBtn = [UIButton new];
    [backBtn setTitle:self.cancelTitle forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithHex:@"ef4f4f"] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    backBtn.backgroundColor= [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.cancelTitle.length ==0) {
            make.top.equalTo(_backView.mas_bottom).offset(5.f);
        }else{
            make.bottom.equalTo(_backView.mas_bottom);
        }
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(@(kActionSheetHeight));
    }];
    
    for (NSInteger index =0; index <self.titles.count; index ++) {
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithHex:@"c6c6c6"];
        [_backView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(1.f/[UIScreen mainScreen].scale));
            make.left.equalTo(_backView.mas_left);
            make.right.equalTo(_backView.mas_right);
            make.bottom.equalTo(backBtn.mas_top).offset(-5.f-kActionSheetHeight*index);
        }];
        UIButton *btn = [UIButton new];
        [btn setTitle:self.titles[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.backgroundColor= [UIColor whiteColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.dataSourceArray addObject:btn];
        [_backView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_backView.mas_left);
            make.right.equalTo(_backView.mas_right);
            make.height.equalTo(@(kActionSheetHeight));
            make.bottom.equalTo(line.mas_top);
        }];
        
        if (index == self.titles.count -1) {
            [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right);
                make.left.equalTo(self.mas_left);
                make.bottom.equalTo(self.mas_bottom).offset(300.f);
                make.height.equalTo(@(300.f));
            }];
        }
    }
}

-(void)tappedCancel{
    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(300.f);
    }];
    [UIView animateWithDuration:kActionSheetTime animations:^{
        self.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)showInView:(UIView *)view click:(void (^)(NSInteger))click{
    [view.window addSubview:self];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
    }];
    //    [UIView animateWithDuration:kActionSheetTime animations:^{
    //        [self layoutIfNeeded];
    //    }];
    self.click = click;
}

-(void)btnClick:(UIButton *)btn{
    if (btn.currentTitle.length > 0 && [self.titles containsObject:btn.currentTitle] && self.click) {
        self.click([self.titles indexOfObject:btn.currentTitle]);
    }
    [self tappedCancel];
}

//颜色字体设置
- (void)setBottomItemFont:(NSInteger)bottomItemFont {
    UIButton *backBtn = _backView.subviews[0];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:bottomItemFont]];
}

- (void)setCustomItemFont:(NSInteger)customItemFont {
    for (NSInteger i =0 ; i < self.dataSourceArray.count ; i++) {
        UIButton *defaultBtn = self.dataSourceArray[i];
        [defaultBtn.titleLabel setFont:[UIFont systemFontOfSize:customItemFont]];
    }
}

- (void)setBottomItemColor:(NSString *)bottomItemColor {
    UIButton *backBtn = _backView.subviews[0];
    [backBtn setTitleColor:[UIColor colorWithHex:bottomItemColor] forState:UIControlStateNormal];
}

- (void)setCustomItemColor:(NSString *)customItemColor {
    for (NSInteger i = 0; i < self.dataSourceArray.count; i++) {
        UIButton *customBtn = self.dataSourceArray[i];
        [customBtn setTitleColor:[UIColor colorWithHex:customItemColor] forState:UIControlStateNormal];
    }
}

-(void)dealloc{
    NSLog(@"__%s",__func__);
}

@end
