//
//  Style3ViewController.m
//  FIDPwdDemo
//
//  Created by Fidetro on 2017/2/16.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "Style3ViewController.h"
#import "FIDPwdCollectionView.h"
@interface Style3ViewController ()<FIDPwdCollectionViewDelegate>

/** pwdView **/
@property(nonatomic,strong) FIDPwdCollectionView *pwdView;

@end

@implementation Style3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak UIView *superView = self.view;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.pwdView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(superView.mas_centerY);
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);
        
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)finishInputPwdString:(NSString *)pwdString{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.pwdView reloadPwd];
    });
}



- (FIDPwdCollectionView *)pwdView{
    
    if (!_pwdView) {
        
        __weak UIView *superView = self.view;
        _pwdView = [[FIDPwdCollectionView alloc]init];
        [superView addSubview:_pwdView];
        _pwdView.numberOfPwdView = 4;
        _pwdView.minimumLineSpacing = 0;
        _pwdView.normalBorderColor = [UIColor blackColor];
        _pwdView.normalImage = [UIImage imageNamed:@"nor_border_img"];
        _pwdView.selectedImage = [UIImage imageNamed:@"sel_border_img"];
        _pwdView.borderWidth = 1.f;
        
    }
    
    return _pwdView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
