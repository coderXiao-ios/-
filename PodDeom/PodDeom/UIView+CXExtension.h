//
//  UIView+CXExtension.h
//  CXCamera
//
//  Created by c_xie on 16/3/28.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HFGiftModel.h"

@interface UIView (CXExtension)

@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGPoint cx_center;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;


- (UIImage *)renderImage;


- (UIImage *)renderImageWithSize:(CGSize)size;


- (BOOL)isShowingOnKeyWindow;



+ (instancetype)viewFromXib;


/**
 判断数组是否为空
 */
- (BOOL)isNotEmpty:(NSArray *)array;

//- (BOOL)arrayISContain:(GiftModel *)ob array:(NSMutableArray *)array;
//-(BOOL)harrayISContain:(HGiftModel *)ob array:(NSMutableArray *)array;

@end
