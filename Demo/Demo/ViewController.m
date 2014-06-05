//
//  ViewController.m
//  Demo
//
//  Created by Ivan Zezyulya on 05.06.14.
//  Copyright (c) 2014 Ivan Zezyulya. All rights reserved.
//

#import "ViewController.h"

#import "NSObject+AutoDescription.h"

@interface Product: NSObject
@property (nonatomic) NSNumber* totalPrice;
@property (nonatomic) NSNumber* discount;
@property (nonatomic) NSNumber* shipWeightLbs;
@property (nonatomic) NSNumber* qty;
@property (nonatomic) NSString* frontImgL;
@property (nonatomic) NSString* frontImgM;
@property (nonatomic) NSString* frontImgS;
@property (nonatomic) NSString* frontImgXS;
@property (nonatomic) NSString* prodName;
@property (nonatomic) NSString* partNb;
@property (nonatomic) NSString* pid;
@property (nonatomic) NSString* stockStatus;
@property (nonatomic) NSNumber* retailPrice;
@property (nonatomic) NSNumber* listPrice;
@property (nonatomic) NSNumber* savings;
@property (nonatomic) NSNumber* discountPct;
@property (nonatomic) NSNumber* avgRating;
@property (nonatomic) NSNumber* ratingCount;
@property (nonatomic) NSString* prodCategory;
@end;

@implementation Product
AUTO_DESCRIPTION
@end

@interface Cart : NSObject
@property (nonatomic) NSArray *products;
@end

@implementation Cart
AUTO_DESCRIPTION
@end

@implementation ViewController

- (void) viewDidLoad
{
    [super viewDidLoad];

    Cart *cart = [self makeFakeCart];

    NSLog(@"Cart: %@", cart);
}

- (Cart *) makeFakeCart
{
    NSMutableArray *products = [NSMutableArray new];
    {
        Product *product = [Product new];
        product.frontImgL = @"http://images.iherb.com/k/NOW-04753-5.jpg";
        product.frontImgXS = @"http://images.iherb.com/k/NOW-04753-5.jpg";
        product.avgRating = @(3);
        product.ratingCount = @(2292);
        product.prodName = @"Alba Botanica, Aloe & Green Tea Oil-Free Moisturizer, 3 oz (85 g) And this is a very long description.";
        product.retailPrice = @(13.92);
        product.totalPrice = @(9.15);
        product.discount = @(0.34);
        product.stockStatus = @"In Stock";
        product.pid = @"4433";
        product.qty = @(5);
        product.shipWeightLbs = @(0.34);
        [products addObject:product];
    } {
        Product *product = [Product new];
        product.frontImgL = @"http://images.iherb.com/k/NOW-04753-5.jpg";
        product.frontImgXS = @"http://images.iherb.com/k/NOW-04753-5.jpg";
        product.avgRating = @(5);
        product.ratingCount = @(99542);
        product.prodName = @"Now Foods, Shea Butter, 7 fl oz (207 ml)";
        product.retailPrice = @(990.24);
        product.totalPrice = @(1468.67);
        product.stockStatus = @"Out Of Stock";
        product.pid = @"2345";
        product.qty = @(1);
        product.shipWeightLbs = nil;
        [products addObject:product];
    } {
        Product *product = [Product new];
        product.frontImgL = @"http://images.iherb.com/k/NOW-04753-5.jpg";
        product.frontImgXS = @"http://images.iherb.com/k/NOW-04753-5.jpg";
        product.avgRating = @(0);
        product.ratingCount = @(0);
        product.prodName = @"Now Foods, Shea Butter, 7 fl oz (207 ml) Alba Botanica, Aloe & Green Tea Oil-Free Moisturizer, 3 oz (85 g) And this is a very long description.";
        product.retailPrice = nil;
        product.totalPrice = @(1.03);
        product.discount = @(0.34);
        product.stockStatus = @"In Stock";
        product.pid = @"235462475673545";
        product.qty = @(2);
        product.shipWeightLbs = nil;
        [products addObject:product];
    } {
        Product *product = [Product new];
        product.frontImgL = @"http://images.iherb.com/k/NOW-04753-5.jpg";
        product.frontImgXS = @"http://images.iherb.com/k/NOW-04753-5.jpg";
        product.avgRating = @(1);
        product.ratingCount = @(1);
        product.prodName = nil;
        product.retailPrice = @(1.03);
        product.totalPrice = nil;
        product.stockStatus = @"Out Of Stock";
        product.pid = @"1";
        product.qty = @(1);
        product.shipWeightLbs = @(42);
        [products addObject:product];
    }
    
    Cart *cart = [Cart new];
    cart.products = products;
    
    return cart;
}

@end
