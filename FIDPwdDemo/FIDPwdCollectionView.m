
//
//  FIDPwdCollectionView.m
//  Test
//
//  Created by Fidetro on 2017/2/5.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#import "FIDPwdCollectionView.h"
@protocol PwdTextFieldDelegate <NSObject>

- (void)deleteBackward:(UITextField *)textField;

@end
@interface FIDPwdTextField : UITextField<UITextFieldDelegate>
/** 反馈删除按钮的代理事件 **/
@property(nonatomic,weak) id<PwdTextFieldDelegate> deleteDelegate;
@end


@implementation FIDPwdTextField
- (instancetype)init{
    
    if ([super init]) {
        
        self.delegate = self;
        
    }
    
    return self;
    
}

- (void)deleteBackward{
    
    if (self.deleteDelegate) {
        [self.deleteDelegate deleteBackward:self];
    }
    
}

@end




@interface FIDPwdView : UIView


/** 挡住输入的TopView **/
@property(nonatomic,strong) UIView *topView;
/** 输入框 **/
@property(nonatomic,strong) FIDPwdTextField *pwdTextField;
/** 放在最前的按钮 **/
@property(nonatomic,strong) UIButton *frontButton;

@end

@implementation FIDPwdView

- (instancetype)init{
    
    if ([super init]) {
        
        
        
        
        __weak UIView *superView = self;
        [self.pwdTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(superView);
            
        }];
        self.topView.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
    
}

- (FIDPwdTextField *)pwdTextField{
    
    if (!_pwdTextField) {
        
        __weak UIView *superView = self;
        _pwdTextField = [[FIDPwdTextField alloc]init];
        [superView addSubview:_pwdTextField];
        _pwdTextField.textAlignment = NSTextAlignmentCenter;
        _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        
        
    }
    
    return _pwdTextField;
    
}



- (UIButton *)frontButton{
    
    if (!_frontButton) {
        
        __weak UIView *superView = self;
        _frontButton = ({
            
            UIButton *frontButton = [[UIButton alloc]init];
            [superView addSubview:frontButton];
            frontButton.userInteractionEnabled = YES;
            [frontButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.mas_equalTo(superView);
                
            }];
            frontButton;
        });
        
    }
    
    return _frontButton;
    
}

@end



@interface FIDPwdCollectionView ()<UITextFieldDelegate,PwdTextFieldDelegate>

/** 存放textField **/
@property(nonatomic,strong) NSMutableDictionary *textFieldDictonary;

@end

@implementation FIDPwdCollectionView

- (instancetype)init{
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if ([super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kFIDPwdCellidentifier];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        
        
    }
    
    return self;
    
}

- (NSInteger)numberOfSections{
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.numberOfPwdView;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFIDPwdCellidentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    FIDPwdView *pwdView = ({
        
        pwdView = [[FIDPwdView alloc]init];
        [cell addSubview:pwdView];
        pwdView.pwdTextField.delegate = self;
        pwdView.pwdTextField.tag = indexPath.row;
        pwdView.pwdTextField.deleteDelegate = self;
        pwdView.pwdTextField.layer.borderColor = self.normalBorderColor.CGColor;
        pwdView.pwdTextField.textColor = self.textColor;
        pwdView.pwdTextField.backgroundColor = self.backgroundColor;
        pwdView.frontButton.hidden = self.canEdit;
        pwdView.pwdTextField.layer.borderWidth = self.borderWidth <0.0001 ? 0 : self.borderWidth;
        if (self.normalImage != nil || self.selectedImage != nil) {
            pwdView.pwdTextField.hidden = YES;
        }
        
        self.normalImage != nil ? [pwdView.frontButton setImage:self.normalImage forState:UIControlStateNormal]:"";
        self.selectedImage != nil ? [pwdView.frontButton setImage:self.selectedImage forState:UIControlStateSelected]:"";
        [pwdView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(cell);
            
        }];
        
        pwdView;
    });
    
    if (indexPath.row == 0) {
        
        [pwdView.pwdTextField becomeFirstResponder];
        
        
    }
    
    [self.textFieldDictonary setObject:pwdView forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((collectionView.frame.size.width-(self.minimumLineSpacing * (self.numberOfPwdView - 1))) / self.numberOfPwdView, collectionView.frame.size.height);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return self.minimumLineSpacing;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return CGFLOAT_MIN;
    
}

- (void)layoutIfNeeded{
    
    [super layoutIfNeeded];
    for (FIDPwdView *pwdView in [self.textFieldDictonary allValues]) {
        
        if (pwdView.pwdTextField.tag == 0 ){
            
            [pwdView.pwdTextField becomeFirstResponder];
            
            break;
        }
        
    }
    
    
}

- (void)reloadPwd{
    
    for (UIView *view in [self.textFieldDictonary allValues]) {
        [view removeFromSuperview];
    }
    self.textFieldDictonary = [NSMutableDictionary dictionary];
    
    [self reloadData];
    
    [self layoutIfNeeded];
    
    
    
}


#pragma mark - --------------------------textField Delegate--------------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    textField.text = string;
    FIDPwdView *nextView = self.textFieldDictonary[[NSString stringWithFormat:@"%ld",textField.tag+1]];
    FIDPwdView *lastView = self.textFieldDictonary[[NSString stringWithFormat:@"%ld",textField.tag-1]];


    
    if (textField.text.length > 0) {
        if (nextView != nil) {
            
            [nextView.pwdTextField becomeFirstResponder];
            
        }
        
    }else if ([textField.text length] == 0) {
        if (lastView != nil) {
            
            [lastView.pwdTextField becomeFirstResponder];
            
        }
    }
    
    if ([[self getPwdString]length] == self.numberOfPwdView){
    
        [textField resignFirstResponder];
        
        if (self.pwdDelegate) {
            [self.pwdDelegate finishInputPwdString:[self getPwdString]];
        }
        
    };
    
    return NO;
    
}

- (void)deleteBackward:(UITextField *)textField{
    
    FIDPwdView *lastView = self.textFieldDictonary[[NSString stringWithFormat:@"%ld",textField.tag-1]];
    
    if ([textField.text length] == 0) {
        
        if (lastView != nil) {
            [lastView.pwdTextField becomeFirstResponder];
        }
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    FIDPwdView *currentView = self.textFieldDictonary[[NSString stringWithFormat:@"%ld",textField.tag]];
    currentView.frontButton.selected = NO;
    textField.layer.borderColor = self.selectBorderColor.CGColor;
    
    textField.text = @"";
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    FIDPwdView *currentView = self.textFieldDictonary[[NSString stringWithFormat:@"%ld",textField.tag]];
    currentView.frontButton.selected = [textField.text length] == 0 ? NO : YES;
    textField.layer.borderColor = [textField.text length] == 0 ? self.normalBorderColor.CGColor : self.selectBorderColor.CGColor;
    
    
}




- (NSString *)getPwdString{
    
    NSString *pwd = [NSString string];
    for (NSInteger i = 0; i<self.numberOfPwdView; i++) {
        
        FIDPwdView *pwdView = self.textFieldDictonary[[NSString stringWithFormat:@"%ld",i]];
        pwd = [NSString stringWithFormat:@"%@%@",pwd,pwdView.pwdTextField.text];
    }
    
    return pwd;
    
}

#pragma mark - --------------------------lazy loadd--------------------------
- (NSMutableDictionary *)textFieldDictonary{
    
    if (!_textFieldDictonary) {
        
        _textFieldDictonary = [NSMutableDictionary dictionary];
        
    }
    
    return _textFieldDictonary;
    
}

- (UIColor *)normalBorderColor{
    
    if (!_normalBorderColor) {
        
        _normalBorderColor = [UIColor whiteColor];
        
    }
    
    return _normalBorderColor;
    
}

- (UIColor *)selectBorderColor{
    
    if (!_selectBorderColor) {
        
        _selectBorderColor = [UIColor blackColor];
        
    }
    
    return _selectBorderColor;
    
}

- (UIColor *)backgroundColor{
    
    if (!_backgroundColor) {
        
        _backgroundColor = [UIColor whiteColor];
        
    }
    
    return _backgroundColor;
    
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    
    _selectedImage = selectedImage;
    self.canEdit = NO;
    
}


- (void)setNormalImage:(UIImage *)normalImage{
    
    _normalImage = normalImage;
    self.canEdit = NO;
    
}

@end

