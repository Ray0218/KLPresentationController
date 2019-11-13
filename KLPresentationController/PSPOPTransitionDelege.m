//
//  PSPOPTransitionDelege.m
//  VietnamObject
//
//  Created by 吴孔亮 on 2019/9/9.
//  Copyright © 2019 任西斌. All rights reserved.
//

#import "PSPOPTransitionDelege.h"

@implementation PSPOPTransitionDelege{
    
    BOOL rIsPresent;
}

 
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    rIsPresent = YES ;
    return self ;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    rIsPresent = NO ;

    return self ;
}

///如果需要修改弹出视图frame,可以实现这个方法
- ( UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
    
    UIPresentationController *presentVC = [[UIPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting] ;
    CGFloat windowH = [UIScreen mainScreen].bounds.size.height;
    CGFloat windowW = [UIScreen mainScreen].bounds.size.width;
    presentVC.presentedView.frame = CGRectMake(50, 150, windowW - 100, windowH - 200) ;

    return presentVC;
    
}

#pragma mark- UIViewControllerAnimatedTransitioning

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    if (rIsPresent) {
 

//        拿到需要展现的视图
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey] ;
        
        [transitionContext.containerView addSubview:toView];

        UIView *RtitleLabel = [toView viewWithTag:999] ;
        RtitleLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);

        [UIView animateWithDuration:1// [self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:1
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{

                             
                             RtitleLabel.transform = CGAffineTransformIdentity;


                         }
                         completion:^(BOOL finished) {

 
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];


    }else{
        //拿到需要关闭的视图
         UIView *rfromView = [transitionContext viewForKey:UITransitionContextFromViewKey] ;

        //执行动画
         [UIView animateWithDuration:0.6
                              delay:0
             usingSpringWithDamping:1
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             rfromView.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];

    }
    
 
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.25 ;
}




@end



@interface PresentationController ()

@property (nonatomic,strong) UIVisualEffectView *visualView;

@end

@implementation PresentationController


//presentationTransitionWillBegin 是在呈现过渡即将开始的时候被调用的。我们在这个方法中把半透明黑色背景 View 加入到 containerView 中，并且做一个 alpha 从0到1的渐变过渡动画。
- (void)presentationTransitionWillBegin {
    
    // 使用UIVisualEffectView实现模糊效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
    _visualView.frame = self.containerView.bounds;
    _visualView.alpha = 0.4;
    _visualView.backgroundColor = [UIColor blackColor];
    
    [self.containerView addSubview:_visualView];
}

//presentationTransitionDidEnd: 是在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成。在我们的例子中，我们可以使用它在过渡效果已结束但没有完成时移除半透明的黑色背景 View。
- (void)presentationTransitionDidEnd:(BOOL)completed {
    
    // 如果呈现没有完成，那就移除背景 View
    if (!completed) {
        [_visualView removeFromSuperview];
    }
}

//以上就涵盖了我们的背景 View 的呈现部分，我们现在需要给它添加淡出动画并且在它消失后移除它。正如你预料的那样，dismissalTransitionWillBegin 正是我们把它的 alpha 重新设回0的地方。
- (void)dismissalTransitionWillBegin {
    _visualView.alpha = 0.0;
}

//我们还需要在消失完成后移除背景 View。做法与上面 presentationTransitionDidEnd: 类似，我们重载 dismissalTransitionDidEnd: 方法
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [_visualView removeFromSuperview];
    }
}

//还有最后一个方法需要重载。在我们的自定义呈现中，被呈现的 view 并没有完全完全填充整个屏幕，而是很小的一个矩形。被呈现的 view 的过渡动画之后的最终位置，是由 UIPresentationViewController 来负责定义的。我们重载 frameOfPresentedViewInContainerView 方法来定义这个最终位置, 将决定PresentVC内容的位置
- (CGRect)frameOfPresentedViewInContainerView {

    CGFloat windowH = [UIScreen mainScreen].bounds.size.height;
    CGFloat windowW = [UIScreen mainScreen].bounds.size.width;

    self.presentedView.frame = CGRectMake(50, 150, windowW - 100, windowH - 200);

    return self.presentedView.frame;
}

@end
