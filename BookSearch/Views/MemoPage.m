//
//  MemoPage.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/31.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "MemoPage.h"
#import "Functions.h"

@interface MemoPage ()

@property (nonatomic, strong) NSString *isbn13;

@end

@implementation MemoPage

#pragma mark - initialize
- (instancetype)initWith:(NSString *)isbn13 {
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MemoPage"];
    self.isbn13 = isbn13;
    return self;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString* memo = [Functions loadDataFromPlistForKey:self.isbn13];
    if (memo != nil) {
        self.tvMemo.text = memo;
    }
}

#pragma mark - Button Methods
- (IBAction)saveClick:(id)sender {
    NSString *text = self.tvMemo.text;
    if (text.length > 0) {
        [Functions saveDataToPlist:text forKey: self.isbn13];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
