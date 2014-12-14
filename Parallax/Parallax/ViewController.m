//
//  ViewController.m
//  Parallax
//
//  Created by Allen Hsu on 12/15/14.
//  Copyright (c) 2014 Glow, Inc. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIView *titleContentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPages];
}

- (void)setupPages
{
    NSArray *titles = @[@"New York City",
                        @"History",
                        @"Geography",
                        @"Demographics",
                        @"Economy",
                        @"Human Resources",
                        @"Culture and Contemporary Life",
                        @"Infrastructure",
                        @"Government and Politics",
                        @"Notable People",
                        @"Global Outreach",
                        @"The End"
                        ];
    NSArray *contents = @[@"",
                          @"In the precolonial era, the area of present day New York City was inhabited by various bands of Algonquian tribes of Native Americans, including the Lenape, whose homeland, known as Lenapehoking, included Staten Island, the western portion of Long Island (including the area that would become Brooklyn and Queens), Manhattan, and the Lower Hudson Valley, including The Bronx.[66]",
                          @"New York City is in the Northeastern United States, in southeastern New York State, approximately halfway between Washington, D.C. and Boston.[120] The location at the mouth of the Hudson River, which feeds into a naturally sheltered harbor and then into the Atlantic Ocean, has helped the city grow in significance as a trading port. Most of New York City is built on the three islands of Long Island, Manhattan, and Staten Island, making land scarce and encouraging a high population density.",
                        @"New York City is the most-populous city in the United States,[198][199] with an estimated record high of 8,405,837 residents as of 2013,[1] incorporating more immigration into the city than outmigration since the 2010 United States Census.[200][201] More people live in New York City than in the next two most-populous U.S. cities (Los Angeles and Chicago) combined.[b] This amounts to about 40% of the state of New York's population and a similar percentage of the metropolitan regional population. In 2006, demographers estimated that New York's population will reach between 9.2 and 9.5 million by 2030.[204]",
                        @"New York is a global hub of international business and commerce and is one of three \"command centers\" for the world economy (along with London and Tokyo).[261] In 2012, New York City topped the first Global Economic Power Index, published by The Atlantic (to be differentiated from a namesake list published by the Martin Prosperity Institute), with cities ranked according to criteria reflecting their presence on similar lists as published by other entities.[262] The city is a major center for banking and finance, retailing, world trade, transportation, tourism, real estate, new media as well as traditional media, advertising, legal services, accountancy, insurance, theater, fashion, and the arts in the United States; while Silicon Alley, metonymous for New York's broad-spectrum high technology sphere, continues to expand. The Port of New York and New Jersey is also a major economic engine, handling record cargo volume in the first half of 2014.[263]",
                        @"The New York City Public Schools system, managed by the New York City Department of Education, is the largest public school system in the United States, serving about 1.1 million students in more than 1,700 separate primary and secondary schools.[319] The city's public school system includes nine specialized high schools to serve academically and artistically gifted students.",
                        @"New York City has been described as the cultural capital of the world by the diplomatic consulates of Iceland[13] and Latvia[14] and by New York's Baruch College.[15] A book containing a series of essays titled New York, culture capital of the world, 1940–1965 has also been published as showcased by the National Library of Australia.[16] In describing New York, author Tom Wolfe said, \"Culture just seems to be in the air, like part of the weather.\"[352]",
                        @"Mass transit in New York City, most of which runs 24 hours a day, accounts for one in every three users of mass transit in the United States, and two-thirds of the nation's rail riders live in the New York City Metropolitan Area.[411][412] The iconic New York City Subway system is the busiest in the Western Hemisphere, while Grand Central Terminal, also popularly referred to as \"Grand Central Station\", is the world's largest railway station by number of platforms.",
                        @"New York City has been a metropolitan municipality with a mayor-council form of government[457] since its consolidation in 1898. The government of New York is more centralized than that of most other U.S. cities. In New York City, the central government is responsible for public education, correctional institutions, libraries, public safety, recreational facilities, sanitation, water supply, and welfare services. The mayor and councilors are elected to four-year terms. The New York City Council is a unicameral body consisting of 51 Council members whose districts are defined by geographic population boundaries.[458] Each term for the mayor and councilors lasts four years and has a three consecutive-term limit.[459] but can run again after a four-year break.",
                        @"This list of people from New York City is a list of notable people who were either born in New York City or were adopted in New York City.",
                        @"In 2006, the Sister City Program of the City of New York, Inc. was restructured and renamed New York City Global Partners. New York City has expanded its international outreach via this program to a network of cities worldwide, promoting the exchange of ideas and innovation between their citizenry and policymakers, according to the city's website. The list of historic sister cities above was consolidated into the Global Partners network and joined by the cities below,[473] including Chongqing (Chungking), Jakarta, Kuala Lumpur and Tel Aviv (four \"non-historic\" sister cities of New York).",
                          @"Demo by Allen from Glow, Inc."
                        ];
    
    NSInteger pages = MIN(titles.count, contents.count);
    
    [self.contentWidthConstraint autoRemove];
    self.contentWidthConstraint = [self.contentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.contentScrollView withMultiplier:pages];
    [self.titleWidthConstraint autoRemove];
    self.titleWidthConstraint = [self.titleContentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.titleScrollView withMultiplier:pages];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    CGFloat titleX = 0.0;
    CGFloat contentX = 0.0;
    
    for (int i = 0; i < pages; ++i) {
        CGRect titleFrame = CGRectMake(titleX + 15.0, 50.0, self.titleScrollView.frame.size.width - 20.0, 50.0);
        UILabel *title = [[UILabel alloc] initWithFrame:titleFrame];
        title.text = titles[i];
        title.font = [UIFont fontWithName:@"Georgia" size:32.0];
        title.textColor = [UIColor whiteColor];
        title.numberOfLines = 0;
        [title sizeToFit];
        [self.titleContentView addSubview:title];
        titleX += self.titleScrollView.frame.size.width;
        
        CGFloat contentY = title.frame.origin.y + title.frame.size.height + 10.0;
        CGFloat maxHeight = self.titleScrollView.frame.size.height - contentY - 100.0;
        CGRect contentFrame = CGRectMake(contentX + 15.0, contentY, self.titleScrollView.frame.size.width - 20.0, maxHeight);
        UILabel *content = [[UILabel alloc] initWithFrame:contentFrame];
        content.text = contents[i];
        content.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
        content.textColor = [UIColor colorWithWhite:0.8 alpha:0.9];
        content.numberOfLines = 0;
        [content sizeToFit];
        if (content.frame.size.height > maxHeight) {
            content.frame = contentFrame;
        }
        [self.contentView addSubview:content];
        contentX += self.contentScrollView.frame.size.width;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.titleScrollView) {
        CGFloat contentX = self.titleScrollView.contentOffset.x / self.titleScrollView.frame.size.width * self.contentScrollView.frame.size.width;
        self.contentScrollView.contentOffset = CGPointMake(contentX, 0.0);
        CGFloat transX = self.titleScrollView.contentOffset.x / (self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width) * (self.backgroundImage.frame.size.width - self.view.frame.size.width);
        transX = MAX(0.0, transX);
        transX = MIN(self.backgroundImage.frame.size.width - self.view.frame.size.width, transX);
        self.backgroundImage.transform = CGAffineTransformMakeTranslation(-transX, 0.0);
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
