//
//  YQInputPasswordView.h
//  YQCustomKeyboard
//
//  Created by 杨清 on 2018/9/18.
//  Copyright © 2018年 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQInputPasswordView : UIView

@property (strong, nonatomic) UILabel *titleLab;
@property (copy, nonatomic) void (^clickCancelBlock)(void);
@property (copy, nonatomic) void (^clickConfirmBlock)(NSString *text);


@end
