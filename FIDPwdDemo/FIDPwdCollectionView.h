//
//  FIDPwdCollectionView.h
//  Test
//
//  Created by Fidetro on 2017/2/5.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

#define kFIDPwdCellidentifier @"FIDPwdCollectionViewCell"

@protocol FIDPwdCollectionViewDelegate <NSObject>

- (void)finishInputPwdString:(NSString *)pwdString;

@end

@interface FIDPwdCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** 密码框数量 **/
@property(nonatomic,assign) NSInteger numberOfPwdView;
/** 两个Item间的间距 **/
@property(nonatomic,assign) float minimumLineSpacing;
/** 文本颜色 **/
@property(nonatomic,strong) UIColor *textColor;
/** 响应时的边框颜色 **/
@property(nonatomic,strong) UIColor *selectBorderColor;
/** 正常时候的边框颜色 **/
@property(nonatomic,strong) UIColor *normalBorderColor;
/** 边框宽度 **/
@property(nonatomic,assign) float borderWidth;
/** 背景颜色 **/
@property(nonatomic,strong) UIColor *backgroundColor;
/** 没有密码时显示的图片 **/
@property(nonatomic,strong) UIImage *normalImage;
/** 有密码时显示的图片 **/
@property(nonatomic,strong) UIImage *selectedImage;
/** 是否可以编辑 **/
@property(nonatomic,assign) BOOL canEdit;




/**
 密码错误的时候调用，清空密码，重新输入
 */
- (void)reloadPwd;


/**
 获取输入的密码
 
 @return 输入的密码
 */
- (NSString *)getPwdString;

/** 密码代理 **/
@property(nonatomic,weak) id<FIDPwdCollectionViewDelegate> pwdDelegate;

@end

