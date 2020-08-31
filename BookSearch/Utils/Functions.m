//
//  Functions.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/25.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Functions.h"
#import <UIKit/UIKit.h>

@implementation Functions


#pragma mark - plist
+ (void)saveDataToPlist:(id)data forKey:(NSString *)key {
    NSError *error = nil;
    NSData *_dataForSave = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
    [[NSUserDefaults standardUserDefaults]setObject:_dataForSave forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (id)loadDataFromPlistForKey:(NSString *)key {
    NSError *error = nil;
    NSData *_savedData = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    id data = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:_savedData error:&error];
    
    return data;
}

+ (void)removeAllDataInPlist {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *keys = [[defaults dictionaryRepresentation] allKeys];
    for(NSString *key in keys) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
}


+ (void)saveArrayToPlist:(NSMutableArray *)array forKey:(NSString *)key {
    NSError *error = nil;
    NSData *_dataForSave = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:&error];
    [[NSUserDefaults standardUserDefaults]setObject:_dataForSave forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (NSMutableArray *)loadArrayFromPlistForKey:(NSString *)key {
    NSError *error = nil;
    NSData *_savedData = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    id array = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSMutableArray class] fromData:_savedData error:&error];
    return [NSMutableArray arrayWithArray:array];
}

+ (void)removeAllObjectsInArrayFromPlistForKey:(NSString *)key {
    NSError *error = nil;
    NSData *_savedData = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSMutableArray *array = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSMutableArray class] fromData:_savedData error:&error];
    [array removeAllObjects];
    [Functions saveArrayToPlist:array forKey:key];
}

+ (void)saveSearchTextArrayToPlistWithText:(NSString *)text success:(void (^)(NSMutableArray<SearchText *> * _Nonnull))successCompletion {
    NSMutableArray<SearchText*> *arr = [self loadSearchTextArrayToPlist];
    for(int i=0; i < arr.count; i++) {
        if ([[arr objectAtIndex:i].text isEqualToString:text]) {
            [arr removeObjectAtIndex:i];
            break;
        }
    }
    [arr addObject:[[SearchText alloc] initWithSearchText:text date:[[NSDate alloc] init]]];
    [self saveSearchTextArrayToPlist:arr];
    successCompletion(arr);
}

+ (void)saveSearchTextArrayToPlist:(NSMutableArray<SearchText *> *)array {
    NSError *error = nil;
    NSData *_dataForSave = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:&error];
    [[NSUserDefaults standardUserDefaults]setObject:_dataForSave forKey:@"searchTexts"];
    if(error) {
        NSLog(@"archivedDataWithRootObject: %@", error);
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+ (NSMutableArray *)loadSearchTextArrayToPlistWithClasses:(Class)classes, ...{
    NSError *error = nil;
    NSData *_savedData = [[NSUserDefaults standardUserDefaults]objectForKey:@"searchTexts"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, classes);
    for (Class arg = classes; arg != nil; arg = va_arg(args, Class)) {
        [arr addObject:arg];
    }
    va_end(args);
    NSSet *set = [NSSet setWithArray: arr];
    id array = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:_savedData error:&error];
    if(error) {
        NSLog(@"unarchivedObjectOfClass: %@", error);
    }
    return [NSMutableArray arrayWithArray:array];
}
+ (NSMutableArray *)loadSearchTextArrayToPlist {
    NSError *error = nil;
    NSData *_savedData = [[NSUserDefaults standardUserDefaults]objectForKey:@"searchTexts"];
    NSSet *set = [NSSet setWithArray:@[[NSMutableArray class], [SearchText class]]];
    id array = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:_savedData error:&error];
    if(error) {
        NSLog(@"unarchivedObjectOfClass: %@", error);
    }
    return [NSMutableArray arrayWithArray:array];
}

+ (void)saveUserInfoDictionaryToPlist:(NSDictionary*)dic
{
    NSString* libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory , NSUserDomainMask, YES)[0];
    NSString *filePath = [libraryDir stringByAppendingPathComponent:@"userinfo.plist"];
    [dic writeToFile:filePath atomically:YES];
}

+ (NSDictionary*)loadUserInfoDictionaryToPlist
{
    NSString* libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory , NSUserDomainMask, YES)[0];
    NSString *filePath = [libraryDir stringByAppendingPathComponent:@"userinfo.plist"];
    NSDictionary* object = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return object;
}

@end


@implementation UILabel (UILabelCategory)

/**
 두 문자를 비교해서 동일한 문자에 attributed 변경
- parameters:
 - fullText: 비교할 전체 문자
 - changeText: 입력 된 문자
*/
- (void)highlight:(NSString *)fullText withChangeText:(NSString *)changeText {
     CGFloat size = self.font.pointSize;
    NSRange range = [fullText rangeOfString:changeText];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:fullText];
    [attribute addAttribute:NSForegroundColorAttributeName value:UIColor.blackColor range:range];
    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size weight:UIFontWeightMedium] range:range];
    self.attributedText = attribute;
}

@end
