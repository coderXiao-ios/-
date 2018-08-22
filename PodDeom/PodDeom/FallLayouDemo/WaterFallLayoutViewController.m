//
//  WaterFallLayoutViewController.m
//  PodDeom
//
//  Created by Xiao Xiao on 2018/8/17.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import "WaterFallLayoutViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "ImageCell.h"
#import "ImageModel.h"
#import "UIView+Extension.h"
#import "UIView+CXExtension.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "XXWindow.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
static NSInteger kHeaderViewHeight = 160;
@interface WaterFallLayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray<ImageModel *> *modelArry;
@property(nonatomic, strong)UIView *headerView;
@property(nonatomic, strong)UIView *navigationView;
@property (nonatomic, strong) dispatch_group_t    requestGroup;
@property(nonatomic, strong)NSMutableArray *imgsArry;
@end

@implementation WaterFallLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _modelArry = [NSMutableArray array];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = UIColorFromRGBA(0xf0f0f0, 1.0);
    NSArray *imgsArry = @[@"http://img1.hefantv.com/20180816/b9c7b43d4a2042d8a5fd326f33e1ed42.jpg",@"http://img1.hefantv.com/20180813/25a3cabfa62f4c00963fac098238e4c2.jpg",@"http://img1.hefantv.com/20180815/095dea68086341b8a3408387088577c9.jpg",@"http://img.hefantv.com/20180427/6abed6bb8e344115a278b3b9652a3d84.jpg",@"http://img.hefantv.com/20180427/b633a180299b411e9112072c06fbc1de.jpg",@"http://img.hefantv.com/20180427/d68c350ba9944c9cb28eb38b34e88e82.jpg",@"http://img.hefantv.com/20180427/7d82961c30164e2093dab0253c24685e.jpg",@"http://img.hefantv.com/20180427/e349255054414481a865022716054e85.jpg",@"http://img.hefantv.com/20180427/97d6fff14d4a41ae8359b62b36337f46.jpg"];
    _imgsArry = [NSMutableArray arrayWithArray:imgsArry];
    _requestGroup = dispatch_group_create();
    __weak typeof(self) weakSelf = self;
    [imgsArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *url = (NSString *)obj;
        dispatch_group_enter(weakSelf.requestGroup);
        
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image == nil) {
                NSLog(@"未加载出来");
            }else{
                NSLog(@"加载出来了");
                ImageModel *model = [[ImageModel alloc] init];
                model.imgUrl = url;
                model.image = image;
                model.imgWidth = image.size.width;
                model.imgHeight = image.size.height;
                [weakSelf.modelArry addObject:model];
            }
            dispatch_group_leave(weakSelf.requestGroup);
        }];
    }];
    
    dispatch_group_notify(_requestGroup, dispatch_get_main_queue(), ^{
        [weakSelf.collectionView reloadData];
    });
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else  self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        self.collectionView.frame = CGRectMake(0,0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.frame) -  self.view.safeAreaInsets.bottom);
    } else {
        self.collectionView.frame = CGRectMake(0,0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.frame));
    }
#endif
    self.navigationView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64);
}
- (void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ==
#pragma mark UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }
    return _modelArry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCell class]) forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"109951163449951634.jpeg"];
        _headerView = cell;
        return cell;
    }
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCell class]) forIndexPath:indexPath];
//    int num = abs(rand())%0xFFFF;
//    cell.backgroundColor = UIColorFromRGBA(num, 1.0);
    [cell setImgPath:_modelArry[indexPath.item].imgUrl];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  __block ImageCell *cell = (ImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.hidden = YES;
    [[XXWindow shareWindow] showImg:cell.imageView selectedIdx:indexPath.row imgsArry:indexPath.section == 0?@[@"109951163449951634.jpeg"]:_imgsArry];
    [[XXWindow shareWindow] setHiddenImgBlock:^{
        cell.hidden = NO;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offsetY=scrollView.contentOffset.y;
    if (scrollView.contentOffset.y <0) {
        CGRect imgRect=CGRectMake(0+offsetY/2, 0+offsetY, CGRectGetWidth(self.view.frame)-offsetY*1, 150-offsetY*1);
        self.headerView.frame = imgRect;
        self.navigationView.alpha = 0;
    }else{
        CGFloat alpha = offsetY/_headerView.height;
        self.navigationView.alpha = alpha;
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return CGSizeMake(CGRectGetWidth(self.view.frame), 150);
    }
    CGFloat width =(CGRectGetWidth(self.view.frame) -3*10)/2.0;
    CGFloat height = (self.modelArry[indexPath.item].imgHeight/self.modelArry[indexPath.item].imgWidth)*width;
    return CGSizeMake(width, height/width >16.0/9.0?width*(16.0/9.0):height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section ==1) {
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0;
}
#pragma mark ==
#pragma mark setter/getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.minimumInteritemSpacing =10;
        layout.minimumColumnSpacing =10;
        layout.itemRenderDirection = CHTCollectionViewWaterfallLayoutItemRenderDirectionShortestFirst;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        [_collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ImageCell class])];
        _collectionView.backgroundColor = [UIColor whiteColor];
                [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
        _navigationView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64);
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        backBtn.frame = CGRectMake(10, 20+10, 30, 30);
        backBtn.backgroundColor = UIColorFromRGBA(0xffb123, 1.0);
        [_navigationView addSubview:backBtn];
        UILabel *title = [[UILabel alloc] init];
        title.text = @"图片流";
        title.textColor = UIColorFromRGBA(0x323232, 1.0);
        title.frame = CGRectMake(10, 20+10, 70, 20);
        title.centerX = CGRectGetWidth(self.view.frame)/2.0;
        title.centerY = backBtn.centerY;

        [_navigationView addSubview:title];
        [self.view addSubview:_navigationView];
        _navigationView.alpha = 0.0;
        _navigationView.backgroundColor = [UIColor whiteColor];
    }
    return _navigationView;
}
//- (UIView *)headerView{
//    if (!_headerView) {
//        _headerView = [UIView new];
//        int num = abs(rand())%0xFFFF;
//        _headerView.backgroundColor = UIColorFromRGBA(num, 1.0);
//        [self.view addSubview:_headerView];
//    }
//    return _headerView;
//}
@end
