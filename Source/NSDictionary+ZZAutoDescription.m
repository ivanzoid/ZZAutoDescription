//
//  NSDictionary+ZZAutoDescription.m
//
//  Created by Ivan Zezyulya on 15.04.14.
//  Copyright (c) 2014 Ivan Zezyulya. All rights reserved.
//

#import "NSDictionary+ZZAutoDescription.h"
#import "NSObject+ZZAutoDescription.h"
#import "ZZAutoDescriptionPrinter.h"

@implementation NSDictionary (ZZAutoDescription)

- (NSString *)zz_autoDescription
{
    ZZAutoDescriptionPrinter *printer = [ZZAutoDescriptionPrinter new];
    [self zz_autoDescribeWithPrinter:printer];
    NSString *result = [printer result];
    return result;
}

- (void)zz_autoDescribeWithPrinter:(ZZAutoDescriptionPrinter *)printer
{
    [printer printText:@"{"];
    
    NSArray *allKeys = [self allKeys];

    if ([allKeys count]) {
        [printer printNewLine];
        [printer increaseIndent];
    }

	for (id key in self)
    {
        [printer printIndent];

        id value = self[key];

        if ([printer isObjectInPrintedStack:value]) {
            continue;
        }

        [key zz_autoDescribeWithPrinter:printer];
        [printer printText:@" = "];
        [value zz_autoDescribeWithPrinter:printer];
        
        if ([allKeys lastObject] != key) {
            [printer printText:@","];
        }
        [printer printNewLine];
	}

    if ([allKeys count]) {
        [printer decreaseIndent];
        [printer printIndent];
    }
    [printer printText:@"}"];
}

@end
