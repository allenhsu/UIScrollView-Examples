//
//  ViewController.m
//  Reuse
//
//  Created by Allen Hsu on 12/14/14.
//  Copyright (c) 2014 Glow, Inc. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"
#import "GLReusableViewController.h"

#define TOTAL_PAGES     10

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidthConstraint;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *navScrollView;
@property (weak, nonatomic) IBOutlet UIView *navContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navContentWidthConstraint;

@property (strong, nonatomic) NSNumber *currentPage;

@property (strong, nonatomic) NSMutableArray *reusableViewControllers;
@property (strong, nonatomic) NSMutableArray *visibleViewControllers;

@end

@implementation ViewController

- (NSMutableArray *)reusableViewControllers
{
    if (!_reusableViewControllers) {
        _reusableViewControllers = [NSMutableArray array];
    }
    return _reusableViewControllers;
}

- (NSMutableArray *)visibleViewControllers
{
    if (!_visibleViewControllers) {
        _visibleViewControllers = [NSMutableArray array];
    }
    return _visibleViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPages];
    [self loadPage:0];
}

- (void)setupPages
{
    [self.contentWidthConstraint autoRemove];
    self.contentWidthConstraint = [self.contentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView withMultiplier:TOTAL_PAGES];
    [self.navContentWidthConstraint autoRemove];
    self.navContentWidthConstraint = [self.navContentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.navScrollView withMultiplier:TOTAL_PAGES];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    CAGradientLayer *l = [CAGradientLayer layer];
    l.frame = self.titleView.bounds;
    l.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
    l.startPoint = CGPointMake(0.0f, 0.5f);
    l.endPoint = CGPointMake(1.0f, 0.5f);
    self.titleView.layer.mask = l;
    
    CGFloat x = 0;
    for (int i = 0; i < TOTAL_PAGES; ++i) {
        CGRect frame = CGRectMake(x, 0.0, self.navScrollView.frame.size.width, self.navScrollView.frame.size.height - 10.0);
        UILabel *title = [[UILabel alloc] initWithFrame:frame];
        title.text = [NSString stringWithFormat:@"#%d", i];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor blackColor];
        title.font = [UIFont boldSystemFontOfSize:14.0];
        [self.navContentView addSubview:title];
        x += self.navScrollView.frame.size.width;
    }
    
    self.pageControl.numberOfPages = TOTAL_PAGES;
}

- (void)setCurrentPage:(NSNumber *)currentPage
{
    if (_currentPage != currentPage) {
        _currentPage = currentPage;
        self.pageControl.currentPage = [currentPage integerValue];
    }
}

- (void)loadPage:(NSInteger)page
{
    if (self.currentPage && page == [self.currentPage integerValue]) {
        return;
    }
    self.currentPage = @(page);
    NSMutableArray *pagesToLoad = [@[@(page), @(page - 1), @(page + 1)] mutableCopy];
    NSMutableArray *vcsToEnqueue = [NSMutableArray array];
    for (GLReusableViewController *vc in self.visibleViewControllers) {
        if (!vc.page || ![pagesToLoad containsObject:vc.page]) {
            [vcsToEnqueue addObject:vc];
        } else if (vc.page) {
            [pagesToLoad removeObject:vc.page];
        }
    }
    for (GLReusableViewController *vc in vcsToEnqueue) {
        [vc.view removeFromSuperview];
        [self.visibleViewControllers removeObject:vc];
        [self enqueueReusableViewController:vc];
    }
    for (NSNumber *page in pagesToLoad) {
        [self addViewControllerForPage:[page integerValue]];
    }
}

- (void)enqueueReusableViewController:(GLReusableViewController *)viewController
{
    [self.reusableViewControllers addObject:viewController];
}

- (GLReusableViewController *)dequeueReusableViewController
{
    static int numberOfInstance = 0;
    GLReusableViewController *vc = [self.reusableViewControllers firstObject];
    if (vc) {
        [self.reusableViewControllers removeObject:vc];
    } else {
        vc = [GLReusableViewController viewControllerFromStoryboard];
        vc.numberOfInstance = numberOfInstance;
        numberOfInstance++;
        [vc willMoveToParentViewController:self];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
    return vc;
}

- (void)addViewControllerForPage:(NSInteger)page
{
    if (page < 0 || page >= TOTAL_PAGES) {
        return;
    }
    GLReusableViewController *vc = [self dequeueReusableViewController];
    vc.page = @(page);
    vc.view.frame = CGRectMake(self.scrollView.frame.size.width * page, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.contentView addSubview:vc.view];
    [self.visibleViewControllers addObject:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        CGFloat navX = scrollView.contentOffset.x / scrollView.frame.size.width * self.navScrollView.frame.size.width;
        self.navScrollView.contentOffset = CGPointMake(navX, 0.0);
        NSInteger page = roundf(scrollView.contentOffset.x / scrollView.frame.size.width);
        page = MAX(page, 0);
        page = MIN(page, TOTAL_PAGES - 1);
        [self loadPage:page];
    }
}

@end
