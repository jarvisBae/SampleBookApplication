//
//  BookDetailViewModel.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookDetailViewModel : NSObject

- (void)getBookDetailWithBookId:(NSString *)isbn13
              withSuccess:(void (^)(BookDetailDisplay *bookDetail))successCompletion
                    error:(void (^)(NSError *error))errorCompletion;


- (NSUInteger)numberOfItems;
- (NSUInteger)numberOfSections;
- (nullable BookDetailDisplay *)item;

@end

NS_ASSUME_NONNULL_END
