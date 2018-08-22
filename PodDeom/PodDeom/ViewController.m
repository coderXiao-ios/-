//
//  ViewController.m
//  XXSegmentedPager
//
//  Created by Xiao Xiao on 2018/7/2.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "sys/utsname.h"
#import <YYText/YYText.h>
#import "UIView+YYAdd.h"
#import "UIImageView+WebCache.h"
#import "WaterFallLayoutViewController.h"
#import "XXWindow.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *testImgView;
@property(nonnull, strong,nonatomic)NSMutableArray *modelsArry;
@property(nonnull, strong,nonatomic)NSMutableArray *vcsArry;
@property(nonatomic, strong)UIWindow *myWindow;
@end

@implementation ViewController
-(void)viewDidLoad{
    [super viewDidLoad];
   
    UITableView *listTabelView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                                 style:UITableViewStylePlain];
    listTabelView.delegate = self;
    listTabelView.dataSource = self;
    listTabelView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"DemoVC";
    _modelsArry = [NSMutableArray array];
    [_modelsArry addObjectsFromArray:@[@"流布局",@"CALayer相关使用",@"window相关使用"]];
    _vcsArry = [NSMutableArray array];
    [_vcsArry addObjectsFromArray:@[@"WaterFallLayoutViewController",@"TangramDemoVCTableVC"]];
    [self.view addSubview:listTabelView];
}

- (IBAction)btnAction:(id)sender {
    [self configImg];
//    WaterFallLayoutViewController *vc = [[WaterFallLayoutViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}


- (void) configImg{
    __weak typeof(self) weakParam = self;
    [_testImgView  sd_setImageWithURL:[NSURL URLWithString:@"http://img1.hefantv.com/20180815/095dea68086341b8a3408387088577c9.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            NSLog(@"未加载出来");
        }else{
            float width = image.size.width;
            float height = image.size.height;
            if (height/width >(16.0/9.0)) {
                weakParam.testImgView.layer.contentsRect = CGRectMake(0, 0, 1, (float)(16.0/9.0)*width/height);
            }else{
                weakParam.testImgView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
            }
            
        }
    }];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    pan.minimumNumberOfTouches =  1;
    [_testImgView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_testImgView addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    _testImgView.hidden = YES;
    [[XXWindow shareWindow] showImg:_testImgView selectedIdx:2 imgsArry:@[@"http://img1.hefantv.com/20180816/b9c7b43d4a2042d8a5fd326f33e1ed42.jpg",@"http://img1.hefantv.com/20180813/25a3cabfa62f4c00963fac098238e4c2.jpg",@"http://img1.hefantv.com/20180815/095dea68086341b8a3408387088577c9.jpg",@"http://img.hefantv.com/20180427/6abed6bb8e344115a278b3b9652a3d84.jpg",@"http://img.hefantv.com/20180427/b633a180299b411e9112072c06fbc1de.jpg",@"http://img.hefantv.com/20180427/d68c350ba9944c9cb28eb38b34e88e82.jpg",@"http://img.hefantv.com/20180427/7d82961c30164e2093dab0253c24685e.jpg",@"http://img.hefantv.com/20180427/e349255054414481a865022716054e85.jpg",@"http://img.hefantv.com/20180427/97d6fff14d4a41ae8359b62b36337f46.jpg"]];
    __weak typeof(self) weakSelf = self;
    [[XXWindow shareWindow] setHiddenImgBlock:^{
        weakSelf.testImgView.hidden = NO;
    }];
}

- (void)panAction:(UIPanGestureRecognizer *)pan{
    NSLog(@"%@",NSStringFromCGPoint([pan translationInView:pan.view]));
    CGPoint point = [pan translationInView:pan.view];
    
    //    pan.view.transform =CGAffineTransformMakeTranslation(point.x, point.y);
    
    pan.view.transform =CGAffineTransformTranslate(pan.view.transform, point.x, point.y);
    
    [pan setTranslation:CGPointZero inView:pan.view];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelsArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"1"];
    }
    cell.textLabel.text = _modelsArry[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > _vcsArry.count) {
        UIViewController *vc = [[UIViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.navigationController pushViewController:[NSClassFromString(_vcsArry[indexPath.row]) new]  animated:YES];

    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor lightGrayColor];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return   10;
//}

@end
