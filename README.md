# TCTableViewSearchController

[![CI Status](http://img.shields.io/travis/Tim G Carlson/TCTableViewSearchController.svg?style=flat)](https://travis-ci.org/Tim G Carlson/TCTableViewSearchController)
[![Version](https://img.shields.io/cocoapods/v/TCTableViewSearchController.svg?style=flat)](http://cocoadocs.org/docsets/TCTableViewSearchController)
[![License](https://img.shields.io/cocoapods/l/TCTableViewSearchController.svg?style=flat)](http://cocoadocs.org/docsets/TCTableViewSearchController)
[![Platform](https://img.shields.io/cocoapods/p/TCTableViewSearchController.svg?style=flat)](http://cocoadocs.org/docsets/TCTableViewSearchController)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TCTableViewSearchController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "TCTableViewSearchController"

Create a subclass of TCTableViewSearchController (or present it as you would any other view controller) and go about creating your table view like you normally would had you subclassed UITableViewController. Declare that your class adopts the protocol in the class definition (TCTableViewSearchControllerDelegate). **Your table must be generated from objects that have properties. Currently you cannot have a table where the data source is an array of strings.** 

Then perform the following steps:


**1) Accessing the correct item or item count** 

In any UITableViewDataSource or UITableViewDelegate method that acts on an object at an index path or needs an item count, you will need to determine whether to use you main data source or the `filteredResults` data source. You can do this by checking whether the search bar is currently active.

```objective-c

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (!self.searchController.active) {
    // return the count of your main data source
  } else {
    // return the count of the filteredResults property of TCTableViewSearchController
  }
}

```

**2) Implement the required delegate methods of TCTableViewSearchControllerDelegate.** 

To keep things simple, there is only one method required to search object data in your table. You will need to provide the objects to search, the properties (in the form of strings in an array) that you want to be searched for each object, and the object that contains these properties. The example object is needed to determine the type of the property, which it has to be a NSString or NSNumber.

```objective-c

- (void)updateSearchResultsForSearchingTableViewController:(TCTableViewSearchController *)searchingTableViewController withCompletion:(TCSearchBlock)completion {
  // Provide the properties of the objects in the table that you wish to search. Currently only supports NSStrings and NSNumbers.
  NSArray *propertiesArray = [NSArray arrayWithObjects:@"name", @"breed", @"ownerName", @"birthYear", nil]; // These are the properties of the TCDog object represented in string form
  completion(self.dogArray, propertiesArray, [TCDog dog]);  // The data source, the properties to search, and an example object that will be searched.
}

```

**3) (optional) Implement scope bar.**

If a scope bar is desired, then you will likely be searching two or more properties of the object. So if you are searching four properties in the required delegate method `updateSearchResultsForSearchingTableViewController:`, then you will need to create five titles for the scope bar where the first title in the scope title array is the "Search All" scope. Each additional scope should correspond with the order of properties that are being searched (an exception will be thrown otherwise). 

```objective-c

- (NSArray *)scopeBarTitles {
  return @[@"All", @"Name", @"Breed", @"Owner", @"Birth Year"];
}

```

Implementing this method will create the scope bar for you, no other action is needed.

## Author

Tim G Carlson, timgcarlson@gmail.com

## License

TCTableViewSearchController is available under the MIT license. See the LICENSE file for more info.

