//
//  BookSearchPage.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "BookSearchPage.h"
#import "ServerAPI.h"
#import "BookViewModel.h"
#import "BookTableViewCell.h"

#import "SearchTextViewModel.h"

@interface BookSearchPage ()

//@property (nonatomic, strong) BookViewModel *viewModel;
@property (nonatomic, strong) SearchTextViewModel *viewModel;

@end

@implementation BookSearchPage

#pragma mark - initialize
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.viewModel = [[SearchTextViewModel alloc] init];
    }
    return self;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO 최근 검색어 처리 / 인기 검색어 섹션 처리 3개씩
    [self configureSearchController];
    [self getData];
}

#pragma mark - Configure
- (void)configureSearchController {
    _searchResultsPage = [[SearchResultPage alloc] initWith:self.navigationController];
    _searchResultsPage.delegate = self;
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchResultsPage];
    
    self.searchController.searchBar.delegate = self;
    
    self.searchController.searchBar.placeholder = @"Apple Book";
    self.navigationItem.searchController = self.searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.definesPresentationContext = YES;
    
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.navigationController.navigationBar sizeToFit];
}

#pragma mark - Load Data
- (void)getData {
    __weak BookSearchPage *weakSelf = self;
    [self.viewModel getRecentSearchTextWithSuccess:^(NSArray<SearchTextDisplay *> * _Nonnull searchTexts) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Save Data
- (void)saveSearchText:(NSString*)text {
    __weak BookSearchPage *weakSelf = self;
    [self.viewModel saveSearchTextWithText:text success:^(NSArray<SearchTextDisplay *> * _Nonnull searchTexts) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {

    }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfItems;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell"];
    
    if (!cell) {
        assert(false);
    }
    [cell setDisplayWithSearchText:[self.viewModel itemAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = [self.viewModel itemAtIndexPath:indexPath].text;
    self.searchController.searchBar.text = text;
    [self.searchController setActive:YES];
    [self.searchController.searchBar resignFirstResponder];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.searchResultsPage updateWithQuery:text loadPage:1 searchResultType:SearchResultTypeBook];
    });
    [self saveSearchText:text];
}


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchResultsPage updateWithQuery:searchBar.text loadPage:1 searchResultType:SearchResultTypeBook];
    [self saveSearchText:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchResultsPage deleteItems];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        self.searchResultsPage.searchResultType = SearchResultTypeInput;
    } else {
        [self.searchResultsPage updateWithQuery:searchText loadPage:1 searchResultType:self.searchResultsPage.searchResultType];
    }
}

#pragma mark - SearchResult Delegate
- (void)didSelectRowWithTitle:(NSString *)title {
    self.searchController.searchBar.text = title;
    [self.searchResultsPage updateWithQuery:title loadPage:1 searchResultType:self.searchResultsPage.searchResultType];
    [self saveSearchText:title];
}

@end
