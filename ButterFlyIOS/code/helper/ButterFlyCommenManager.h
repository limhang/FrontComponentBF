//
//  ButterFlyCommenManager.h
//  PhotoTutorial
//
//  Created by het on 2017/11/14.
//  Copyright © 2017年 xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButterFlyCommenManager : NSObject
// 递归获取子视图
+ (void)getSub:(UIView *)view andLevel:(int)level;

@end
