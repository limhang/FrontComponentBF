
#import "PopularTopCustomNavView.h"
@interface PopularTopCustomNavView()
/**item个数**/
@property (nonatomic, assign) NSInteger itemNum;
/**横向item个数**/
@property (nonatomic, assign) NSInteger horioncalNum;
/**纵向item个数**/
@property (nonatomic, assign) NSInteger verticalNum;
/**每个item的宽度**/
@property (nonatomic, assign) CGFloat itemWidth;
/**每个item的高度**/
@property (nonatomic, assign)  CGFloat itemHeight;
/**展示用的UICollecttionView**/
@property (nonatomic, strong) UICollectionView *mainCollectionView;
/**展示item数组**/
@property (nonatomic, copy) NSArray *itemViewArray;

///**导航条**/
//@property (nonatomic, strong) UIView *lineView;
/**第一次显示的时候高亮第一个判断**/
//@property (nonatomic, assign) BOOL firstItemHightlight;
@end

@implementation PopularTopCustomNavView
- (instancetype)initWithFrame:(CGRect)Frame itemViewArray:(NSArray *)itemViewArray numberOfHorizontal:(NSInteger)horiontalNum{
    self = [super initWithFrame:Frame];
    if (self) {
        self.dataSource = itemViewArray;
        self.itemNum = itemViewArray.count;
        self.itemViewArray = itemViewArray;
        self.horioncalNum = horiontalNum;
        self.verticalNum = (self.itemNum % self.horioncalNum) == 0 ? (self.itemNum / self.horioncalNum) : (self.itemNum / self.horioncalNum) + 1;
        self.itemWidth = Frame.size.width / horiontalNum;
        if (self.verticalNum == 0) {
            self.itemHeight = Frame.size.height;
        } else {
            self.itemHeight = Frame.size.height / self.verticalNum;
        }
        //创建视图
        for (NSInteger k = 0; k < self.itemNum; k++) {
            [self addSubview:itemViewArray[k]];

        }
        //创建视图Frame约束和点击事件
        [self setupUIViews];
    }
    return self;
}

#pragma mark - private methods
- (void)setupUIViews {
    for (NSInteger i = 0; i < self.itemNum ; i++) {
        self.subviews[i].frame = CGRectMake((i % self.horioncalNum) * self.itemWidth, (i / self.horioncalNum) * self.itemHeight, self.itemWidth, self.itemHeight);
        //创建点击事件
        self.userInteractionEnabled = YES;
        UIView *subView = self.subviews[i];
        subView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSubView:)];
        subView.tag = 1000 + i;
        [subView addGestureRecognizer:tap];
    }
}

//点击某个item触发事件
- (void)tapSubView:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - 1000;
    if (self.tapItemViewBlock) {
        self.tapItemViewBlock(index);
    }
}

@end
