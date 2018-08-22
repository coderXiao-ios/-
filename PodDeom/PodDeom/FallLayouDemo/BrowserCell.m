//
//  BrowserCell.m
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/21.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import "BrowserCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+CXExtension.h"
#import "BrowserImg.h"
@interface BrowserCell()
@property(nonatomic, strong)BrowserImg *imgView;
@property(nonatomic, strong)UIScrollView *imgScroll;
@end
@implementation BrowserCell
- (void)dealloc{
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _imgView = [[BrowserImg alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgScroll = [[UIScrollView alloc] init];
        [self.contentView addSubview:_imgScroll];
        [_imgScroll addSubview:_imgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imgScroll.frame = self.contentView.bounds;
}

- (void) setImgPath:(NSString *)imgUrl{
    __weak typeof(self) weakCell = self;
    [_imgView  sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            NSLog(@"未加载出来");
            image =  [UIImage imageNamed:imgUrl];
        }
        weakCell.imgView.frame = CGRectMake(image.size.width>self.width?0:(self.width - image.size.width)/2.0, image.size.height>self.height?0:(self.height - image.size.height)/2.0, image.size.width>self.width?self.width:image.size.width, image.size.height);
        weakCell.imgScroll.contentSize = CGSizeMake(weakCell.imgScroll.width, weakCell.imgScroll.height>weakCell.imgView.bottom?weakCell.imgScroll.height:weakCell.imgView.height);
        weakCell.imgView.image = image;
    }];
}
@end
