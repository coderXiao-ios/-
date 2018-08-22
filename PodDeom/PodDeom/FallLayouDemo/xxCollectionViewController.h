//
//  xxCollectionViewController.h
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/21.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^nextPageBlock)(NSInteger nextPage);
@interface xxCollectionViewController : UICollectionViewController
@property(nonatomic, copy)nextPageBlock  nextPageBlock;
+ (xxCollectionViewController *)xxCollectionViewController:(NSInteger) selected imgsArry:(NSArray *)imgsArry;
@end
