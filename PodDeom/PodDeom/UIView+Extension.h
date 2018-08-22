//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
//找到自己的vc
- (UIViewController *)hf_viewController;
/**
 *  从xib加载view通用方法
 *
 *  @return
 */
+ (instancetype)viewFromXib;
- (UINavigationController *)navigationController;
/**
 *  画圆角
 */
- (void)addCornerMaskLayerWithRadius:(CGFloat)radius ;
- (void) addCornerViewRadius;
/**
 *  横向移动动画
 */
-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x;
/**
 *  纵向移动动画
 */
-(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y;
/**
 *  缩放动画
 */
-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes;
/**
 *  组合动画
 */
-(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes;
/**
 *  旋转动画
 */
-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount;
/**
 *  永久闪烁的动画
 */
-(CABasicAnimation *)opacityForever_Animation:(float)time;


- (BOOL)findSubView:(Class)cls allSameType:(BOOL)same container:(NSMutableArray*)container;
+ (BOOL)findSubView:(Class)cls view:(UIView*)v allSameType:(BOOL)same container:(NSMutableArray*)container;

@end
