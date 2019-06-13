//
//  YQInputCarnumberView.m
//  YQCustomKeyboard
//
//  Created by 杨清 on 2018/9/13.
//  Copyright © 2018年 QuinceyYang. All rights reserved.
//


#import "YQInputCarnumberView.h"
#import "YQCustomKeyboardView.h"

@interface YQInputCarnumberView () <YQCustomKeyboardViewDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSMutableArray <UILabel *>*labelArr;

@end

@implementation YQInputCarnumberView

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
        titleLab.text = @"车位号：----";
        titleLab.textColor = UIColor.blackColor;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont boldSystemFontOfSize:17];
        [inputView addSubview:titleLab];
        self.titleLab = titleLab;
        
        //***
        UIControl *maskView = [[UIControl alloc] initWithFrame:CGRectMake(12,CGRectGetMaxY(titleLab.frame)+20,inputView.frame.size.width-24,50)];
        maskView.backgroundColor = UIColor.whiteColor;
        [maskView addTarget:self action:@selector(tapMaskView:) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:maskView];
        //***/

        {
            UIView *markView = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(titleLab.frame)+20, 70, 50)];
            markView.layer.borderColor = [UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:1].CGColor;
            markView.layer.borderWidth = 0.667;
            markView.userInteractionEnabled = NO;
            [inputView addSubview:markView];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(35, 4, 0.667, 42)];
            line.backgroundColor = [UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:1];
            [markView addSubview:line];
        }
        _labelArr = [[NSMutableArray alloc] init];
        for (NSInteger i=0; i<8; i++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(titleLab.frame)+20, 35, 50)];
            lab.textColor = UIColor.blackColor;
            lab.font = [UIFont boldSystemFontOfSize:17];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.layer.borderWidth = 0.667;
            lab.layer.borderColor = [UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:1].CGColor;
            lab.userInteractionEnabled = NO;
            [_labelArr addObject:lab];
            CGRect frame = lab.frame;
            if (i==0) {
                frame.origin.x = 12;
            }
            else if (i==1) {
                frame.origin.x = CGRectGetMaxX(_labelArr[0].frame);//_labelArr[0].maxX;
            }
            else if (i==2) {
                frame.origin.x = CGRectGetMaxX(_labelArr[1].frame)+8;//_labelArr[1].maxX+8;
            }
            else {
                frame.origin.x = CGRectGetMaxX(_labelArr[i-1].frame)+5;//_labelArr[i-1].maxX+5;
            }
            lab.frame = frame;
            [inputView addSubview:lab];
        }
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelArr.firstObject.frame), _labelArr.firstObject.frame.origin.y, 10, 10)];
        tf.textColor = UIColor.clearColor;
        tf.tintColor = UIColor.clearColor;
        tf.font = [UIFont systemFontOfSize:5];
        tf.inputView = [YQCustomKeyboardView keyboardWithType:YQCustomKeyboardViewTypeDefault delegate:self];
        [inputView addSubview:tf];
        [inputView sendSubviewToBack:tf];
        self.textField = tf;
        [self.textField becomeFirstResponder];
        //
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
        
        _labelArr.lastObject.hidden = YES;
        UIControl *newpowerCarBtn = [[UIControl alloc] initWithFrame:_labelArr.lastObject.frame];
        newpowerCarBtn.backgroundColor = UIColor.whiteColor;
        newpowerCarBtn.layer.borderWidth = 0.667;
        newpowerCarBtn.layer.borderColor = [UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:1].CGColor;
        //[newpowerCarBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        //[newpowerCarBtn setTitle:@"新能源" forState:UIControlStateNormal];
        //[newpowerCarBtn setTitleColor:[UIColor colorWithRed:152.0/255.0 green:153.0/255.0 blue:154.0/255.0 alpha:1] forState:UIControlStateNormal];
        //newpowerCarBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [newpowerCarBtn addTarget:self action:@selector(tapEnableNewpowerCar:) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:newpowerCarBtn];
        {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, newpowerCarBtn.frame.size.width, 0.55*newpowerCarBtn.frame.size.height-6)];
            iv.contentMode = UIViewContentModeCenter;
            [newpowerCarBtn addSubview:iv];
            self.newpowerCarBtnIv = iv;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.55*newpowerCarBtn.frame.size.height, newpowerCarBtn.frame.size.width, 0.45*newpowerCarBtn.frame.size.height-4)];
            lab.text = @"新能源";
            lab.textColor = [UIColor colorWithRed:152.0/255.0 green:153.0/255.0 blue:154.0/255.0 alpha:1];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:11];
            [newpowerCarBtn addSubview:lab];
            self.newpowerCarBtnLab = lab;
        }
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 137, 100, 45)];
        cancelBtn.layer.cornerRadius = 3;
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.backgroundColor = [UIColor colorWithRed:231/255.0 green:232/255.0 blue:233/255.0 alpha:1];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(tapCancel:) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:cancelBtn];
        cancelBtn.frame = CGRectOffset(cancelBtn.frame, inputView.frame.size.width/2-20-cancelBtn.frame.size.width, 0);
        //cancelBtn.x = inputView.width/2-20-cancelBtn.width;
        
        UIButton *comfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 137, 100, 45)];
        comfirmBtn.layer.cornerRadius = 3;
        comfirmBtn.layer.masksToBounds = YES;
        comfirmBtn.backgroundColor = [UIColor colorWithRed:252/255.0 green:167/255.0 blue:57/255.0 alpha:1];
        [comfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [comfirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [comfirmBtn addTarget:self action:@selector(tapConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:comfirmBtn];
        comfirmBtn.frame = CGRectOffset(comfirmBtn.frame, inputView.frame.size.width/2+20, 0);
        //comfirmBtn.x = inputView.width/2+20;
        
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

#pragma mark - Observer (UITextFieldTextDidChangeNotification)
- (void)textFieldEditChanged:(NSNotification *)notification
{
    NSLog(@"notification = %@", notification);
    UITextField *textField = (UITextField *)notification.object;
    if (textField == self.textField) {
        //NSInteger count = self.labelArr.lastObject.hidden==NO?self.labelArr.count:self.labelArr.count-1;
        //[YQTools limitChatCount:notification length:count];
    }
    
}

#pragma mark - < YQCustomKeyboardViewDelegate >
- (void)customKeyboard:(YQCustomKeyboardView *)keyboardView inputKey:(NSString *)key
{
    NSLog(@"key = %@",key);
    NSInteger count = self.labelArr.lastObject.hidden==NO?self.labelArr.count:self.labelArr.count-1;
    if (self.textField.text.length == count) {
        return;
    }
    if (self.textField.text) {
        self.textField.text = [self.textField.text stringByAppendingString:key];
    }
    else {
        self.textField.text = [@"" stringByAppendingString:key];
    }
    NSInteger i=self.textField.text.length-1;
    UILabel *lab = self.labelArr[i];
    lab.text = key;
    NSLog(@"self.textField.text = %@",self.textField.text);
    //{ fix bug yqing
    if (self.textField.text.length == 1) {
        [(YQCustomKeyboardView *)self.textField.inputView changeCharacterTypeToFirst];
    }
    //}
}

- (void)customKeyboardDeleteKey:(YQCustomKeyboardView *)keyboardView
{
    if (self.textField.text.length <= 0) {
        return;
    }
    NSInteger count = self.labelArr.lastObject.hidden==NO?self.labelArr.count:self.labelArr.count-1;
    if (self.textField.text.length > count) {
        return;
    }
    NSInteger i = self.textField.text.length-1;
    self.labelArr[i].text = nil;
    self.textField.text = [self.textField.text substringToIndex:self.textField.text.length-1];
    NSLog(@"self.textField.text = %@",self.textField.text);
    //{ fix bug yqing
    if (self.textField.text.length <= 0) {
        [(YQCustomKeyboardView *)self.textField.inputView changeProvinceTypeToFirst];
    }
    //}
}

#pragma mark - actions
- (void)tapBackground:(UITapGestureRecognizer *)sender
{
    //NSLog(@"sender = %@",sender);
    [self removeFromSuperview];
}

//
- (void)tapEnableNewpowerCar:(UIButton *)sender
{
    [sender removeFromSuperview];
    _labelArr.lastObject.hidden = NO;
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
    NSString *text = @"";
    for (NSInteger i=0; i<self.labelArr.count; i++) {
        if (self.labelArr[i].text.length>0) {
            text = [text stringByAppendingString:self.labelArr[i].text];
        }
    }
    if (self.clickConfirmBlock) {
        self.clickConfirmBlock(text);
    }
    [self removeFromSuperview];
}

- (void)tapMaskView:(id)sender
{
    //[sender.view resignFirstResponder];
    [self.textField becomeFirstResponder];
}

#pragma mark -
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"已销毁!");
}


@end
