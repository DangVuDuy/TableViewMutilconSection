//
//  Person.m
//  TableViewMultiSection
//
//  Created by Dang Vu Duy on 1/9/16.
//  Copyright © 2016 Dang Vu Duy. All rights reserved.
//

#import "Person.h"

@implementation Person
NSArray *firstNames;
NSArray *lastNames;


-(id) init {
    
    static dispatch_once_t dispatch_Once;
    dispatch_once (&dispatch_Once, ^ {
        firstNames = @[@"Adams", @"John", @"Blake", @"Jack", @"Anna", @"Marry", @"Mariana", @"Henry", @"Madona", @"Elvis", @"Jacko", @"kenedy" ];
        lastNames = @[@"Tale", @"Johnson", @"Nickson", @"Ducati", @"Monster", @"Vancuver", @"Montoya", @"Garcia", @"Malinois", @"Francesco", @"Cudicini", @"Son", @"Philip", @"Catona"];

    });
    if (self = [super init]) {
        _name = [NSString stringWithFormat:@"%@ %@",
                 firstNames[arc4random_uniform((int)firstNames.count)],
                 lastNames[arc4random_uniform((int)lastNames.count)]];
        _age = 4 + arc4random_uniform(80);
    }
    return self;
}
@end
