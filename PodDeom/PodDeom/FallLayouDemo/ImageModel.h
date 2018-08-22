//
//  ImageModel.h
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/17.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageModel : NSObject
@property(nonatomic, copy)NSString *imgUrl;
@property(nonatomic, assign)float imgWidth;
@property(nonatomic, assign)float imgHeight;
@property(nonatomic, strong)UIImage *image;
@end
