//
//  TCDog.m
//  RoverCodingProject
//
//  Created by Tim Carlson on 10/29/14.
//  Copyright (c) 2014 Tim Carlson. All rights reserved.
//

#import "TCDog.h"

@implementation TCDog

+ (instancetype)dogWithName:(NSString *)name ownerName:(NSString *)ownerName birthYear:(NSNumber *)birthYear breed:(NSString *)breed {
    TCDog *aDog = [[TCDog alloc] initWithDogName:name ownerName:ownerName birthYear:birthYear breed:breed];
    return aDog;
}

+ (instancetype)dog {
    TCDog *aDog = [[TCDog alloc] initWithDogName:@"" ownerName:@"" birthYear:@(0) breed:@""];
    return aDog;
}

- (instancetype)initWithDogName:(NSString *)name ownerName:(NSString *)ownerName birthYear:(NSNumber *)birthYear breed:(NSString *)breed {
    if (self = [super init]) {
        self.name = name;
        self.ownerName = ownerName;
        self.birthYear = birthYear;
        self.dateAdded = [NSDate date];
        self.breed = breed;
    }
    return self;
}

@end
