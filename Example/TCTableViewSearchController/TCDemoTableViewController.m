//
//  TCDemoTableViewController.m
//  TCSearchingTableViewController
//
//  Created by Tim Carlson on 11/2/14.
//  Copyright (c) 2014 Tim Carlson. All rights reserved.
//

#import "TCDemoTableViewController.h"
#import "TCDog.h"

@implementation TCDemoTableViewController

- (void)viewDidLoad {
    self.delegate = self;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (!self.searchController.active) ? self.dogArray.count : self.filteredResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCDog *dog = (!self.searchController.active) ? self.dogArray[indexPath.row] : self.filteredResults[indexPath.row];
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forDog:dog];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: This should be handled by the TCSeachingTableViewController (either by it or the delegate). Could provide a method for checking if searching is active or not.
    TCDog *selectedDog = (!self.searchController.active) ? self.dogArray[indexPath.row] : self.filteredResults[indexPath.row];
    
    NSLog(@"Selected dog name: %@", selectedDog.name);
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)configureCell:(UITableViewCell *)cell forDog:(TCDog *)dog {
    cell.textLabel.text = dog.name;
    
    NSString *detailedString = [NSString stringWithFormat:@"%@ | Born in %@ | Owned by %@" , dog.breed, [dog.birthYear stringValue], dog.ownerName];
    cell.detailTextLabel.text = detailedString;
}

#pragma mark - TCSearchingTableViewControllerDelegate

- (void)updateSearchResultsForSearchingTableViewController:(TCTableViewSearchController *)searchingTableViewController withCompletion:(TCSearchBlock)completion {
    
    NSArray *propertiesArray = [NSArray arrayWithObjects:@"name", @"breed", @"ownerName", @"birthYear", nil];
    completion(self.dogArray, propertiesArray, [TCDog dog]);
}

- (NSArray *)scopeBarTitles {
    return @[@"All", @"Name", @"Breed", @"Owner", @"Birth Year"];
}

@end
