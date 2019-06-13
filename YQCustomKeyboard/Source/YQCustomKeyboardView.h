//
//  YQCustomKeyboardView.h
//  YQCustomKeyboard
//
//  Created by 杨清 on 2018/8/8.
//  Copyright © 2018年 Soargift. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YQCustomKeyboardViewType) {
    YQCustomKeyboardViewTypeDefault     = 0, //第一个是省键盘，第二个是字符与数字键盘
    YQCustomKeyboardViewTypeProvince    = 1, //省简称
    YQCustomKeyboardViewTypeCharacter   = 2,  //字符与数字键盘
    YQCustomKeyboardViewTypePassword    = 3,  //密码键盘0~9
    YQCustomKeyboardViewTypeCalculator  = 4,  //计算器键盘
};

@class YQCustomKeyboardView;

@protocol YQCustomKeyboardViewDelegate <NSObject>
@required
- (void)customKeyboard:(YQCustomKeyboardView *)keyboardView inputKey:(NSString *)key;
- (void)customKeyboardDeleteKey:(YQCustomKeyboardView *)keyboardView;
@end

@interface YQCustomKeyboardView : UIView

@property (strong, nonatomic) UIButton *changeBtn;///< 切换按钮
@property (strong, nonatomic) UIButton *deleteBtn;///< 删除按钮
@property (strong, nonatomic) UIButton *secondChangeBtn;///< 切换按钮
@property (strong, nonatomic) UIButton *secondDeleteBtn;///< 删除按钮

@property (weak, nonatomic) id <YQCustomKeyboardViewDelegate> delegate;

+ (instancetype)keyboardWithType:(YQCustomKeyboardViewType)keyboardType delegate:(id <YQCustomKeyboardViewDelegate>)delegate;

- (void)changeCharacterTypeToFirst;
- (void)changeProvinceTypeToFirst;
@end

