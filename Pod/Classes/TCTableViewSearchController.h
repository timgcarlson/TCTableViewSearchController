//
//  TCTableViewSearchController.h
//  TCTableViewSearchController
//
//  Created by Tim Carlson on 11/2/14.
//  Copyright (c) 2014 Tim Carlson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCTableViewSearchController;

/** A block to handle the searching of a TCTableViewSearchController.
 
 @param items The original items in the table that will be searched.
 @param properties The properties to search amongst in the each of the objects in the items parameter. Pass a string representation of the property. Can search NSString or NSNumber properties.
 @param exampleObject Pass an instance of the object that will be searched. This should be the same object that is contained in the items parameter, and is used to look up the class type of the given property (eg. if the property is an NSNumber or NSString).
 
 */
typedef void (^TCSearchBlock)(NSArray *items, NSArray *properties, id exampleObject);

/** The delegate of a TCTableViewSearchController must adopt the TCTableViewSearchController protocol. Required methods of the protocol allow the delegate to get the list of objects to search among and which properties to search in those objects.
 */
@protocol TCTableViewSearchControllerDelegate <NSObject>

@required

/** Called when the search bar becomes the first responder or when the user makes changes inside the search bar. (required)
 
 @description This method is automatically called whenever the search bar becomes the first responder or changes are made to the text or scope of the search bar.
 @param searchingTableViewController The TCTableViewSearchController object used as the searching table-view.
 @param completion The TCSearchBlock to execute upon completion. This block's parameters are required to search the table view.
 */
- (void)updateSearchResultsForSearchingTableViewController:(TCTableViewSearchController *)searchingTableViewController withCompletion:(TCSearchBlock)completion;

@optional

/** Called when the view is loaded, so must set scope titles after this is done. Implementing this method will make the scope bar active. (optional)
 
 @description When the view is loaded, the scope bar titles will be created with this array. The first title is reserved for searching all properties at the time of search.
 @warning The number of scope titles must be one more than the number of properties that are being filtered in the search, where the first scope title is the one that includes all properties (ie. "All").
 @returns An NSArray that includes the scope titles for the search bar. Count of this array is required to be exactly one more than the number of properties that are being searched.
 @see required delegate method updateSearchResultsForSearchingTableViewController:
 @throws An exception if the number of scope titles is not one greater than the number of properties being searched (to account for the scope title at index 0, which searches all properties.
 */
- (NSArray *)scopeBarTitles;

@end


@interface TCTableViewSearchController : UITableViewController

/** The searching table view controller's delegate. 
 
 @warning Set this property before TCTableViewSearchController's viewDidLoad is called to ensure delegate methods can run as expected. */
@property (nonatomic, assign) id <TCTableViewSearchControllerDelegate> delegate;

/** The search bar controller for the master table view. */
@property (nonatomic, strong) UISearchController *searchController;

/** An array with the filtered search results that should be displayed for the current search value (readonly). */
@property (nonatomic, strong, readonly) NSArray *filteredResults;

@end
