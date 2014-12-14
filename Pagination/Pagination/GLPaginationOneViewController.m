//
//  GLPaginationOneViewController.m
//  Pagination
//
//  Created by Allen Hsu on 12/14/14.
//  Copyright (c) 2014 Glow, Inc. All rights reserved.
//

#import "GLPaginationOneViewController.h"
#import "Utils.h"
#import "PureLayout.h"

#define BUBBLE_DIAMETER     240.0
#define BUBBLE_PADDING      20.0

@interface GLPaginationOneViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidthConstraint;

@end

@implementation GLPaginationOneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPages];
}

- (void)setupPages
{
    int totalNum = 100;
    
    self.scrollViewWidthConstraint.constant = BUBBLE_DIAMETER + BUBBLE_PADDING;
    [self.contentWidthConstraint autoRemove];
    self.contentWidthConstraint = [self.contentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView withMultiplier:totalNum];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat y = (self.scrollView.frame.size.height - BUBBLE_DIAMETER) / 2.0;
    for (int i = 0; i < totalNum; ++i) {
        CGFloat x = BUBBLE_PADDING / 2.0 + i * (BUBBLE_DIAMETER + BUBBLE_PADDING);
        CGRect frame = CGRectMake(x, y, BUBBLE_DIAMETER, BUBBLE_DIAMETER);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"#%d", i];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = UIColorFromRGB(0x5a62d2);
        label.layer.cornerRadius = frame.size.width / 2.0;
        label.layer.masksToBounds = YES;
        label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
        [self.contentView addSubview:label];
    }
}

- (IBAction)didClickTouchTest:(id)sender {
    NSLog(@"Button works");
}

@end
