//
//  PSPresentViewController.m
//  KLPresentationController
//
//  Created by 吴孔亮 on 2019/9/11.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "PSPresentViewController.h"

@interface PSPresentViewController ()
@property(nonatomic ,strong) UILabel *rTextLabel;

@end

@implementation PSPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Title" ;
    
    //添加毛玻璃特效
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
    visualView.frame = self.view.bounds;
    visualView.alpha = 0.45;
    visualView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:visualView];
    
  
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65] ;

    
    [self.view addSubview:self.rTextLabel];
    [self.rTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pvt_diss)];
    [self.view addGestureRecognizer:tap];
    
}



// 控制器弹出方式
- (UIModalTransitionStyle)modalTransitionStyle {
    
//    UIModalTransitionStyleCoverVertical ：从底部往上钻（默认）
//
//    UIModalTransitionStyleFlipHorizontal ：三维翻转
//
//    UIModalTransitionStyleCrossDissolve ：淡入淡出
//
//    UIModalTransitionStylePartialCurl ：翻页（只显示部分，使用前提：呈现样式必须是UIModalPresentationFullScreen）
    return UIModalTransitionStylePartialCurl;
}

// 设置控制器呈现样式
- (UIModalPresentationStyle)modalPresentationStyle {
//    return UIModalPresentationOverCurrentContext;
    
    // 充满全屏，如果弹出VC的wantsFullScreenLayout设置为YES的，则会填充到状态栏下边，否则不会填充到状态栏之下
//    UIModalPresentationFullScreen
    
    // 高度和当前屏幕高度相同，宽度和竖屏模式下屏幕宽度相同，剩余未覆盖区域将会变暗并阻止用户点击，这种弹出模式下，竖屏时跟UIModalPresentationFullScreen的效果一样，横屏时候两边则会留下变暗的区域,旋转屏幕效果明显
//    UIModalPresentationPageSheet
    
    // 高度和宽度均会小于屏幕尺寸，presented VC居中显示，四周留下变暗区域
//    UIModalPresentationFormSheet
    
    // 弹出方式和presenting VC的父VC的方式相同
//    UIModalPresentationCurrentContext
    
    // 自定义视图展示风格，由一个自定义演示控制器和一个或多个自定义动画对象组成。
    // 符合UIViewControllerTransitioningDelegate协议，使用视图控制器的transitioningDelegate设定您的自定义转换
//    UIModalPresentationCustom
    
    
    
    // 如果视图没有被填满，底层视图可以透过,
//    UIModalPresentationOverFullScreen
    
    // 视图全部被透过
//    UIModalPresentationOverCurrentContext
    
    // iPad中常用的设置弹出模式
//    UIModalPresentationPopover
    
    
    return UIModalPresentationFullScreen;

}

-(void)pvt_diss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UILabel*)rTextLabel {
    if (!_rTextLabel) {
        _rTextLabel = [UILabel new] ;
        _rTextLabel.text = @"测试UIModalPresentationStyle";
        _rTextLabel.textColor = [UIColor redColor] ;
        _rTextLabel.textAlignment = NSTextAlignmentCenter ;
        _rTextLabel.backgroundColor = [UIColor greenColor] ;
    }
    return _rTextLabel ;
}

@end
