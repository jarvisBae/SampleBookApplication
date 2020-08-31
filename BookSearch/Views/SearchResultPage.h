//
//  SearchResultPage.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/25.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    SearchResultTypeInput = 0,
    SearchResultTypeBook = 1
} SearchResultType;


@protocol SearchResultDelegate <NSObject>

@optional
- (void)didSelectRowWithTitle:(NSString *)title;
@end

@interface SearchResultPage : UITableViewController

- (instancetype)initWith:(UINavigationController*)navigationController;
- (void)updateWithQuery:(NSString *)query loadPage:(NSInteger)page searchResultType:(SearchResultType)type;
- (void)loadMore;
- (void)deleteItems;

@property (assign, nonatomic) SearchResultType searchResultType;
@property (nonatomic, assign) id<SearchResultDelegate> delegate;
@property (nonatomic, strong) NSString *query;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger page;

@end

NS_ASSUME_NONNULL_END
