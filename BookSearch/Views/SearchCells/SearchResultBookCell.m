//
//  SearchResultBookCell.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/26.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "SearchResultBookCell.h"
#import "BookDisplay.h"
#import "NSCache+Instance.h"
#import "Functions.h"

@implementation SearchResultBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ivBook.layer.borderColor = UIColor.separatorColor.CGColor;
    self.ivBook.layer.borderWidth = 0.3;
}


#pragma mark - Set Data
- (void)setDisplay:(BookDisplay *)display tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
        [self.labelTitle setText:display.title];
        [self.labelSubtitle setText:display.subtitle];
        [self.labelPrice setText:display.price];
        [self.labelIsbn13 setText:display.isbn13];
        
        if (display.url != nil) {
            [self.buttonUrlLink.layer setValue:display.url forKey:@"anyKey"];
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:display.url];
            [self.buttonUrlLink setAttributedTitle:attString forState:UIControlStateNormal];
        }

        self.ivBook.image = nil;
        [self.ivBook imageDownloadWith:display.image];
}

- (void)setDisplay:(BookDisplay *)display {
    [self.labelTitle setText:display.title];
    [self.labelSubtitle setText:display.subtitle];
    [self.labelPrice setText:display.price];
    [self.labelIsbn13 setText:display.isbn13];
    
    if (display.url != nil) {
        [self.buttonUrlLink.layer setValue:display.url forKey:@"anyKey"];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:display.url];
        [self.buttonUrlLink setAttributedTitle:attString forState:UIControlStateNormal];
    }
    
    self.ivBook.image = nil;
    UIImage *cacheImage = [NSCache.manager objectForKey:display.image];
    if (cacheImage != nil) {
        self.ivBook.image = cacheImage;
    } else {
        [self.ivBook imageDownloadWith:display.image];
    }
}

#pragma mark - Button Methods
- (IBAction)urlLinkClick:(UIButton*)sender {
    NSString *url = (NSString *)[sender.layer valueForKey:@"anyKey"];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:url];
    [application openURL:URL options:@{} completionHandler:nil];
}
@end
