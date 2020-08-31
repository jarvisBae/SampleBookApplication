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
 * @Param data  save value (id types)
 * @Param key NSString 키, 스트링일 경우는 SET_PLIST(value, key) 사용
 */
+ (void)saveDataToPlist:(id)data forKey:(NSString *)key;

/**
 * plist에 key-value로 저장된 데이터 호출
 * @Param key key값
 * @return id (id types), 없을 경우 nil
*/
+ (id)loadDataFromPlistForKey:(NSString *)key;
/// plist에 key-value로 저장된 모든 값을 초기화

/**
 * plist에 저장된 모든 데이터 삭제
*/
+ (void)removeAllDataInPlist;


//
// specify ARRAY
//
/**
 * plist에 key-value로 array 값을 저장. 내부 동작은 -saveDataToPlist:forKey: 와 완전히 동일. 캐스팅을 해줄 필요없이 사용할 수 있는 정도
 * @Param array  save value (array types)
 * @Param key NSString 키
*/
+ (void)saveArrayToPlist:(NSMutableArray *)array forKey:(NSString *)key;
/**
 * plist에 key-value로 저장된 배열값을 호출
 * @return 없을 경우 nil 이 아니라 빈 array 리턴
 * @Param key NSString 키
 */
+ (NSMutableArray *)loadArrayFromPlistForKey:(NSString *)key;

/**
 * 해당 key로 plist에 저장된 배열 비우기
 * @Param key NSString 키
*/
+ (void)removeAllObjectsInArrayFromPlistForKey:(NSString *)key;

/**
 * BookSearch 프로젝트에서 사용되는 최근 검색어 배열로 저장
 * @Param array 입력한 검색어 배열
*/
+ (void)saveSearchTextArrayToPlist:(NSMutableArray<SearchText*>*)array;

/**
 * BookSearch 프로젝트에서 사용되는 최근 검색어 배열로 저장, 추후 로컬 검색어 저장시에 활용 가능 (기존 정보 호출, 중복삭제, 저장)
 * @Param text 입력한 텍스트 정보
 * @Param successCompletion 저장 성공하면 저장된 배열 리턴
*/
+ (void)saveSearchTextArrayToPlistWithText:(NSString*)text success:(void (^)(NSMutableArray<SearchText*> *searchTexts))successCompletion;

/**
 * BookSearch 프로젝트에서 사용되는 최근 검색어 배열 호출, 추후 확장성을 위해 variable arguments 처리
 * @Param classes 저장된 배열의 class
*/
+ (NSMutableArray*)loadSearchTextArrayToPlistWithClasses:(Class)classes,...NS_REQUIRES_NIL_TERMINATION;

/**
 * BookSearch 프로젝트에서 사용되는 최근 검색어 배열 호출, 확장성 고려하지 않은 형태
*/
+ (NSMutableArray*)loadSearchTextArrayToPlist;

@end

@interface UILabel (UILabelCategory)

/**
 * 검색어와 검색된 텍스트중에 입력한 검색어 하이라이트 처리
 * @Param fullText 검색된 텍스트
 * @Param changeText 입력한 검색어 (하이라이트 처리로 변경될 검색어)
*/
- (void)highlight:(NSString *)fullText withChangeText:(NSString *)changeText;

@end

NS_ASSUME_NONNULL_END
