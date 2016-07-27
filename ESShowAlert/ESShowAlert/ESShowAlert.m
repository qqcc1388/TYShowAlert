//
//  ESShowAlert.m
//  ESShowAlert
//
//  Created by tiny on 16/7/13.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ESShowAlert.h"


#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height

#define kViewHeight         30
#define kViewWidht          kScreenWidth*0.8
#define kTopDistance        kScreenHeight*0.15
#define kCenterDistence     kScreenHeight*0.5
#define kBottomDistence     kScreenHeight*0.9

@interface ESShowAlert ()<NSCopying>

@property (nonatomic,strong)UIImageView *tipImgView;
@property (nonatomic,strong)UILabel *tipLabel;

@property (nonatomic,assign)ESShowAlertPosition showPosition;

@end

@implementation ESShowAlert

static ESShowAlert *_showAlert;

+(instancetype)shareShowAlert
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showAlert = [[self alloc] init];
    });
    return _showAlert;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_showAlert) {
        _showAlert = [super allocWithZone:zone];
    }
    return _showAlert;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _showAlert;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    //初始化UI
    self.backgroundColor = [UIColor redColor];
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
    //UIImageView
    self.tipImgView = [[UIImageView alloc] init];
    self.tipImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.tipImgView];
    
    //Label
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.textAlignment = NSTextAlignmentLeft;
    self.tipLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:self.tipLabel];
    
}

-(void)showMessage:(NSString *)message hideAfterDelay:(NSTimeInterval)delay
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //设置显示内容
    self.tipLabel.text = message;
    
    if (!self.superview) {
        [window addSubview:self];
    }
    else
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    }
    self.alpha = 1.0f;
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:delay];
}


-(void)showMessage:(NSString *)message Position:(ESShowAlertPosition)position hideAfterDelay:(NSTimeInterval)delay
{
    self.showPosition = position;
    [self showMessage:message hideAfterDelay:delay];
    
}

-(void)showMessage:(NSString *)message WithImage:(UIImage *)image Position:(ESShowAlertPosition)position hideAfterDelay:(NSTimeInterval)delay
{
    self.tipImgView.image = image;
    [self showMessage:message Position:position hideAfterDelay:delay];
}

-(void)dismiss
{
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        //默认顶部显示
        self.showPosition = ESShowAlertPositionTop;
    }] ;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat distence = 0;
    if (self.showPosition == ESShowAlertPositionTop) {
        distence = kTopDistance;
    }
    else if (self.showPosition == ESShowAlertPositionCenter)
    {
        distence = kCenterDistence;
    }else if (self.showPosition == ESShowAlertPositionBottom)
    {
        distence = kBottomDistence;
    }
    
    self.frame = CGRectMake((kScreenWidth - kViewWidht)/2,distence , kViewWidht, kViewHeight);
    //设置UIView子控件位置
    
    CGFloat margin = 4;
    CGFloat height = kViewHeight - margin*2 ;
    CGFloat labelX = 0;
    //设置ImageView
    if(self.tipImgView.image)
    {
        self.tipImgView.frame  = CGRectMake(10, margin, height,height);
        self.tipLabel.textAlignment = NSTextAlignmentLeft;
        labelX = CGRectGetMaxX(self.tipImgView.frame)+10;
    }
    else
    {
        self.tipImgView.frame = CGRectZero;
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    //设置Label
    CGFloat labelWith = kViewWidht - labelX;
    self.tipLabel.frame = CGRectMake(labelX, margin, labelWith, height);
}

@end
