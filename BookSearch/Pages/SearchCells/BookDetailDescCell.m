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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setDisplay:(BookDetailDisplay *)display {
    [self.labelDesc setText:display.desc];
    [self.labelPublisher setText:display.publisher];
    [self.labelAuthors setText:display.authors];
    
    if (display.url != nil) {
        [self.buttonUrlLink.layer setValue:display.url forKey:@"anyKey"];
    }
}

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
