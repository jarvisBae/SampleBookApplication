//
//  SearchMainViewModel.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/29.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SearchTextViewModel.h"
#import "SearchTextDisplay.h"
#import "Functions.h"

@interface SearchTextViewModel()

@property (nonatomic, strong) NSMutableArray<SearchTextDisplay *> *items;

@end

@implementation SearchTextViewModel

#pragma mark - initialize
- (instancetype)init {
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Load Data
- (void)getRecentSearchTextWithSuccess:(void (^)(NSArray<SearchTextDisplay *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSMutableArray *arr = [Functions loadSearchTextArrayToPlistWithClasses:[NSMutableArray class], [SearchText class], nil];
    NSArray *reversedArray = [[arr reverseObjectEnumerator] allObjects];
    for (SearchText *searchText in reversedArray) {
        [items addObject: [[SearchTextDisplay alloc] initWithSearchText:searchText]];
    }
    [self setItems:items];
    successCompletion(items);
}

- (void)saveSearchTextWithText:(NSString *)text success:(void (^)(NSArray<SearchTextDisplay *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    
    [Functions saveSearchTextArrayToPlistWithText:text success:^(NSMutableArray<SearchText *> * _Nonnull searchTexts) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        NSArray *reversedArray = [[searchTexts reverseObjectEnumerator] allObjects];
        for (SearchText *searchText in reversedArray) {
            [items addObject: [[SearchTextDisplay alloc] initWithSearchText:searchText]];
        }
        [self setItems:items];
        successCompletion(items);
    }];
}

- (NSUInteger)numberOfItems {
    return self.items.count;
}

- (NSUInteger)numberOfSections {
    return 1;
}

- (SearchTextDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.items.count) {
        return nil;
    }
    return self.items[indexPath.row];
}

@end
