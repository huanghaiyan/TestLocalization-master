//
//  Localisator.h
//  TestLocalization-master
//
//  Created by 黄海燕 on 16/8/31.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LOCALIZATION(text) [[Localisator sharedInstance] localizedStringForKey:(text)]

#define LanguageUserDefaultKey @"LanguageUserDefaultKey"
static NSString * const kNotificationLanguageChanged = @"kNotificationLanguageChanged";

@interface Localisator : NSObject

@property (nonatomic, readonly) NSArray* availableLanguagesArray;
@property (nonatomic, assign) BOOL saveInUserDefaults;
@property NSString * currentLanguage;

+(Localisator *)sharedInstance;
-(NSString *)localizedStringForKey:(NSString *)key;
-(BOOL)setLanguage:(NSString *)newLanguage;

@end
