//
//  YQInputCarnumberView.h
//  YQCustomKeyboard
//
//  Created by 杨清 on 2018/8/27.
//  Copyright © 2018年 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQInputCarnumberView : UIView

@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIImageView *newpowerCarBtnIv;///< 使能新能源车按钮的image，可以修改风格
@property (strong, nonatomic) UILabel *newpowerCarBtnLab;///< 使能新能源车按钮的label，可以修改风格
@property (copy, nonatomic) void (^clickCancelBlock)(void);
@property (copy, nonatomic) void (^clickConfirmBlock)(NSString *text);


@end
