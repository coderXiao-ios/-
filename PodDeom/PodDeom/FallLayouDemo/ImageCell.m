//
//  ImageCell.m
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/17.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import "ImageCell.h"
#import "UIView+CXExtension.h"
#import "UIImageView+WebCache.h"
@interface ImageCell()
@property(nonatomic, strong)NSString *imgUrl;
@end
@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 3.0;
}

- (void) setImgPath:(NSString *)imgUrl{
    if (imgUrl == _imgUrl) return;
    _imgUrl = imgUrl;
    __weak typeof(self) weakCell = self;
    [_imageView  sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            NSLog(@"未加载出来");
        }else{
            float width = image.size.width;
            float height = image.size.height;
            if (height/width >(16.0/9.0)) {
                weakCell.imageView.layer.contentsRect = CGRectMake(0, 0, 1, (float)(16.0/9.0)*width/height);
            }else{
                weakCell.imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
            }
        }
    }];
}
@end
