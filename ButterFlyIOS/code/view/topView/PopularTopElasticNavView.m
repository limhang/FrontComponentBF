//
//  PopularTopElasticNavView.m
//  PhotoTutorial
//
//  Created by het on 2017/11/6.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import "PopularTopElasticNavView.h"
//#define SCREENWW  ([UIScreen mainScreen].bounds.size.width)
static const CGFloat lineHeight = 2; //下方导航线条高度
static const CGFloat animateTime = 0.3; //下方导航线条滑动的速度
static const CGFloat itemSpace = 10; //每个item之间的间隔

@interface PopularTopElasticNavView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**item个数**/
@property (nonatomic, assign) NSInteger itemNum;
/**高亮item的buff**/
@property (nonatomic, strong) UILabel *buffItemLab;
/**每个Lab的高度**/
@property (nonatomic, assign)  CGFloat LabHeight;
/**数据源**/
@property (nonatomic, copy) NSArray *dataItems;
/**展示用的UICollecttionView**/
@property (nonatomic, strong) UICollectionView *mainCollectionView;
/**选中item的buff**/
@property (nonatomic, strong) PopularTopElasticNavViewCC *buffCell;
/**导航条**/
@property (nonatomic, strong) UIView *lineView;
/**第一次显示的时候高亮第一个判断**/
@property (nonatomic, assign) BOOL firstItemHightlight;
/**解决选中点击时候，scollview控制下的lineview动画消失的问题**/
@property (nonatomic, assign) BOOL lineViewBool;
/**最下方，灰色的线条，和系统线条颜色保持一致**/
@property (nonatomic, strong) UIView *grayLine;

@end

@implementation PopularTopElasticNavView

- (instancetype)initWithDataArray:(NSArray *)dataArray withFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //构建基本的ui
        self.dataItems = dataArray;
        self.itemNum = self.dataItems.count;
        self.LabHeight = self.frame.size.height;
        self.firstItemHightlight = YES;
        [self addSubview:self.mainCollectionView];
        [self addSubview:self.lineView];
        //最下方很细的灰线条，颜色和系统的保持一致
        [self addSubview:self.grayLine];
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
    CGFloat titleWidth = [self.dataItems[indexPath.row] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize ? self.fontSize : 14]} context:nil].size.width;
    return CGSizeMake(titleWidth + itemSpace, self.LabHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopularTopElasticNavViewCC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dependencyCC" forIndexPath:indexPath];
    if (self.firstItemHightlight && indexPath.row == 0) {
        cell.itemWordLabel.textColor = [UIColor colorWithHex:self.defaultColor ? self.defaultColor : @"000000"];
        self.buffCell = cell;
        self.lineView.backgroundColor = [UIColor colorWithHex:self.selectedColor ? self.selectedColor : @"000000"];
        self.lineView.frame = CGRectMake(0, self.frame.size.height - lineHeight, cell.frame.size.width, lineHeight);
    }
    cell.itemWordLabel.font = [UIFont systemFontOfSize:self.fontSize ? self.fontSize : 14];
    cell.itemWordLabel.textColor = [UIColor colorWithHex:self.defaultColor ? self.defaultColor : @"000000"];
    cell.itemWordLabel.text = self.dataItems[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //首先清空之前选中的cell，然后高亮主题色
    self.buffCell.itemWordLabel.textColor = [UIColor colorWithHex:self.defaultColor ? self.defaultColor : @"000000"];
    PopularTopElasticNavViewCC *cell = (PopularTopElasticNavViewCC *)[collectionView cellForItemAtIndexPath:indexPath];
    self.buffCell = cell;
    
    self.buffCell.itemWordLabel.textColor = [UIColor colorWithHex:self.selectedColor ? self.selectedColor : @"000000"];
    //逻辑处理部分
    if (self.SelectedBlock) {
        self.SelectedBlock(indexPath.row);
    }
    //移动下方导航条
    self.lineViewBool = YES;
    [self moveLineViewFrame:indexPath.row];
}

//手动拖动UICollectionView，下方导航线也跟着动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.lineViewBool) {
        
    } else {
        self.lineView.frame = CGRectMake(self.buffCell.frame.origin.x - self.mainCollectionView.contentOffset.x, self.frame.size.height - lineHeight, self.buffCell.frame.size.width, lineHeight);
    }
}

#pragma mark - private methods
//被动切换高亮item
- (void)seletedHighlightItem:(NSInteger)number {
    //首先清空之前选中的cell，然后高亮主题色
    self.buffCell.itemWordLabel.textColor = [UIColor colorWithHex:self.defaultColor ? self.defaultColor : @"000000"];
    PopularTopElasticNavViewCC *cell = (PopularTopElasticNavViewCC *)[self.mainCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:number inSection:0]];
    self.buffCell = cell;
    self.buffCell.itemWordLabel.textColor = [UIColor colorWithHex:self.selectedColor ? self.selectedColor : @"000000"];
    //移动下方导航条
    self.lineViewBool = YES;
    [self moveLineViewFrame:number];
}

//移动下方导航栏
- (void)moveLineViewFrame:(NSInteger)index {
    PopularTopElasticNavViewCC *cell = (PopularTopElasticNavViewCC *)[self.mainCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGFloat choseCellLocation = cell.frame.origin.x;
    /**重定位cell,主要注意以下原则，最左侧，最右侧两种极端情况，直接接contentoffset放在最左最右，其他情况如果超过一半屏幕，居中显示cell，详细见注释**/
    if (choseCellLocation < SCREEN_WIDTH / 2) { //最左侧的情况
        self.mainCollectionView.contentOffset = CGPointMake(0, 0);
    } else if ((self.mainCollectionView.contentSize.width - choseCellLocation) < SCREEN_WIDTH / 2) { //最右侧的情况
        self.mainCollectionView.contentOffset = CGPointMake(self.mainCollectionView.contentSize.width - SCREEN_WIDTH, 0);
    } else { //将cell居中的情况
        CGFloat offDistance = choseCellLocation - SCREEN_WIDTH / 2; //本身的frame数值减去一半的屏幕就是多出中心点的长度，也是需要contentoffsit需要移动的长度
        self.mainCollectionView.contentOffset = CGPointMake(offDistance, 0);
    }
    [UIView animateWithDuration:animateTime animations:^{
        self.lineView.frame = CGRectMake(cell.frame.origin.x - self.mainCollectionView.contentOffset.x, self.frame.size.height - lineHeight, cell.frame.size.width, lineHeight);
    } completion:^(BOOL finished) {
        self.lineViewBool = NO;
    }];
}


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
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerClass:[PopularTopElasticNavViewCC class] forCellWithReuseIdentifier:@"dependencyCC"];
    }
    return _mainCollectionView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - lineHeight, 0, lineHeight)];
    }
    return _lineView;
}

- (UIView *)grayLine {
    if (!_grayLine) {
        _grayLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
        _grayLine.backgroundColor = [UIColor colorWithHex:@"dcdcdc"];
    }
    return _grayLine;
}

@end

@implementation PopularTopElasticNavViewCC

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.itemWordLabel];
    }
    return self;
}

- (UILabel *)itemWordLabel {
    if (!_itemWordLabel) {
        _itemWordLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemSpace / 2, 0, self.frame.size.width - itemSpace, self.frame.size.height)];
        _itemWordLabel.textColor = [UIColor clearColor];
        _itemWordLabel.font = [UIFont systemFontOfSize:14];
        _itemWordLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _itemWordLabel;
}

@end


