//
//  TCDog.h
//  RoverCodingProject
//
//  Created by Tim Carlson on 10/29/14.
//  Copyright (c) 2014 Tim Carlson. All rights reserved.
//

#import <UIKit/UIKit.h>

/** The TCDog object is a more managable object than the NSManagedObject Dog.
 */
@interface TCDog : NSObject

/** The date the object was created. */
@property (nonatomic, retain) NSDate *dateAdded;

/** The name of the dog. */
@property (nonatomic, retain) NSString *name;

/** The name of the dog's owner. */
@property (nonatomic, retain) NSString *ownerName;

/** An birth year of the dog. */
@property (nonatomic, retain) NSNumber *birthYear;

/** The breed of the dog */
@property (nonatomic, retain) NSString *breed;

// Class methods
/** A class method to returns a TCDog created with the given parameters.
 @param name The dog's name.
 @param ownerName The name of the dog's owner.
 @param birthYear The birth year of the dog.
 @param breed The breed of the dog.
 */
+ (instancetype)dogWithName:(NSString *)name ownerName:(NSString *)ownerName birthYear:(NSNumber *)birthYear breed:(NSString *)breed;

+ (instancetype)dog;

// Instance methods
/** Returns a TCDog object initialized with the given parameters.
 @param name The dog's name.
 @param ownerName The name of the dog's owner.
 @param birthYear The birth year of the dog.
 @param breed The breed of the dog.
 */
- (instancetype)initWithDogName:(NSString *)name ownerName:(NSString *)ownerName birthYear:(NSNumber *)birthYear breed:(NSString *)breed;

@end
