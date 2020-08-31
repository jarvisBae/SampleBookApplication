//
//  BookDetailDescCell.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "BookDetailDescCell.h"
#import "BookDetailDisplay.h"

@implementation BookDetailDescCell

#pragma mark - Set Data
- (void)setDisplay:(BookDetailDisplay *)display {
    [self.labelDesc setText:display.desc];
    [self.labelPublisher setText:display.publisher];
    [self.labelAuthors setText:display.authors];
    
    if (display.url != nil) {
        [self.buttonUrlLink.layer setValue:display.url forKey:@"anyKey"];
    }
}

#pragma mark - Button Methods
- (IBAction)noteClick:(id)sender {
    if (self.didTapButtonBlock) {
        self.didTapButtonBlock(sender);
    }
}

- (IBAction)urlLinkClick:(UIButton*)sender {
    NSString *url = (NSString *)[sender.layer valueForKey:@"anyKey"];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:url];
    [application openURL:URL options:@{} completionHandler:nil];
}
@end
