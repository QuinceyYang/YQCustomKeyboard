//
//  ViewController.m
//  YQCustomKeyboard
//
//  Created by 杨清 on 2018/9/13.
//  Copyright © 2018年 QuinceyYang. All rights reserved.
//

#import "ViewController.h"
#import "YQInputCarnumberView.h"
#import "YQCustomKeyboardView.h"
#import "YQInputPasswordView.h"

@interface ViewController () <YQCustomKeyboardViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    switch (3) {
        case 1:
        {
            YQInputCarnumberView *inputCarnumberView = [[YQInputCarnumberView alloc] init];
            inputCarnumberView.titleLab.text = @"请输入车牌号";
            inputCarnumberView.newpowerCarBtnIv.image = [UIImage imageNamed:@"icon_add"];
            [self.view addSubview:inputCarnumberView];
        }
            break;
        case 2:
        {
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 90, 200, 44)];
            _textField.borderStyle = UITextBorderStyleLine;
            _textField.placeholder = @"请输入";
            _textField.inputView = [YQCustomKeyboardView keyboardWithType:YQCustomKeyboardViewTypeDefault delegate:self];
            _textField.delegate = self;
            [self.view addSubview:_textField];
        }
            break;
        case 3:
        {
            YQInputPasswordView *inputPasswordView = [[YQInputPasswordView alloc] init];
            [self.view addSubview:inputPasswordView];
        }
            break;
        case 4:
        {
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 90, UIScreen.mainScreen.bounds.size.width-40, 44)];
            _textField.borderStyle = UITextBorderStyleLine;
            _textField.placeholder = @"请输入";
            _textField.inputView = [YQCustomKeyboardView keyboardWithType:YQCustomKeyboardViewTypeCalculator delegate:self];
            _textField.delegate = self;
            [self.view addSubview:_textField];
        }
            break;

        default:
            break;
    }
    
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - < YQCustomKeyboardViewDelegate >
- (void)customKeyboardInputKey:(NSString *)key
{
    NSLog(@"key = %@",key);
    if (self.textField.text) {
        self.textField.text = [self.textField.text stringByAppendingString:key];
    }
    else {
        self.textField.text = key;
    }
    
}

- (void)customKeyboardDeleteKey
{
    if (self.textField.text) {
        if (self.textField.text.length>0) {
            self.textField.text = [self.textField.text substringToIndex:self.textField.text.length-1];
        }
    }
    else {
    }
}

@end
