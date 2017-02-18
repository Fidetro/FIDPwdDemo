//
//  ViewController.m
//  FIDPwdDemo
//
//  Created by Fidetro on 2017/2/16.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "ViewController.h"

#import "Style1ViewController.h"
#import "Style2ViewController.h"
#import "Style3ViewController.h"
#import <Masonry.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView **/
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *vcArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.view);
        
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - --------------------------UITableView dataSource--------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.vcArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
       [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = self.vcArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
    
}
#pragma mark - --------------------------UITableView delegate--------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[Style1ViewController alloc]init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[Style2ViewController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[Style3ViewController new] animated:YES];
            break;
        default:
            break;
    }
 
    
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        __weak UIView *superView = self.view;
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [superView addSubview:_tableView];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    
    return _tableView;
    
}

- (NSArray *)vcArray{
    
    if (!_vcArray) {
        
        _vcArray = @[@"Style1ViewController",@"Style2ViewController",@"Style3ViewController"];
        
    }
    
    return _vcArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
