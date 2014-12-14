//
//  GLPaginationThreeViewController.m
//  Pagination
//
//  Created by Allen Hsu on 12/14/14.
//  Copyright (c) 2014 Glow, Inc. All rights reserved.
//

#import "GLPaginationThreeViewController.h"
#import "Utils.h"

#define BUBBLE_DIAMETER     60.0
#define BUBBLE_PADDING      10.0

@interface GLPaginationThreeViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidthConstraint;
@end

@implementation GLPaginationThreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPages];
}

- (void)setupPages
{
    int totalNum = 100;
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    CGFloat x = (self.scrollView.frame.size.width - BUBBLE_DIAMETER) / 2.0;
    CGFloat y = (self.scrollView.frame.size.height - BUBBLE_DIAMETER) / 2.0;
    for (int i = 0; i < totalNum; ++i) {
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
        x += BUBBLE_DIAMETER + BUBBLE_PADDING;
    }
    self.contentWidthConstraint.constant = x + (self.scrollView.frame.size.width) / 2.0;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset
{
    CGFloat pageSize = BUBBLE_DIAMETER + BUBBLE_PADDING;
    NSInteger page = roundf(offset.x / pageSize);
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, offset.y);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
    targetContentOffset->x = targetOffset.x;
    targetContentOffset->y = targetOffset.y;
}

@end