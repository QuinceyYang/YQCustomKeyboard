//
//  YQCustomKeyboardView.m
//  YQCustomKeyboard
//
//  Created by 杨清 on 2018/8/8.
//  Copyright © 2018年 Soargift. All rights reserved.
//

#import "YQCustomKeyboardView.h"

//#define kCustomKeyboardHeight ([UIScreen mainScreen].bounds.size.width>375?200:176)
static CGFloat kCustomKeyboardHeight = 176;
#define kCharacterList  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"]
#define kProvinceList   @[@"京",@"沪",@"粤",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"桂",@"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"港",@"澳"]
#define kPasswordList  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]
#define kCalculateArr @[@"C",@"(",@")",@"÷",@"7",@"8",@"9",@"×",@"4",@"5",@"6",@"+",@"1",@"2",@"3",@"-",@"%",@"0",@".",@"="]

@interface YQCustomKeyboardView ()

@property (copy, nonatomic) NSArray <NSString *>*keysArr;

@property (nonatomic, assign) YQCustomKeyboardViewType keyboardType;

@end


@implementation YQCustomKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kCustomKeyboardHeight);
        
    }
    return self;
}

+ (instancetype)keyboardWithType:(YQCustomKeyboardViewType)keyboardType delegate:(id <YQCustomKeyboardViewDelegate>)delegate
{
    kCustomKeyboardHeight = UIScreen.mainScreen.bounds.size.width>375?200:176;
    if (keyboardType == YQCustomKeyboardViewTypeCalculator) {
        if (UIScreen.mainScreen.bounds.size.width < 375) {//5s
            kCustomKeyboardHeight = 302;
        }
        else if (UIScreen.mainScreen.bounds.size.width < 414) {//6s
            kCustomKeyboardHeight = 353;
        }
        else {
            kCustomKeyboardHeight = 383;
        }
        kCustomKeyboardHeight += 44;
    }
    YQCustomKeyboardView *keyboardView = [[YQCustomKeyboardView alloc] init];
    keyboardView.delegate = delegate;
    keyboardView.keyboardType = keyboardType;
    return keyboardView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)reloadKeyboardWithKeys:(NSArray <NSString *>*)keysArr
{
    self.keysArr = keysArr;
    
}

#pragma mark - setter getter
- (void)setKeyboardType:(YQCustomKeyboardViewType)keyboardType
{
    _keyboardType = keyboardType;
    
    switch (keyboardType) {
        case YQCustomKeyboardViewTypeDefault:
        {
            //
            {
                NSArray *keyArr = kCharacterList;
                UIControl *containerView = [[UIControl alloc] initWithFrame:self.bounds];
                containerView.backgroundColor = [UIColor colorWithRed:207/255.0 green:212/255.0 blue:217/255.0 alpha:1];
                containerView.tag = 10000;
                [self addSubview:containerView];
                CGFloat leftEdgeInsets = 12;
                CGFloat spacing = 4;
                CGFloat btnWidth = (containerView.frame.size.width-2*leftEdgeInsets-9*spacing)/10;
                CGFloat tmpY = 10;
                CGFloat btnHeight = (containerView.frame.size.height-10-8-3*5)/4;
                for (NSInteger i=0; i<10 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+i*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 2000+i;
                    [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-10*btnWidth-9*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=10; i<20 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-10)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 2000+i;
                    [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-9*btnWidth-8*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=20; i<29 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-20)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 2000+i;
                    [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-7*btnWidth-6*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=29; i<36 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-29)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 2000+i;
                    [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                //切换键盘
                UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, tmpY, leftEdgeInsets-12-spacing, btnHeight)];
                [changeBtn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [changeBtn setTitle:[NSString stringWithFormat:@"%@",@"切换"] forState:UIControlStateNormal];
                [changeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [changeBtn addTarget:self action:@selector(tapChangeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:changeBtn];
                self.changeBtn = changeBtn;
                //删除按钮
                UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width-12-50, tmpY, 50, btnHeight)];
                [delBtn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [delBtn setTitle:[NSString stringWithFormat:@"%@",@"删除"] forState:UIControlStateNormal];
                [delBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [delBtn addTarget:self action:@selector(tapDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:delBtn];
                self.deleteBtn = delBtn;
            }

            //省简称
            {
                NSArray *keyArr = kProvinceList;
                UIControl *containerView = [[UIControl alloc] initWithFrame:self.bounds];
                containerView.backgroundColor = [UIColor colorWithRed:209/255.0 green:214/255.0 blue:219/255.0 alpha:1];
                [self addSubview:containerView];
                CGFloat leftEdgeInsets = 12;
                CGFloat spacing = 4;
                CGFloat btnWidth = (containerView.frame.size.width-2*leftEdgeInsets-9*spacing)/10;
                CGFloat tmpY = 10;
                CGFloat btnHeight = (containerView.frame.size.height-10-8-3*5)/4;
                for (NSInteger i=0; i<10 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+i*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 1000+i;
                    [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-9*btnWidth-8*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=10; i<19 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-10)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 1000+i;
                    [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-8*btnWidth-7*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=19; i<27 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-19)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 1000+i;
                    [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-6*btnWidth-5*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=27; i<33 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-27)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 1000+i;
                    [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                //切换键盘
                UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, tmpY, 50, btnHeight)];
                [changeBtn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [changeBtn setTitle:[NSString stringWithFormat:@"%@",@"切换"] forState:UIControlStateNormal];
                [changeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [changeBtn addTarget:self action:@selector(tapChangeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:changeBtn];
                self.secondChangeBtn = changeBtn;
                //删除按钮
                UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width-12-50, tmpY, 50, btnHeight)];
                [delBtn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [delBtn setTitle:[NSString stringWithFormat:@"%@",@"删除"] forState:UIControlStateNormal];
                [delBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [delBtn addTarget:self action:@selector(tapDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:delBtn];
                self.secondDeleteBtn = delBtn;
            }

        }
            break;
        case YQCustomKeyboardViewTypeProvince:
        {
            //省简称
            NSArray *keyArr = kProvinceList;
            UIControl *containerView = [[UIControl alloc] initWithFrame:self.bounds];
            containerView.backgroundColor = [UIColor colorWithRed:209/255.0 green:214/255.0 blue:219/255.0 alpha:1];
            [self addSubview:containerView];
            CGFloat leftEdgeInsets = 12;
            CGFloat spacing = 4;
            CGFloat btnWidth = (containerView.frame.size.width-2*leftEdgeInsets-9*spacing)/10;
            CGFloat tmpY = 10;
            CGFloat btnHeight = (containerView.frame.size.height-10-8-3*5)/4;
            for (NSInteger i=0; i<10 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+i*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 1000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = (containerView.frame.size.width-9*btnWidth-8*spacing)/2;
            tmpY += btnHeight+5;
            for (NSInteger i=10; i<19 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-10)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 1000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = (containerView.frame.size.width-8*btnWidth-7*spacing)/2;
            tmpY += btnHeight+5;
            for (NSInteger i=19; i<27 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-19)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 1000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = (containerView.frame.size.width-6*btnWidth-5*spacing)/2;
            tmpY += btnHeight+5;
            for (NSInteger i=27; i<33 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-27)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 1000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            //删除按钮
            UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width-12-50, tmpY, 50, btnHeight)];
            [delBtn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
            [delBtn setTitle:[NSString stringWithFormat:@"%@",@"删除"] forState:UIControlStateNormal];
            [delBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [delBtn addTarget:self action:@selector(tapDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
            [containerView addSubview:delBtn];
            self.deleteBtn = delBtn;
        }
            break;
        case YQCustomKeyboardViewTypeCharacter:
        {
            //字符键盘A~Z 0~9
            NSArray *keyArr = kCharacterList;
            UIControl *containerView = [[UIControl alloc] initWithFrame:self.bounds];
            containerView.backgroundColor = [UIColor colorWithRed:207/255.0 green:212/255.0 blue:217/255.0 alpha:1];
            containerView.tag = 10000;
            [self addSubview:containerView];
            CGFloat leftEdgeInsets = 12;
            CGFloat spacing = 4;
            CGFloat btnWidth = (containerView.frame.size.width-2*leftEdgeInsets-9*spacing)/10;
            CGFloat tmpY = 10;
            CGFloat btnHeight = (containerView.frame.size.height-10-8-3*5)/4;
            for (NSInteger i=0; i<10 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+i*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 2000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = (containerView.frame.size.width-10*btnWidth-9*spacing)/2;
            tmpY += btnHeight+5;
            for (NSInteger i=10; i<20 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-10)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 2000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = (containerView.frame.size.width-9*btnWidth-8*spacing)/2;
            tmpY += btnHeight+5;
            for (NSInteger i=20; i<29 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-20)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 2000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = (containerView.frame.size.width-7*btnWidth-6*spacing)/2;
            tmpY += btnHeight+5;
            for (NSInteger i=29; i<36 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-29)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 2000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            //删除按钮
            UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width-12-50, tmpY, 50, btnHeight)];
            [delBtn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
            [delBtn setTitle:[NSString stringWithFormat:@"%@",@"删除"] forState:UIControlStateNormal];
            [delBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [delBtn addTarget:self action:@selector(tapDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
            [containerView addSubview:delBtn];
            self.deleteBtn = delBtn;
        }
            break;
            
        case YQCustomKeyboardViewTypePassword:
        {
            //数字键盘0~9
            NSArray *keyArr = kPasswordList;
            UIControl *containerView = [[UIControl alloc] initWithFrame:self.bounds];
            containerView.backgroundColor = [UIColor colorWithRed:207/255.0 green:212/255.0 blue:217/255.0 alpha:1];
            containerView.tag = 10000;
            [self addSubview:containerView];
            CGFloat leftEdgeInsets = 0;
            CGFloat spacing = 1;
            CGFloat btnWidth = (containerView.frame.size.width-2*leftEdgeInsets-2*spacing)/3;
            CGFloat tmpY = 0;
            CGFloat btnHeight = (containerView.frame.size.height-3*1)/4;
            for (NSInteger i=0; i<3 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+i*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 2000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = 0;
            tmpY += btnHeight+1;
            for (NSInteger i=3; i<6 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-3)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 2000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = 0;
            tmpY += btnHeight+1;
            for (NSInteger i=6; i<9 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-6)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 2000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
            leftEdgeInsets = btnWidth+1;
            tmpY += btnHeight+1;
            CGFloat tmpX = 0.0;            
            for (NSInteger i=9; i<10 && i<keyArr.count; i++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-9)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                btn.tag = 2000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
                tmpX = CGRectGetMaxX(btn.frame);
            }
            //删除按钮
            UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(tmpX+1, tmpY, btnWidth, btnHeight)];
            [delBtn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
            [delBtn setTitle:[NSString stringWithFormat:@"%@",@"删除"] forState:UIControlStateNormal];
            [delBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [delBtn addTarget:self action:@selector(tapDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
            [containerView addSubview:delBtn];
            self.deleteBtn = delBtn;
        }
            break;

        case YQCustomKeyboardViewTypeCalculator:
        {
            //
            NSArray *keyArr = kCalculateArr;
            UIControl *containerView = [[UIControl alloc] initWithFrame:self.bounds];
            containerView.backgroundColor = [UIColor colorWithRed:207/255.0 green:212/255.0 blue:217/255.0 alpha:1];
            //containerView.tag = 10000;
            [self addSubview:containerView];
            
            CGFloat spacing = 0.5;
            CGFloat btnWidth = (containerView.frame.size.width-3*spacing)/4;
            CGFloat btnHeight = (containerView.frame.size.height-44-5*spacing)/5;
            
            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, 44)];
            topView.backgroundColor = UIColor.whiteColor;
            [containerView addSubview:topView];
            //删除按钮
            UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width-btnWidth, 0, btnWidth, 44)];
            [delBtn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
            [delBtn setTitle:[NSString stringWithFormat:@"%@",@"删除"] forState:UIControlStateNormal];
            [delBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [delBtn addTarget:self action:@selector(tapDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
            [containerView addSubview:delBtn];
            self.deleteBtn = delBtn;
            
            CGFloat tmpY = 44.5;
            for (NSInteger i=0; i<keyArr.count; i++) {
                CGFloat x = (i%4)*(btnWidth+spacing);
                CGFloat y = tmpY + (i-i%4)/4*(btnHeight+spacing);
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, btnWidth, btnHeight)];
                btn.tag = 1000+i;
                [btn setBackgroundImage:[[self class] imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
                [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:btn];
            }
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - actions

- (void)tapInputKey:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(customKeyboardInputKey:)]) {
        [self.delegate customKeyboardInputKey:[sender titleForState:UIControlStateNormal]];
    }
}
- (void)tapDeleteKey:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(customKeyboardDeleteKey)]) {
        [self.delegate customKeyboardDeleteKey];
    }
}

- (void)tapChangeKeyboard:(UIButton *)sender
{
    NSLog(@"Change Keyboard");
    [self sendSubviewToBack:sender.superview];
}

- (void)changeCharacterTypeToFirst
{
    if (_keyboardType == YQCustomKeyboardViewTypeDefault) {
        if ([self viewWithTag:10000]) {
            [self bringSubviewToFront:[self viewWithTag:10000]];
        }
    }
}

- (void)changeProvinceTypeToFirst
{
    if (_keyboardType == YQCustomKeyboardViewTypeDefault) {
        if ([self viewWithTag:10000]) {
            [self sendSubviewToBack:[self viewWithTag:10000]];
        }
    }
}

#pragma mark - 通过颜色来生成一个纯色图片, size = 1*1
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
