//
//  BookSearchPage.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultPage.h"

NS_ASSUME_NONNULL_BEGIN


@interface BookSearchPage : UITableViewController <UISearchControllerDelegate, UISearchBarDelegate, SearchResultDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchResultPage *searchResultsPage;

@end

NS_ASSUME_NONNULL_END
