//
//  NormalContentCollectionView.m
//  SoilDetector
//
//  Created by het on 2017/12/18.
//  Copyright © 2017年 kaka. All rights reserved.
//

#import "NormalContentCollectionView.h"

@interface NormalContentCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**该控件的容器，主体内容**/
@property (nonatomic, strong) UICollectionView *mainCollectionView;
/**collectionView容器高度**/
@property (nonatomic, assign) CGFloat collectionViewHeight;
/**collectionView容器y轴坐标**/
@property (nonatomic, assign) CGFloat collectionViewY;
/**容器collectionView的cell的类名**/
@property (nonatomic, copy) NSArray *collectionViewClassName;


@end

@implementation NormalContentCollectionView

- (instancetype)initWithDataArray:(NSArray *)contentClassNameArray withFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化属性值
        self.collectionViewHeight = frame.size.height;
        self.collectionViewY = frame.origin.y;
        self.collectionViewClassName = contentClassNameArray;
        [self addSubview:self.mainCollectionView];
    }
    return self;
}

#pragma mark - uicollectionView delegate && datasourceDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionViewClassName.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width, self.collectionViewHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //传递进来的cell，必须继承自uicollectionViewCell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"reused%d",indexPath.row] forIndexPath:indexPath];
    return cell;
}


//主动输出当前滚动到哪一屏
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
    if (self.SelectedBlock) {
        self.SelectedBlock(index);
    }
}

#pragma mark - setters and getters
- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //显示方向设置
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.collectionViewHeight) collectionViewLayout:layout];
        _mainCollectionView.showsHorizontalScrollIndicator = NO;  //隐藏下方滑动条
        [_mainCollectionView setBounces:NO];
        _mainCollectionView.pagingEnabled = YES;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        _mainCollectionView.contentSize = CGSizeMake(self.frame.size.width * self.collectionViewClassName.count, self.collectionViewHeight);
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        for (NSInteger i = 0; i < self.collectionViewClassName.count; i++) {
            [_mainCollectionView registerClass:self.collectionViewClassName[i] forCellWithReuseIdentifier:[NSString stringWithFormat:@"reused%d",i]];
        }
    }
    return _mainCollectionView;
}

//使能是否支持，用户手势左右切换屏显
- (void)setEnableLeftRightScroll:(BOOL)enableLeftRightScroll {
    self.mainCollectionView.scrollEnabled = enableLeftRightScroll;
}

#pragma mark - event handle
- (void)seletedHighlightItem:(NSInteger)number {
    [self.mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:number inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}



@end
