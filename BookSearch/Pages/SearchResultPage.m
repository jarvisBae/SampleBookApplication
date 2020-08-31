//
//  SearchResultPage.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/25.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "SearchResultPage.h"
#import "BookViewModel.h"
#import "SearchResultCell.h"
#import "SearchResultBookCell.h"
#import "BookDetailPage.h"

@interface SearchResultPage ()

@property (nonatomic, strong) BookViewModel *viewModel;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation SearchResultPage

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.viewModel = [[BookViewModel alloc] init];
    }
    return self;
}

- (instancetype)initWith:(UINavigationController *)navigationController {
    self = [[SearchResultPage alloc] init];
    self.navigationController = navigationController;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureTableView];
    if (self.viewModel == nil) {
        self.searchResultType = SearchResultTypeInput;
        self.viewModel = [[BookViewModel alloc] init];
    }
}

- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchResultCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SearchResultCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchResultBookCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SearchResultBookCell class])];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)updateWithQuery:(NSString *)query loadPage:(NSInteger)page searchResultType:(SearchResultType)type {
    _query = query;
    _searchResultType = type;
    
    __weak SearchResultPage *weakSelf = self;
    [self.viewModel getBooksWithQuery:query page:[@(page) stringValue] withSuccess:^(NSArray<BookDisplay *> * _Nonnull books, NSInteger total, NSInteger _page) {
        weakSelf.total = total;
        weakSelf.page = _page+1;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

- (void)loadMore {
    __weak SearchResultPage *weakSelf = self;
    [self.viewModel getBooksLoadmoreWithQuery:self.query page:[NSString stringWithFormat: @"%ld", (long)self.page] withSuccess:^(NSArray<BookDisplay *> * _Nonnull books, NSInteger total, NSInteger page) {
        weakSelf.total = total;
        weakSelf.page = page+1;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {

    }];
}

- (void)deleteItems {
    self.searchResultType = SearchResultTypeInput;
    [self.viewModel removeAll];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cellInput;
    SearchResultBookCell *cellBook;
    switch (self.searchResultType) {
        case SearchResultTypeInput:
            cellInput =  (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SearchResultCell class])];

            if (!cellInput) {
                assert(false);
            }

            [cellInput setDisplay:[self.viewModel itemAtIndexPath:indexPath] setText:self.query];
            return cellInput;
        case SearchResultTypeBook:
            cellBook =  (SearchResultBookCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SearchResultBookCell class])];

            if (!cellBook) {
                assert(false);
            }
            [cellBook setDisplay:[self.viewModel itemAtIndexPath:indexPath] tableView:tableView indexPath:indexPath];
            return cellBook;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.searchResultType) {
        case SearchResultTypeInput:
            return UITableViewAutomaticDimension;
        case SearchResultTypeBook:
            return 130;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        // This is the last cell
        if ((int)self.total/((int)self.page*10) > 10) {
            [self loadMore];
        }
    }
}


#pragma mark - TODO : 클릭하면 searchbar + query 업데이트
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title;
    switch (self.searchResultType) {
        case SearchResultTypeInput:
            self.searchResultType = SearchResultTypeBook;
            title = [self.viewModel itemAtIndexPath:indexPath].title;
            [self.viewModel removeAll];
            [self.tableView reloadData];
            [self.delegate didSelectRowWithTitle:title];
            break;
        case SearchResultTypeBook:
            [self.navigationController pushViewController:[[BookDetailPage alloc] initWith:[self.viewModel itemAtIndexPath:indexPath].isbn13] animated:YES];
            break;
    }
}


@end
