//
//  ViewController.m
//  ESShowAlert
//
//  Created by tiny on 16/7/13.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ViewController.h"
#import "ESShowAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [[ESShowAlert shareShowAlert] showMessage:@"网络似乎有点问题呢" WithImage:[UIImage imageNamed:@"test1"] Position:ESShowAlertPositionCenter hideAfterDelay:2.0f];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
