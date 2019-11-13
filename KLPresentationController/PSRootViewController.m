//
//  PSRootViewController.m
//  KLPresentationController
//
//  Created by 吴孔亮 on 2019/9/11.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "PSRootViewController.h"
#import "PSAlterController.h"
#import "PSPOPTransitionDelege.h"
#import "PSPresentViewController.h"
#import "KLAnimator.h"


@interface PSRootViewController ()<UIPopoverPresentationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>{
    
    NSArray *_titlesArray;
}

@property (nonatomic,strong) UILabel *rTitleLabel ;


@property(nonatomic ,strong) UITableView *rTableView ;


@end

@implementation PSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    btn.backgroundColor = [UIColor orangeColor] ;
    btn.frame = CGRectMake(10, 200, 300, 80);
    [btn setTitle:@"弹窗" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pvt_show:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
     [self.view addSubview:self.rTitleLabel];
    [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.center.equalTo(self.view);
        make.width.mas_equalTo(80);
        
     }];
    
    
    _titlesArray = @[@"UIModalPresentationCustom",@"UIModalPresentationPopover",@"UIModalPresentationOverCurrentContext",@"UIPushView"] ;

    [self.view addSubview:self.rTableView];
    [self.rTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titlesArray.count ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify  = @"cellIdentify";
    UITableViewCell *cel = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cel == nil) {
        cel = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    cel.textLabel.text = _titlesArray[indexPath.row];
    return cel ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *alterVC ;
    
    
    if (indexPath.row == 3){
        
        PSAlterController * rAalterVC = [[PSAlterController alloc]init];
        self.navigationController.delegate = self;
        [self.navigationController pushViewController:rAalterVC animated:YES];
        
        return ;
        
    }else 
    if (indexPath.row == 0) {
      PSAlterController * rAalterVC = [[PSAlterController alloc]init];
        
        //设置style就能b实现弹出视图和当前视图在同一个UIWindow里面
        rAalterVC.modalPresentationStyle = UIModalPresentationCustom ;
        
        //自定义弹出动画效果
        PSPOPTransitionDelege *transDelegat = [[PSPOPTransitionDelege alloc]init];
        rAalterVC.transitioningDelegate = transDelegat ;
        
        //animated需要设置为YES,否则吴动画效果
        [self.navigationController presentViewController:rAalterVC animated:YES completion:nil];
        return ;
 
    }else if (indexPath.row == 1){
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
        alterVC = [[PSAlterController alloc]init];
        
        // UIPopoverPresentationController是iOS8以后新增的, 是UIPresentationController的子类，是UIViewController的属性。使用的的时候，需要创建的是UIViewController。UIViewController自定义内容
        alterVC.modalPresentationStyle = UIModalPresentationPopover;
        // 弹出视图的大小
        alterVC.preferredContentSize = CGSizeMake(300, 300);
        
        // 弹出视图设置
        UIPopoverPresentationController *popver = alterVC.popoverPresentationController;
        popver.delegate = self;
        // 弹出视图的尖头位置：参照视图底原点位置(左上角位置)
        popver.sourceRect =   CGRectMake(0, 0, 100, 0) ;
        //弹出视图的参照视图、从哪弹出
        popver.sourceView = cell;
        //弹框的箭头方向
        popver.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        //    popver.backgroundColor = [UIColor orangeColor];
    }else if (indexPath.row == 2) {
        alterVC = [[PSPresentViewController alloc]init];
        
        alterVC.modalPresentationStyle = UIModalPresentationPageSheet ;
    }
    
    [self.navigationController presentViewController:alterVC animated:YES completion:nil];

}

-(void)pvt_show:(UIButton*)button {
    
    
 
     PSAlterController *alterVC = [[PSAlterController alloc]init];

    //设置style就能b实现弹出视图和当前视图在同一个UIWindow里面
    alterVC.modalPresentationStyle = UIModalPresentationCustom ;
    
//自定义弹出动画效果
    PSPOPTransitionDelege *transDelegat = [[PSPOPTransitionDelege alloc]init];
    alterVC.transitioningDelegate = transDelegat ;
    
 

    /*
     PSAlterController *alterVC = [[PSAlterController alloc]init];

    // UIPopoverPresentationController是iOS8以后新增的, 是UIPresentationController的子类，是UIViewController的属性。使用的的时候，需要创建的是UIViewController。UIViewController自定义内容
     alterVC.modalPresentationStyle = UIModalPresentationPopover;
    // 弹出视图的大小
    alterVC.preferredContentSize = CGSizeMake(300, 300);
    
    // 弹出视图设置
    UIPopoverPresentationController *popver = alterVC.popoverPresentationController;
    popver.delegate = self;
    // 弹出视图的尖头位置：参照视图底原点位置(左上角位置)
    popver.sourceRect =   CGRectMake(10, -10, 0, 0) ;
    //弹出视图的参照视图、从哪弹出
    popver.sourceView = self.rTitleLabel;
    //弹框的箭头方向
    popver.permittedArrowDirections = UIPopoverArrowDirectionRight;
    
//    popver.backgroundColor = [UIColor orangeColor];
    */
    
    
    /*
    PSPresentViewController *alterVC = [[PSPresentViewController alloc]init];
 
    alterVC.modalPresentationStyle = UIModalPresentationPageSheet ;
*/
    
    
    [self.navigationController presentViewController:alterVC animated:YES completion:nil];


}

// -------UIPopoverPresentationControllerDelegate
// 默认返回的是覆盖整个屏幕，需设置成UIModalPresentationNone。
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

// 设置点击蒙版是否消失，默认为YES
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}
// 弹出视图消失后调用的方法
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
}


#pragma mark UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
            
           KLAnimator *animator = [KLAnimator new];
           animator.rCurrentFrame = CGRectMake(200, 250, 80, 80);
           
           return animator;
       }
       
    return nil;
}

-(UITableView*)rTableView {
    
    if (_rTableView == nil) {
        
        _rTableView = [[UITableView alloc]init];
 
        _rTableView.delegate = self ;
        _rTableView.dataSource = self ;
        _rTableView.showsVerticalScrollIndicator = NO ;
        _rTableView.tableFooterView = [UIView new];
        
        _rTableView.estimatedRowHeight = 72;
        _rTableView.rowHeight = UITableViewAutomaticDimension ;
        _rTableView.estimatedSectionHeaderHeight = 0;
        _rTableView.estimatedSectionFooterHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            _rTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        
        
    }
    return _rTableView ;
}


-(UILabel*)rTitleLabel {
    if (!_rTitleLabel) {
        _rTitleLabel = [[UILabel alloc]init];
        _rTitleLabel.text = @"测试popoverView相对位置";
        _rTitleLabel.numberOfLines = 0 ;
        _rTitleLabel.textAlignment = NSTextAlignmentCenter;
        _rTitleLabel.backgroundColor = [UIColor greenColor] ;
    }
    return _rTitleLabel ;
}

@end
