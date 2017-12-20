/*
 说明具体功能设计，方便用户自己修改，原则上注释是代码量的三分一
*/

#import "PopularTopFixedNavView.h"
#import <SAMCategories.h>
#define SCREENWW  ([UIScreen mainScreen].bounds.size.width)
static const CGFloat lineHeight = 2;
static const CGFloat animateTime = 0.3;
@interface PopularTopFixedNavView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**item个数**/
@property (nonatomic, assign) NSInteger itemNum;
/**高亮item的buff**/
@property (nonatomic, strong) UILabel *buffItemLab;
/**每个Lab的宽度**/
@property (nonatomic, assign) CGFloat LabWidth;
/**每个Lab的高度**/
@property (nonatomic, assign)  CGFloat LabHeight;
/**数据源**/
@property (nonatomic, copy) NSArray *dataItems;
/**展示用的UICollecttionView**/
@property (nonatomic, strong) UICollectionView *mainCollectionView;
/**选中item的buff**/
@property (nonatomic, strong) DependencyItemCC *buffCell;
/**导航条**/
@property (nonatomic, strong) UIView *lineView;
/**第一次显示的时候高亮第一个判断**/
@property (nonatomic, assign) BOOL firstItemHightlight;


@end

@implementation PopularTopFixedNavView

- (instancetype)initWithDataArray:(NSArray *)dataArray withFrame:(CGRect)frame withFixedBottomLineWidth:(CGFloat)bottomLineWidth{
    self = [super initWithFrame:frame];
    if (self) {
        //构建基本的ui
        self.dataItems = dataArray;
        self.itemNum = self.dataItems.count;
        self.LabWidth = self.frame.size.width / self.itemNum;
        self.LabHeight = self.frame.size.height;
        if (bottomLineWidth < 1) {
            bottomLineWidth = self.LabWidth;
        }
        self.fixedWidthForBottomLine = bottomLineWidth;
        self.firstItemHightlight = YES;
        [self addSubview:self.mainCollectionView];
        [self addSubview:self.lineView];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataItems.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.LabWidth, self.LabHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DependencyItemCC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dependencyCC" forIndexPath:indexPath];
    if (self.firstItemHightlight && indexPath.row == 0) {
        cell.itemWordLabel.textColor = [UIColor sam_colorWithHex:self.defaultColor ? self.defaultColor : @"000000"];
        self.buffCell = cell;
        self.lineView.backgroundColor = [UIColor sam_colorWithHex:self.selectedColor ? self.selectedColor : @"000000"];
    }
    cell.itemWordLabel.font = [UIFont systemFontOfSize:self.fontSize ? self.fontSize : 14];
    cell.itemWordLabel.textColor = [UIColor sam_colorWithHex:self.defaultColor ? self.defaultColor : @"000000"];
    cell.itemWordLabel.text = self.dataItems[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //首先清空之前选中的cell，然后高亮主题色
    self.buffCell.itemWordLabel.textColor = [UIColor sam_colorWithHex:self.defaultColor ? self.defaultColor : @"000000"];
    DependencyItemCC *cell = (DependencyItemCC *)[collectionView cellForItemAtIndexPath:indexPath];
    self.buffCell = cell;
    
    self.buffCell.itemWordLabel.textColor = [UIColor sam_colorWithHex:self.selectedColor ? self.selectedColor : @"000000"];
    //逻辑处理部分
    if (self.SelectedBlock) {
        self.SelectedBlock(indexPath.row);
    }
    //移动下方导航条
    [UIView animateWithDuration:animateTime animations:^{
        self.lineView.frame = CGRectMake(indexPath.row * self.LabWidth + (self.LabWidth - self.fixedWidthForBottomLine) / 2, self.frame.size.height - lineHeight, self.fixedWidthForBottomLine, lineHeight);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - private methods
//被动切换高亮item
- (void)seletedHighlightItem:(NSInteger)number {
    //首先清空之前选中的cell，然后高亮主题色
    self.buffCell.itemWordLabel.textColor = [UIColor sam_colorWithHex:self.defaultColor ? self.defaultColor : @"000000"];
    DependencyItemCC *cell = (DependencyItemCC *)[self.mainCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:number inSection:0]];
    self.buffCell = cell;
    self.buffCell.itemWordLabel.textColor = [UIColor sam_colorWithHex:self.selectedColor ? self.selectedColor : @"000000"];
    //移动下方导航条
    [UIView animateWithDuration:animateTime animations:^{
        self.lineView.frame = CGRectMake(number * self.LabWidth + (self.LabWidth - self.fixedWidthForBottomLine) / 2, self.frame.size.height - lineHeight, self.fixedWidthForBottomLine, lineHeight);
    } completion:^(BOOL finished) {
    }];}

#pragma mark - setters and getters
- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //显示方向设置
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _mainCollectionView.showsHorizontalScrollIndicator = NO;  //隐藏下方滑动条
        [_mainCollectionView setBounces:NO];
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        _mainCollectionView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerClass:[DependencyItemCC class] forCellWithReuseIdentifier:@"dependencyCC"];
    }
    return _mainCollectionView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake((self.LabWidth - self.fixedWidthForBottomLine) / 2, self.frame.size.height - lineHeight, self.fixedWidthForBottomLine, lineHeight)];
    }
    return _lineView;
}



@end

@implementation DependencyItemCC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.itemWordLabel];
    }
    return self;
}

- (UILabel *)itemWordLabel {
    if (!_itemWordLabel) {
        _itemWordLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _itemWordLabel.textColor = [UIColor clearColor];
        _itemWordLabel.font = [UIFont systemFontOfSize:14];
        _itemWordLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _itemWordLabel;
}

@end
