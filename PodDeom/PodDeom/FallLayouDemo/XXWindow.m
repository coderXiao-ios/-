//
//  XXWindow.m
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/21.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import "XXWindow.h"
#import "xxCollectionViewController.h"
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface XXWindow()
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)xxCollectionViewController *browser;
@end
@implementation XXWindow
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWindow:)];
        tap.numberOfTapsRequired =2;
        [self addGestureRecognizer:tap];
    }
    return self;
}

+(XXWindow *)shareWindow{
    static XXWindow *window;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window = [[XXWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return window;
}

- (void) hiddenWindow:(UITapGestureRecognizer *)tap{
    NSLog(@"__________%ld",tap.numberOfTapsRequired);
    _browser.view.hidden = YES;
    _browser = nil;
   __block UIImageView *copyView = [self viewWithTag:100];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = UIColorFromRGBA(0x00000, 0.0);
        copyView.frame = self.imgView.frame;
    } completion:^(BOOL finished) {
        if (finished == YES) {
            self.hidden = YES;
            if (self.hiddenImgBlock) {
                self.hiddenImgBlock();
            }
            [copyView removeFromSuperview];
            copyView = nil;
        }
    }];
}
- (void) showImg:(UIImageView *)sourceView selectedIdx:(NSInteger) selected imgsArry:(NSArray *)imgsArry{
    _imgView = sourceView;
    self.hidden = NO;
    [self makeKeyAndVisible];
    CGRect fromeRect = [sourceView convertRect:sourceView.frame toView:self];
    UIImageView *copyView = [[UIImageView alloc] initWithImage:sourceView.image];
    float width = sourceView.image.size.width;
    float height = sourceView.image.size.height;
    if (height/width >(16.0/9.0)) {
       copyView.layer.contentsRect = CGRectMake(0, 0, 1, (float)(16.0/9.0)*width/height);
    }else{
       copyView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    }
    copyView.clipsToBounds = YES;
    copyView.frame = fromeRect;
    copyView.tag = 100;
    [self addSubview:copyView];
    CGRect toRect = CGRectMake(sourceView.image.size.width >CGRectGetWidth(self.bounds)?0:(CGRectGetWidth(self.bounds) - sourceView.image.size.width)/2.0, sourceView.image.size.height >CGRectGetHeight(self.bounds)?0:(CGRectGetHeight(self.bounds) - sourceView.image.size.height)/2.0, sourceView.image.size.width >CGRectGetWidth(self.bounds)?CGRectGetWidth(self.bounds):sourceView.image.size.width, sourceView.image.size.height);
    self.backgroundColor = UIColorFromRGBA(0x00000, 0.0);
    copyView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    [UIView animateWithDuration:0.3 animations:^{
        copyView.frame = toRect;
        self.backgroundColor = UIColorFromRGBA(0x00000, 1.0);
    } completion:^(BOOL finished) {
        if (finished == YES) {
            self.browser = [xxCollectionViewController xxCollectionViewController:selected imgsArry:imgsArry];
            self.rootViewController = self.browser;
        }
    }];
}
@end
