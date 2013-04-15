//
//  CBCocktailViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 16/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailViewController.h"
#import "CBCocktailIngredientsController.h"
#import "CBCocktailMethodController.h"
#import "CBCocktailSimilarController.h"

static NSUInteger kNumberOfPages = 2;

@interface CBCocktailViewController ()

@end

@implementation CBCocktailViewController

@synthesize viewControllers, scrollView, pageControl;
@synthesize ingredientsController, methodController, similarController;

@synthesize cocktail;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavTitle];
    [self preparePageControl];
    //[self setFavouriteButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavTitle
{
    [self.navigationItem setTitle:self.cocktail.name];
    
    UILabel* tlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    tlabel.text = self.navigationItem.title;
    tlabel.textColor = [UIColor whiteColor];
    tlabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 20.0];
    tlabel.backgroundColor = [UIColor clearColor];
    tlabel.adjustsFontSizeToFitWidth = YES;
    tlabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = tlabel;
}

- (void)setFavouriteButton
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"heart.png"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(changeFavouriteState)];
    if (cocktail.isFavourite)
        [rightButton setImage:[UIImage imageNamed:@"heart-red.png"]];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
}

- (void)changeFavouriteState
{
    if (cocktail.isFavourite) {
        cocktail.isFavourite = NO;
    } else {
        cocktail.isFavourite = YES;
    }
    
    [self setFavouriteButton];
}

#pragma mark - PageControl shiznit
- (void)preparePageControl
{    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
   
    for (unsigned i = 0; i < kNumberOfPages; i++) {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    
    // replace the placeholder if necessary
    UIViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        if (page==0) {
            controller = [[CBCocktailIngredientsController alloc] initWithCocktail:cocktail];
        } else if (page==1) {
            controller = [[CBCocktailMethodController alloc] initWithCocktail:cocktail];
        } else if (page==2) {
            controller = [[CBCocktailSimilarController alloc] initWithCocktail:cocktail];
        }
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
    
    /*
    // change the title
    if (page==0) {
        [self.navigationItem setTitle:@"Ingredients"];
    } else if (page==1) {
        [self.navigationItem setTitle:@"Method"];
    }
     */
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

@end
