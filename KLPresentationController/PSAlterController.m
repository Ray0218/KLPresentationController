//
//  PSAlterController.m
//  KLPresentationController
//
//  Created by 吴孔亮 on 2019/9/11.
//  Copyright © 2019 Ray. All rights reserved.
//

#import "PSAlterController.h"

@interface PSAlterController ()


@end

@implementation PSAlterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45] ;
 
    [self.view addSubview:self.rTextLabel];
    [self.rTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        
        
        make.width.height.mas_equalTo(200);
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pvt_diss)];
     [self.view addGestureRecognizer:tap];
    
     
    
}



//// 控制器弹出方式
//- (UIModalTransitionStyle)modalTransitionStyle {
//    
//    //    UIModalTransitionStyleCoverVertical ：从底部往上钻（默认）
//    //
//    //    UIModalTransitionStyleFlipHorizontal ：三维翻转
//    //
//    //    UIModalTransitionStyleCrossDissolve ：淡入淡出
//    //
//    //    UIModalTransitionStylePartialCurl ：翻页（只显示部分，使用前提：呈现样式必须是UIModalPresentationFullScreen）
//    return UIModalTransitionStyleCrossDissolve;
//}


-(void)pvt_diss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UILabel*)rTextLabel {
    if (!_rTextLabel) {
        _rTextLabel = [UILabel new] ;
        _rTextLabel.tag = 999 ;
        _rTextLabel.text = @"UIModalPresentationCustom";
        _rTextLabel.textColor = [UIColor redColor] ;
        _rTextLabel.textAlignment = NSTextAlignmentCenter ;
        _rTextLabel.backgroundColor = [UIColor greenColor] ;
    }
    return _rTextLabel ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
