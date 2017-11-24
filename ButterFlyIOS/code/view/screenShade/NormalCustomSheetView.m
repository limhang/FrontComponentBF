//在写这个组件的时候，我没有使用对象方法，用alloc，initwithFrame创建，是因为，这个组件不需要知道frame值，大家仔细想下，对于不需要设置frame值
//的组件，系统是不是都是直接提供类方法

//在写这个组件过程中，学习到了，传递对象名，实例化对象的方式，类似于UITableView
//学习了keywindow添加的移除子组件的方式
//学习了类方法实例的技巧

#import "NormalCustomSheetView.h"
static const CGFloat backgroundAlpha = 0.3;
static const CGFloat animateAppearTime = 0.3;
static const CGFloat animateDisappearTime = 0.1;
@interface NormalCustomSheetView()
/**放置item的容器,contentView**/
@property (nonatomic, strong) UIView *BFcontentView;
/**底部空白条view**/
@property (nonatomic, strong) UIView *bottomItemSpaceView;
/**item高度**/
@property (nonatomic, assign) CGFloat itemHeight;
/**底部2个item之间的间隔**/
@property (nonatomic, assign) CGFloat spaceHeight;

@end

@implementation NormalCustomSheetView

//这个地方有点特殊，我们是需要使用sheet，而不是self，这是类方法和实例方法初始化的区别，这个记住
+ (instancetype)customSheetWithItemClass:(Class)class numberOfItems:(NSInteger)number itemHeight:(CGFloat)itemHeight bottomItemsSpace:(CGFloat)spaceHeight {
    NormalCustomSheetView *sheet = [NormalCustomSheetView new];
    //主界面frame设置
    sheet.itemHeight = itemHeight; //每个item的高度
    sheet.spaceHeight = spaceHeight; //最下面2个item的间隔
    sheet.backgroundColor = [UIColor colorFromHexRGB:@"101010" alpha:backgroundAlpha]; //背景色
//    sheet.alpha = backgroundAlpha; //透明度
    [sheet setupMainFrame]; //创建主界面的frame
    
    //创建主界面的点击事件，点击消失视图
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:sheet action:@selector(contentViewdisapperar)];
    sheet.userInteractionEnabled = YES;
    [sheet addGestureRecognizer:tap];
    
    //创建contentView(初始加载应该位于屏幕下方，看不见)，是所有item的父视图
    sheet.BFcontentView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, (itemHeight * number + spaceHeight))];
    [sheet addSubview:sheet.BFcontentView];
    sheet.itemsArray = [NSMutableArray new];
    //加载item到父视图上
    for (NSInteger i = 0; i < number; i++) {
        id item;
        if (i == 0) {
            item = [[class alloc]initWithFrame:CGRectMake(0, (itemHeight * number + spaceHeight) - (i+1) * itemHeight, [UIScreen mainScreen].bounds.size.width, itemHeight)];
        //有间隔线，非底部第一个item，其frame的起始点要加上spaceHeight
        } else {
            item = [[class alloc]initWithFrame:CGRectMake(0, itemHeight * number + spaceHeight - (i+1) * itemHeight - spaceHeight, [UIScreen mainScreen].bounds.size.width, itemHeight)];
        }
        //将item对象暂存在itemArray属性上
        [sheet.itemsArray addObject:item];
        //将item视图加到contentView上
        [sheet.BFcontentView addSubview:item];
        //对每个item设置一个点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:sheet action:@selector(didSelectItem:)];
        sheet.BFcontentView.subviews[i].userInteractionEnabled = YES;
        sheet.BFcontentView.subviews[i].tag = 666 + i;
        [sheet.BFcontentView.subviews[i] addGestureRecognizer:tap];
    }
    //设置底部item之间space的视图
    sheet.bottomItemSpaceView = [[UIView alloc]initWithFrame:CGRectMake(0, itemHeight * (number-1), [UIScreen mainScreen].bounds.size.width, spaceHeight)];
    sheet.bottomItemSpaceView.userInteractionEnabled = YES;
    UITapGestureRecognizer *spaceTap = [[UITapGestureRecognizer alloc]initWithTarget:sheet action:@selector(spaceViewTap)];
    [sheet.bottomItemSpaceView addGestureRecognizer:spaceTap];
    [sheet.BFcontentView addSubview:sheet.bottomItemSpaceView];
    
    //加载界面到keyWindow上
    [sheet allViewloadKeyWindow:YES];
    //做动画，将contentView动态显示出来
    [sheet contentViewAppearAnimate];
    return sheet;
}

#pragma mark - setters and getters
//设置spaceView的颜色
- (void)setSpaceViewColor:(NSString *)spaceViewColor {
    self.bottomItemSpaceView.backgroundColor = [UIColor colorWithHex:spaceViewColor];
}

//点击spaceView的视图响应
- (void)spaceViewTap {
    
}

//动画效果调整contentview的显示frame
- (void)contentViewAppearAnimate {
    [UIView animateWithDuration:animateAppearTime animations:^{
        //动画效果做contentView的frame
        self.BFcontentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - (self.itemHeight * self.itemsArray.count + self.spaceHeight), [UIScreen mainScreen].bounds.size.width, (self.itemHeight * self.itemsArray.count + self.spaceHeight));
    } completion:^(BOOL finished) {

    }];
}

//动画效果销毁contentView
- (void)contentViewdisapperar {
    [UIView animateWithDuration:animateDisappearTime animations:^{
        //动画效果做contentView的frame
        self.BFcontentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, (self.itemHeight * self.itemsArray.count + self.spaceHeight));
    } completion:^(BOOL finished) {
        //撤掉keywindow上的子视图
        [self allViewloadKeyWindow:NO];
    }];
}

//用来【加载】或者【销毁】，存在于keywindow上的视图
- (void)allViewloadKeyWindow:(BOOL)load {
    if (load) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.tag = 1000;
    } else {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1000] removeFromSuperview];
    }
}

//整个view的frame
- (void)setupMainFrame {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

//传出每个点击事件
- (void)didSelectItem:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - 666;
    if (self.didSelectIndexBlock) {
        self.didSelectIndexBlock(index);
    }
}

- (void)dealloc {
    NSLog(@"__%s",__func__);

}

@end
