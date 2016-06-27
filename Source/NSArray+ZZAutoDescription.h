//
//  NSArray+ZZAutoDescription.h
//
//  Created by Ivan Zezyulya on 15.04.14.
//  Copyright (c) 2014 Ivan Zezyulya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZAutoDescriptionPrinter;

@interface NSArray (ZZAutoDescription)

- (NSString *)zz_autoDescription;
- (void)zz_autoDescribeWithPrinter:(ZZAutoDescriptionPrinter *)printer;

@end
