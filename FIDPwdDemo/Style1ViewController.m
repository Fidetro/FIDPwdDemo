//
//  Style1ViewController.m
//  FIDPwdDemo
//
//  Created by Fidetro on 2017/2/16.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "Style1ViewController.h"
#import "FIDPwdCollectionView.h"

@interface Style1ViewController ()
/** pwdView **/
@property(nonatomic,strong) FIDPwdCollectionView *pwdView;

@end

@implementation Style1ViewController

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


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}


- (FIDPwdCollectionView *)pwdView{
    
    if (!_pwdView) {
        
        __weak UIView *superView = self.view;
        _pwdView = [[FIDPwdCollectionView alloc]init];
        [superView addSubview:_pwdView];
        _pwdView.numberOfPwdView = 4;
        _pwdView.minimumLineSpacing = 4;
        _pwdView.normalBorderColor = [UIColor redColor];
        _pwdView.selectBorderColor = [UIColor blackColor];
        _pwdView.borderWidth = 1.f;
        
    }
    
    return _pwdView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
