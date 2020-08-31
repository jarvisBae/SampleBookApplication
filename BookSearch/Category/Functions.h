//
//  Functions.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/25.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchText.h"

NS_ASSUME_NONNULL_BEGIN

@interface Functions : NSObject


#pragma mark - plist
// ----------------------------------------------------------------------------------------------------
// use plist for save&load
//
// general
//
/**
 * plist에 key-value로 NSString이 아닌 value값을 저장.
 * @Param key 스트링일 경우는 SET_PLIST(value, key) 사용
 */
+ (void)saveDataToPlist:(id)data forKey:(NSString *)key;
+ (id)loadDataFromPlistForKey:(NSString *)key;
/// plist에 key-value로 저장된 모든 값을 초기화
+ (void)removeAllDataInPlist;
//
// specify ARRAY
//
/// 내부 동작은 -saveDataToPlist:forKey: 와 완전히 동일. 캐스팅을 해줄 필요없이 사용할 수 있는 정도
+ (void)saveArrayToPlist:(NSMutableArray *)array forKey:(NSString *)key;
/**
 * @return 없을 경우 nil 이 아니라 빈 array 리턴
 * @Param key NSString 키
 */
+ (NSMutableArray *)loadArrayFromPlistForKey:(NSString *)key;
/// 해당 key로 plist에 저장된 배열 비우기
+ (void)removeAllObjectsInArrayFromPlistForKey:(NSString *)key;

+ (void)saveSearchTextArrayToPlist:(NSMutableArray<SearchText*>*)array;
+ (void)saveSearchTextArrayToPlistWithText:(NSString*)text withSuccess:(void (^)(NSMutableArray<SearchText*> *searchTexts))successCompletion;
+ (NSMutableArray*)loadSearchTextArrayToPlistWithClasses:(Class)classes,...NS_REQUIRES_NIL_TERMINATION;
+ (NSMutableArray*)loadSearchTextArrayToPlist;

+ (void)saveUserInfoDictionaryToPlist:(NSDictionary*)dic;
+ (NSDictionary*)loadUserInfoDictionaryToPlist;

@end

@interface UILabel (UILabelCategory)

- (void)highlight:(NSString *)fullText withChangeText:(NSString *)changeText;       //하이라이트 처리

@end

NS_ASSUME_NONNULL_END
