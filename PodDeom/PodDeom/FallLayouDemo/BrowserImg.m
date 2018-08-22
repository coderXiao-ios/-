//
//  BrowserImg.m
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/22.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import "BrowserImg.h"
#import "UIView+CXExtension.h"
@implementation BrowserImg
- (instancetype)init{
    if ([super init]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//        pan.minimumNumberOfTouches =  1;
//        pan.dre
        [self addGestureRecognizer:pan];
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)panAction:(UIPanGestureRecognizer *)pan{
  
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateFailed:
            
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        default:
            break;
    }
    NSLog(@"%@",NSStringFromCGPoint([pan translationInView:pan.view]));
    CGPoint point = [pan translationInView:pan.view];
    
    //    pan.view.transform =CGAffineTransformMakeTranslation(point.x, point.y);
    pan.view.transform =CGAffineTransformTranslate(pan.view.transform, point.x, point.y);
    
    pan.view.transform = CGAffineTransformScale(pan.view.transform,point.y/pan.view.height , point.y/pan.view.height);
    [pan setTranslation:CGPointZero inView:pan.view];
    
}

@end
