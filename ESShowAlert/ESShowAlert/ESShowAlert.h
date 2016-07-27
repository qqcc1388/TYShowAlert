//
//  ESShowAlert.h
//  ESShowAlert
//
//  Created by tiny on 16/7/13.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ESShowAlertPositionTop,
    ESShowAlertPositionCenter,
    ESShowAlertPositionBottom,
} ESShowAlertPosition;

@interface ESShowAlert : UIView

+(instancetype)shareShowAlert;



-(void)showMessage:(NSString *)message hideAfterDelay:(NSTimeInterval)delay;

-(void)showMessage:(NSString *)message Position:(ESShowAlertPosition)position hideAfterDelay:(NSTimeInterval)delay;

-(void)showMessage:(NSString *)message WithImage:(UIImage *)image  Position:(ESShowAlertPosition)position hideAfterDelay:(NSTimeInterval)delay;


@end
