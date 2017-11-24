//
//  NormalSearchView.m
//  PhotoTutorial
//
//  Created by het on 2017/11/6.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import "NormalSearchView.h"
@interface NormalSearchView()<UISearchBarDelegate>
/**searchBar组件**/
@property (nonatomic, strong) UISearchBar *searchBar;
/**cancelBtn组件**/
@property (nonatomic, strong) UIButton *cancelBtn;
/**下发导航线，默认为官方组件颜色**/
@property (nonatomic, strong) UIView *lineView;
/**默认字体内容**/
@property (nonatomic, copy) NSString *info;
/**放大镜的图片--可不配置走默认**/
@property (nonatomic, copy) NSString *zoominImage;
/**叉叉的图片--可不配置走默认**/
@property (nonatomic, copy) NSString *cancelImage;
@end

@implementation NormalSearchView
- (instancetype)initUseDefaultMessage:(NSString *)info searchImage:(NSString *)search cancleImage:(NSString *)cancle WithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.info = info;
        self.zoominImage = search;
        self.cancelImage = cancle;
        [self addSubview:self.searchBar];
        [self addSubview:self.cancelBtn];
        [self cancleBtnFrame];
    }
    return self;
}

#pragma mark - private methods
- (void)searchKeyboard:(BOOL)hidden {
    if (hidden) {
        [self.searchBar resignFirstResponder];
    } else {
        [self.searchBar becomeFirstResponder];
    }
}

-(void)cancleSearch {
    if (self.cancelBlcok) {
        self.cancelBlcok();
    }
    [self.searchBar resignFirstResponder];
    
}

-(void)cancleBtnFrame {
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchBar.mas_right);
        make.top.equalTo(self.searchBar.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark -searchBarDelegate-

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *temp = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inputStr = temp;
    if ([inputStr length] > 30)
    {
        //        [HelpMsg showMessage:@"最多输入30个字符" inView:AppMainWindow];
        [searchBar setText:[inputStr substringToIndex:30]];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *temp = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (temp.length) {
        //        SYCommunitySearchResultViewController *vc = [[SYCommunitySearchResultViewController alloc]init];
        //        vc.keyWord = searchBar.text;
        [searchBar resignFirstResponder];
        if (self.searchBlock) {
            self.searchBlock();
        }
        //        [self.navigationController pushViewController:vc animated:YES];
    } else {
        //        [HelpMsg showMessage:@"请输入搜索内容" inView:AppMainWindow];
    }
}

#pragma mark - setters and getters
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20,self.frame.size.width - 60,44)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.showsCancelButton = NO;
        _searchBar.translucent = YES;
        _searchBar.delegate = self;
        _searchBar.placeholder = self.info;
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        [searchField setValue:[UIColor colorWithHex:@"f7f7f7"] forKeyPath:@"_placeholderLabel.textColor"];
        searchField.textColor= [UIColor colorWithHex:@"ffffff"];
        [_searchBar setImage:[UIImage imageNamed:self.zoominImage]
            forSearchBarIcon:UISearchBarIconSearch
                       state:UIControlStateNormal];
        [_searchBar setImage:[UIImage imageNamed:self.cancelImage] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    }
    return _searchBar;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHex:@"f7f7f7"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancleSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
