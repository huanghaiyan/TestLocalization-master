//
//  ViewController.m
//  TestLocalization-master
//
//  Created by 黄海燕 on 16/8/31.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import "ViewController.h"
#import "Localisator.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(100, 100, 80, 40);
    label.text = LOCALIZATION(@"Sign In");
    
    [self.view addSubview:label];
    
    //获得当前设备的语言
    // 取得用户默认信息
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
    // 取得 iPhone 支持的所有语言设置
    NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
    NSLog (@"%@", languages);
    
    // 获得当前iPhone使用的语言
    NSString* currentLanguage = [languages objectAtIndex:0];
    NSLog(@"currentLanguage：%@",currentLanguage);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
