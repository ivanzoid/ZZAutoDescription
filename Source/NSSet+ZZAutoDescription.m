//
//  NSSet+ZZAutoDescription.m
//
//  Created by Ivan Zezyulya on 15.04.14.
//  Copyright (c) 2014 Ivan Zezyulya. All rights reserved.
//

#import "NSSet+ZZAutoDescription.h"
#import "ZZAutoDescriptionPrinter.h"

@implementation NSSet (ZZAutoDescription)

- (NSString *)zz_autoDescription
{
    ZZAutoDescriptionPrinter *printer = [ZZAutoDescriptionPrinter new];
    [self zz_autoDescribeWithPrinter:printer];
    NSString *result = [printer result];
    return result;
}

- (void)zz_autoDescribeWithPrinter:(ZZAutoDescriptionPrinter *)printer
{
    [printer printText:@"<["];
    
    NSArray *allObjects = [self allObjects];

    if ([allObjects count]) {
        [printer printNewLine];
        [printer increaseIndent];
    }

	for (id object in allObjects)
    {
        [printer printIndent];
        [object zz_autoDescribeWithPrinter:printer];

        if ([allObjects lastObject] != object) {
            [printer printText:@","];
        }
        [printer printNewLine];
	}
    
    if ([allObjects count]) {
        [printer decreaseIndent];
        [printer printIndent];
    }
    [printer printText:@"]>"];
}

@end
