//
//  Localisator.m
//  TestLocalization-master
//
//  Created by 黄海燕 on 16/8/31.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import "Localisator.h"

@interface Localisator()

@property (nonatomic,strong) NSDictionary * dicLocalisation;


@end

@implementation Localisator

#pragma  mark - Singleton Method
+ (Localisator *)sharedInstance
{
    static Localisator *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[Localisator alloc]init];
    });
    return _sharedInstance;
}

- (id)init
{
    if (self = [super init]) {
        _availableLanguagesArray = @[@"nl-NL", @"en"];
        _saveInUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageUserDefaultKey];
        
        self.dicLocalisation = nil;
        NSString * languageSaved = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageUserDefaultKey];
        self.currentLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
        if (languageSaved && ![languageSaved isEqualToString:[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0]])
        {
            [self loadDictionaryForLanguage:languageSaved];
        }

    }
    return self;
}

-(void)setSaveInUserDefaults:(BOOL)saveInUserDefaults
{
    _saveInUserDefaults = saveInUserDefaults;
    if(_saveInUserDefaults && self.currentLanguage)
    {
        [[NSUserDefaults standardUserDefaults] setObject:self.currentLanguage forKey:LanguageUserDefaultKey];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LanguageUserDefaultKey];
    }
}

#pragma mark - Private  Instance methods

-(BOOL)loadDictionaryForLanguage:(NSString *)newLanguage
{
    NSURL *urlPath = [[NSBundle mainBundle] URLForResource:@"Localizable" withExtension:@"strings" subdirectory:nil localization:newLanguage];
    if ([[NSFileManager defaultManager] fileExistsAtPath:urlPath.path]) {
        self.currentLanguage = [newLanguage copy];
        self.dicLocalisation = [[NSDictionary dictionaryWithContentsOfFile:urlPath.path] copy];
        return YES;
    }
    return NO;
}

#pragma mark - Public Instance methods

-(NSString *)localizedStringForKey:(NSString*)key
{
    if (self.dicLocalisation == nil) {
        return NSLocalizedString(key, key);
    }else{
        NSString *localizedString = self.dicLocalisation[key];
        if (localizedString == nil)
            localizedString = key;
            return localizedString;
    }
}

-(BOOL)setLanguage:(NSString *)newLanguage
{
    if (newLanguage == nil || [newLanguage isEqualToString:self.currentLanguage] || ![self.availableLanguagesArray containsObject:newLanguage]) {
        return NO;
    }
    BOOL isLoadingOk = [self loadDictionaryForLanguage:newLanguage];
    if (isLoadingOk) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLanguageChanged object:nil];
    }
    return isLoadingOk;
}

@end
