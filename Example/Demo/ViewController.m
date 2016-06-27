//
//  ViewController.m
//  Demo
//
//  Created by Ivan Zezyulya on 05.06.14.
//  Copyright (c) 2014 Ivan Zezyulya. All rights reserved.
//

#import "ViewController.h"
#import "ZZAutoDescription.h"

@interface Product: NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSDecimalNumber *price;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSString *imageUrlString;
@property (nonatomic) NSArray *availableSizes;
@end;

@implementation Product
ZZ_AUTO_DESCRIPTION
@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];

    NSArray *array = @[ @"Hello!",
                        @"123",
                        @(123),
                        @(123LL),
                        @(123.0f),
                        @(3.14159f),
                        @(3.14159),
                        @{@"id1": @[@1, @2, @3],
                          @"id2": @[@4, @5, @6]},
                        @"Good bye!" ];

    NSLog(@"Array with Auto-Description: %@", [array zz_autoDescription]);
    NSLog(@"Array with default description: %@", array);

    Product *product1 = [Product new];
    product1.title = @"AbstractServerPermission";
    product1.price = [NSDecimalNumber decimalNumberWithString:@"42"];
    product1.quantity = 3;
    product1.imageUrlString = @"http://placekitten.com/150/150";
    product1.availableSizes = @[@"S", @"M", @"L"];

    Product *product2 = [Product new];
    product2.title = @"OptimizedMutexBuilder";
    product2.price = [NSDecimalNumber decimalNumberWithString:@"762"];
    product2.quantity = 1;
    product2.imageUrlString = @"http://placekitten.com/120/120";
    product2.availableSizes = @[@"XL"];

    Product *product3 = [Product new];
    product3.title = @"FastNodeVector";
    product3.price = [NSDecimalNumber decimalNumberWithString:@"29.5"];
    product3.quantity = 2;
    product3.imageUrlString = @"http://placekitten.com/125/125";
    product3.availableSizes = @[@"M", @"L"];

    NSArray *prices = @[product1, product2, product3];
    
    NSLog(@"Objects: %@", [prices zz_autoDescription]);

    NSLog(@"self: %@", self);
}

@end
