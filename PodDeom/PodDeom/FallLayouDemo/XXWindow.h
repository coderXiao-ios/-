//
//  XXWindow.h
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/21.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^hiddenImgBlock)(void);
@interface XXWindow : UIWindow
@property(nonatomic, copy)hiddenImgBlock hiddenImgBlock;
+(XXWindow *)shareWindow;
- (void) showImg:(UIImageView *)sourceView selectedIdx:(NSInteger) selected imgsArry:(NSArray *)imgsArry;
@end
