//
//  YQInputPasswordView.m
//  YQCustomKeyboard
//
//  Created by 杨清 on 2018/9/18.
//  Copyright © 2018年 QuinceyYang. All rights reserved.
//

#import "YQInputPasswordView.h"
#import "YQCustomKeyboardView.h"

#define kPasswordLength     (6)

@interface YQInputPasswordView () <YQCustomKeyboardViewDelegate>

@property (strong, nonatomic) NSMutableArray <UILabel *>*labelArr;
@property (copy, nonatomic) NSString *passwordStr;
@end

@implementation YQInputPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(12, 175, [UIScreen mainScreen].bounds.size.width-25, 200)];
        inputView.backgroundColor = UIColor.whiteColor;
        [self addSubview:inputView];
        inputView.layer.cornerRadius = 6;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, inputView.frame.size.width, 22)];
        titleLab.text = @"请输入密码";
        titleLab.textColor = UIColor.blackColor;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont boldSystemFontOfSize:17];
        [inputView addSubview:titleLab];
        self.titleLab = titleLab;
        
        CGFloat leftOffset = (inputView.frame.size.width-kPasswordLength*35-(kPasswordLength-1)*10)/2;
        _labelArr = [[NSMutableArray alloc] init];
        for (NSInteger i=0; i<kPasswordLength; i++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(leftOffset+i*(35+10), CGRectGetMaxY(titleLab.frame)+20, 35, 50)];
            lab.textColor = UIColor.blackColor;
            lab.font = [UIFont boldSystemFontOfSize:18];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.layer.borderWidth = 0.667;
            lab.layer.borderColor = [UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:1].CGColor;
            lab.userInteractionEnabled = NO;
            [_labelArr addObject:lab];
            [inputView addSubview:lab];
        }
        
        YQCustomKeyboardView *keyboardView = [YQCustomKeyboardView keyboardWithType:YQCustomKeyboardViewTypePassword delegate:self];
        [self addSubview:keyboardView];
        keyboardView.frame = CGRectOffset(keyboardView.frame, 0, [UIScreen mainScreen].bounds.size.height-keyboardView.frame.size.height);

        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 137, 100, 45)];
        cancelBtn.layer.cornerRadius = 3;
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.backgroundColor = [UIColor colorWithRed:231/255.0 green:232/255.0 blue:233/255.0 alpha:1];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(tapCancel:) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:cancelBtn];
        cancelBtn.frame = CGRectOffset(cancelBtn.frame, inputView.frame.size.width/2-20-cancelBtn.frame.size.width, 0);
        
        UIButton *comfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 137, 100, 45)];
        comfirmBtn.layer.cornerRadius = 3;
        comfirmBtn.layer.masksToBounds = YES;
        comfirmBtn.backgroundColor = [UIColor colorWithRed:252/255.0 green:167/255.0 blue:57/255.0 alpha:1];
        [comfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [comfirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [comfirmBtn addTarget:self action:@selector(tapConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:comfirmBtn];
        comfirmBtn.frame = CGRectOffset(comfirmBtn.frame, inputView.frame.size.width/2+20, 0);
        
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


#pragma mark - < YQCustomKeyboardViewDelegate >
- (void)customKeyboard:(YQCustomKeyboardView *)keyboardView inputKey:(NSString *)key
{
    NSLog(@"key = %@",key);
    if (_passwordStr) {
        if (_passwordStr.length >= kPasswordLength) {
            NSLog(@"密码已满");
            return;
        }
        _passwordStr = [_passwordStr stringByAppendingString:key];
    }
    else {
        _passwordStr = key;
    }
    NSLog(@"_passwordStr = %@",_passwordStr);
    _labelArr[_passwordStr.length-1].text = @"●";
}

- (void)customKeyboardDeleteKey:(YQCustomKeyboardView *)keyboardView
{
    if (_passwordStr.length <= 0) {
        NSLog(@"密码已空");
        return;
    }
    _labelArr[_passwordStr.length-1].text = @"";
    _passwordStr = [_passwordStr substringToIndex:_passwordStr.length-1];
    NSLog(@"_passwordStr = %@",_passwordStr);
}

#pragma mark - actions
- (void)tapBackground:(UITapGestureRecognizer *)sender
{
    //NSLog(@"sender = %@",sender);
    [self removeFromSuperview];
}


- (void)tapCancel:(UIButton *)sender
{
    if (self.clickCancelBlock) {
        self.clickCancelBlock();
    }
    [self removeFromSuperview];
}

- (void)tapConfirm:(UIButton *)sender
{
    NSString *text = _passwordStr.length>0 ? _passwordStr : @"";
    if (self.clickConfirmBlock) {
        self.clickConfirmBlock(text);
    }
    [self removeFromSuperview];
}


#pragma mark -
- (void)dealloc {
}


@end
