//
//  TCDemoTableViewController.h
//  TCSearchingTableViewController
//
//  Created by Tim Carlson on 11/2/14.
//  Copyright (c) 2014 Tim Carlson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TCTableViewSearchController/TCTableViewSearchController.h>

static NSString * const kCellIdentifier = @"Cell";

@interface TCDemoTableViewController : TCTableViewSearchController <TCTableViewSearchControllerDelegate>

@property (nonatomic, strong) NSArray *dogArray;

@end
