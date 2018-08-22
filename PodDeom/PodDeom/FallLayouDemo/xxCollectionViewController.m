//
//  xxCollectionViewController.m
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/21.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import "xxCollectionViewController.h"
#import "BrowserCell.h"
#import "UIView+CXExtension.h"
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
@interface xxCollectionViewController ()
@property(nonatomic, assign)NSInteger selectedIdx;
@property(nonatomic, strong)NSMutableArray *imgsArry;
@end

@implementation xxCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

+ (xxCollectionViewController *)xxCollectionViewController:(NSInteger) selected imgsArry:(NSArray *)imgsArry{
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.minimumLineSpacing = 20;
    layOut.minimumInteritemSpacing = 0;
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    xxCollectionViewController *vc = [[xxCollectionViewController alloc] initWithCollectionViewLayout:layOut];
    [vc.imgsArry addObjectsFromArray:imgsArry];
    vc.selectedIdx = selected;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    CGFloat lineSpacing = ((UICollectionViewFlowLayout *)self.collectionViewLayout).minimumLineSpacing;

    self.collectionView.width += lineSpacing;

    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, lineSpacing);

    [self.collectionView registerClass:[BrowserCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ImageCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ImageCell class])];
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.width*_selectedIdx, 0)];
    self.collectionView.pagingEnabled = YES;
    [self.collectionView reloadData];
    if (@available(iOS 11.0, *))
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    else self.automaticallyAdjustsScrollViewInsets = NO;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imgsArry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        int num = abs(rand())%0xFFFF;
            cell.backgroundColor = UIColorFromRGBA(num, 1.0);
    [cell setImgPath:_imgsArry[indexPath.item]];   
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
- (NSMutableArray *)imgsArry{
    if (!_imgsArry) {
        _imgsArry = [NSMutableArray array];
    }
    return _imgsArry;
}
@end
