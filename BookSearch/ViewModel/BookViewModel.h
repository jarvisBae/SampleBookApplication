//
//  BookViewModel.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookViewModel : NSObject

- (void)getBooksWithQuery:(NSString *)query
                     page:(NSString*)page
              withSuccess:(void (^)(NSArray<BookDisplay*> *books, NSInteger total, NSInteger page))successCompletion
                    error:(void (^)(NSError *error))errorCompletion;

- (void)getBooksLoadmoreWithQuery:(NSString *)query
       page:(NSString*)page
withSuccess:(void (^)(NSArray<BookDisplay*> *books, NSInteger total, NSInteger page))successCompletion
      error:(void (^)(NSError *error))errorCompletion;


- (void)removeAll;
- (NSUInteger)numberOfItems;
- (NSUInteger)numberOfSections;
- (nullable BookDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
