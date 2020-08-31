//
//  BookDetailPage.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "BookDetailPage.h"
#import "BookDetailViewModel.h"
#import "BookDetailSummayCell.h"
#import "BookDetailDescCell.h"
#import "MemoPage.h"

@interface BookDetailPage ()

@property (nonatomic, strong) BookDetailViewModel *viewModel;
@property (nonatomic, strong) NSString *isbn13;

@end


@implementation BookDetailPage

#pragma mark - initialize
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.viewModel = [[BookDetailViewModel alloc] init];
    }
    return self;
}

- (instancetype)initWith:(NSString *)isbn13 {
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"BookDetailPage"];
    self.isbn13 = isbn13;
    return self;
}

#pragma mark - View Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTableView];
    [self getBookDetailWithIsbn13:self.isbn13];
}

#pragma mark - Configure
- (void)configureTableView {
    self.tableView.separatorColor = [UIColor clearColor];
}

#pragma mark - Load Data
- (void)getBookDetailWithIsbn13:(NSString*)isbn13 {
    __weak BookDetailPage *weakSelf = self;
    [self.viewModel getBookDetailWithBookId:isbn13 withSuccess:^(BookDetailDisplay * _Nonnull bookDetail) {
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
    if (indexPath.row == 0) {
        BookDetailSummayCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailSummayCell"];
        [cell setDisplay:[self.viewModel item]];
        return cell;
    } else {
        BookDetailDescCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailDescCell"];
        [cell setDisplay:[self.viewModel item]];
        [cell setDidTapButtonBlock:^(id  _Nonnull sender) {
            MemoPage *memoPage = [[MemoPage alloc] initWith:self.isbn13];
            [self.navigationController showDetailViewController:memoPage sender:nil];
        }];
        return cell;
    }
}
@end
