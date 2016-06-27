//
//  NSArray+ZZAutoDescription.m
//
//  Created by Ivan Zezyulya on 15.04.14.
//  Copyright (c) 2014 Ivan Zezyulya. All rights reserved.
//

#import "NSArray+ZZAutoDescription.h"
#import "ZZAutoDescriptionPrinter.h"

@implementation NSArray (ZZAutoDescription)

- (NSString *)zz_autoDescription
{
    ZZAutoDescriptionPrinter *printer = [ZZAutoDescriptionPrinter new];
    [self zz_autoDescribeWithPrinter:printer];
    NSString *result = [printer result];
    return result;
}

- (void)zz_autoDescribeWithPrinter:(ZZAutoDescriptionPrinter *)printer
{
    [printer printText:@"["];
    
    if ([self count]) {
        [printer printNewLine];
        [printer increaseIndent];
    }

	for (id object in self)
    {
        [printer printIndent];
        [object zz_autoDescribeWithPrinter:printer];
        
        if ([self lastObject] != object) {
            [printer printText:@","];
        }

        [printer printNewLine];
	}

    if ([self count]) {
        [printer decreaseIndent];
        [printer printIndent];
    }
    [printer printText:@"]"];
}

@end
