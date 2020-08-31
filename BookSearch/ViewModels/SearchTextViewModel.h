//
//  SearchMainViewModel.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/29.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchTextDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchTextViewModel : NSObject

- (void)getRecentSearchTextWithSuccess:(void (^)(NSArray<SearchTextDisplay*> *searchTexts))successCompletion
                                 error:(void (^)(NSError *error))errorCompletion;
- (void)saveSearchTextWithText:(NSString*)text
                       success:(void (^)(NSArray<SearchTextDisplay*> *searchTexts))successCompletion
                         error:(void (^)(NSError *error))errorCompletion;

- (NSUInteger)numberOfItems;
- (NSUInteger)numberOfSections;
- (nullable SearchTextDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
