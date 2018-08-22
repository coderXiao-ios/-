//
//  ImageCell.h
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/17.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (void) setImgPath:(NSString *)imgUrl;
@end
