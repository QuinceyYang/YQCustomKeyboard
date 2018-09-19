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
};

@protocol YQCustomKeyboardViewDelegate <NSObject>
@required
- (void)customKeyboardInputKey:(NSString *)key;
- (void)customKeyboardDeleteKey;
@end


@interface YQCustomKeyboardView : UIView

@property (weak, nonatomic) id <YQCustomKeyboardViewDelegate> delegate;

+ (instancetype)keyboardWithType:(YQCustomKeyboardViewType)keyboardType delegate:(id <YQCustomKeyboardViewDelegate>)delegate;

- (void)changeCharacterTypeToFirst;
- (void)changeProvinceTypeToFirst;
@end
