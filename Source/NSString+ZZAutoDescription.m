//
//  NSString+ZZAutoDescription.m
//
//  Created by Ivan Zezyulya on 15.04.14.
//  Copyright (c) 2014 Ivan Zezyulya. All rights reserved.
//

#import "NSString+ZZAutoDescription.h"
#import "ZZAutoDescriptionPrinter.h"

@implementation NSString (ZZAutoDescription)

- (NSString *)zz_autoDescription
{
    ZZAutoDescriptionPrinter *printer = [ZZAutoDescriptionPrinter new];
    [self zz_autoDescribeWithPrinter:printer];
    NSString *result = [printer result];
    return result;
}

- (void)zz_autoDescribeWithPrinter:(ZZAutoDescriptionPrinter *)printer
{
    NSString *quotedDescription = [NSString stringWithFormat:@"\"%@\"", [self description]];
    [printer printText:quotedDescription];
}

@end
