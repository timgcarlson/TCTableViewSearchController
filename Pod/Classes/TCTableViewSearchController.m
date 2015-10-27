//
//  TCTableViewSearchController.m
//  TCTableViewSearchController
//
//  Created by Tim Carlson on 11/2/14.
//  Copyright (c) 2014 Tim Carlson. All rights reserved.
//

#import "TCTableViewSearchController.h"

@interface TCTableViewSearchController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong, readwrite) NSArray *filteredResults;

// State restoration properties
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@end

@implementation TCTableViewSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Need to set dimsBackgroundDuringPresentation to NO since the search results are presented on the same table view controller.
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    // Search delegates
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    
    self.definesPresentationContext = YES;
    
    // Scope bar (optional)
    if ([self.delegate respondsToSelector:@selector(scopeBarTitles)]) {
        NSArray *scopeBarTitles = [self.delegate scopeBarTitles];
        [self.searchController.searchBar setScopeButtonTitles:scopeBarTitles];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - UISearchControllerDelegate

- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    //NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    //NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    //NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    //NSLog(@"didDismissSearchController");
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = searchController.searchBar.text;
    
    NSString *strippedStr = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // Separated the search term by spaces
    NSArray *searchItems = nil;
    if (strippedStr.length > 0) {
        searchItems = [strippedStr componentsSeparatedByString:@" "];
    }
    
    // Prevent a retain cycle if the following completion block is assigned to a property by the user
    __weak typeof(self) weakSelf = self;

    if ([self.delegate respondsToSelector:@selector(updateSearchResultsForSearchingTableViewController:withCompletion:)]) {
        // This will be where the user updates the search predicates
        [self.delegate updateSearchResultsForSearchingTableViewController:self withCompletion:^(NSArray *items, NSArray *properties, id exampleObject) {
            __strong typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            
            NSMutableArray *searchResults = [NSMutableArray arrayWithArray:items];
            NSMutableArray *andMatchPredicates = [NSMutableArray array];
            
            for (NSString *searchString in searchItems) {
                NSMutableArray *searchItemsPredicate = [NSMutableArray array];
                
                
                // SCOPE BAR
                BOOL isUsingScopeBar = NO;
                NSMutableSet *predicatesToInclude = [NSMutableSet set];
                if (strongSelf.searchController.searchBar.scopeButtonTitles) {
                    NSUInteger scopeCount = strongSelf.searchController.searchBar.scopeButtonTitles.count;
                    if (scopeCount - 1 == properties.count) {
                        // Scope count is greater by 1 from properties count because of the "All" search that must be at the first index.
                        isUsingScopeBar = YES;
                        if (strongSelf.searchController.searchBar.selectedScopeButtonIndex == 0) {
                            // Will use all the predicates...
                            for (int i = 0; i < properties.count; i++) {
                                [predicatesToInclude addObject:@(i)];
                            }
                        } else {
                            // Will only use the predicate for property
                            [predicatesToInclude addObject:@(strongSelf.searchController.searchBar.selectedScopeButtonIndex - 1)];
                        }
                    } else {
                        @try {
                            NSException *scopeTitleException = [NSException
                                              exceptionWithName:@"Invalid Scope Bar Titles"
                                                                reason:[NSString stringWithFormat:@"Number of scope bar titles must be one greater than the number of properties that are being searched. The extra scope title is reserved for index 0, which will search all properties. (# of properties = %ld, number of scope titles = %ld", (unsigned long)properties.count, (unsigned long)scopeCount]
                                              userInfo:nil];
                            @throw scopeTitleException;
                        }
                        @catch(NSException *scopeTitleException) {
                            @throw;
                        }
                    }
                }

                
                int index, numberOfPredicates;
                if (!isUsingScopeBar || (isUsingScopeBar && strongSelf.searchController.searchBar.selectedScopeButtonIndex == 0)) {
                    // Search all properties
                    index = 0;
                    numberOfPredicates = (int)properties.count;
                } else {
                    // Search only the one property. For loop will only execute once.
                    index = (int)strongSelf.searchController.searchBar.selectedScopeButtonIndex - 1;
                    numberOfPredicates = (int)strongSelf.searchController.searchBar.selectedScopeButtonIndex;
                }

                for (int i = index; i < numberOfPredicates; i++) {
                    NSString *propertyString = properties[i];
                    
                    if ([[exampleObject valueForKey:propertyString] isKindOfClass:[NSNumber class]]) {
                        // Seaching for an EXACT number.
                        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
                        [numFormatter setNumberStyle:NSNumberFormatterNoStyle];
                        NSNumber *targetNumber = [numFormatter numberFromString:searchString];
                        
                        NSExpression *lhs = [NSExpression expressionForKeyPath:propertyString];
                        NSExpression *rhs = [NSExpression expressionForConstantValue:targetNumber];
                        NSPredicate *finalPredicate = [NSComparisonPredicate
                                                       predicateWithLeftExpression:lhs
                                                       rightExpression:rhs
                                                       modifier:NSDirectPredicateModifier
                                                       type:NSEqualToPredicateOperatorType
                                                       options:NSCaseInsensitivePredicateOption];
                        [searchItemsPredicate addObject:finalPredicate];
                    } else {
                        // Seaching for a string
                        NSExpression *lhs = [NSExpression expressionForKeyPath:propertyString];
                        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
                        NSPredicate *finalPredicate = [NSComparisonPredicate
                                                       predicateWithLeftExpression:lhs
                                                       rightExpression:rhs
                                                       modifier:NSDirectPredicateModifier
                                                       type:NSContainsPredicateOperatorType
                                                       options:NSCaseInsensitivePredicateOption];
                        [searchItemsPredicate addObject:finalPredicate];
                    }
                }
                
                
                // Add OR predicate to our master AND predicate
                NSCompoundPredicate *orMatchPredicates = (NSCompoundPredicate *)[NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
                [andMatchPredicates addObject:orMatchPredicates];
            }
            
            NSCompoundPredicate *finalCompoundPredicate = nil;
            
            // Match up the fields of the Product object
            finalCompoundPredicate = (NSCompoundPredicate *)[NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
            searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
            
            // Pass the filtered results to our search results table
            strongSelf.filteredResults = searchResults;
            [strongSelf.tableView reloadData];
        }];
    }
}


#pragma mark - UIStateRestoration

/* Restore the following items for state restoration:
 1) Search controller's active state,
 2) Search text,
 3) First responder
 */
static NSString *ViewControllerTitleKey = @"ViewControllerTitleKey";
static NSString *SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
static NSString *SearchBarTextKey = @"SearchBarTextKey";
static NSString *SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}



@end
