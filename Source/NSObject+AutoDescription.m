//
//  NSObject+AutoDescription.m
//

#import "NSObject+AutoDescription.h"
#import "AutoDescriptionPrinter.h"
#import <objc/runtime.h>

@interface NSObject ()
- (BOOL) shouldAutoDescribeProperty:(NSString *)propertyName;
- (BOOL) shouldAutoDescribePropertiesOfSuperClass:(Class)superClass;
- (BOOL) autoDescriptionEnabled;
@end

@implementation NSObject (AutoDescription)

- (NSArray *) autoDescriptionPropertiesNames
{
    Class class = [self class];

    if (class == [NSObject class]) {
        return @[];
    }

    BOOL respondsToShouldAutoDescribeProperty = [self respondsToSelector:@selector(shouldAutoDescribeProperty:)];
    BOOL respondsToShouldAutoDescribeSuperClassProperties = [self respondsToSelector:@selector(shouldAutoDescribePropertiesOfSuperClass:)];

    NSMutableArray *names = [NSMutableArray new];

    Class superClass = [class superclass];

    if (!respondsToShouldAutoDescribeSuperClassProperties || [self shouldAutoDescribePropertiesOfSuperClass:superClass]) {
        NSArray *superPropertiesNames = [superClass autoDescriptionPropertiesNames];
        for (NSString *propertyName in superPropertiesNames) {
            if (!respondsToShouldAutoDescribeProperty || [self shouldAutoDescribeProperty:propertyName])
            {
                [names addObject:propertyName];
            }
        }
    }

    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);

    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = properties[i];

        NSString *name = @(property_getName(property));

        BOOL isStandardProperty = [self isStandardProperty:name];

        if (!isStandardProperty &&
            (!respondsToShouldAutoDescribeProperty || (respondsToShouldAutoDescribeProperty && [self shouldAutoDescribeProperty:name])))
        {
            [names addObject:name];
        }
    }

    free(properties);

    return names;
}

- (void) autoDescribeWithPrinter:(AutoDescriptionPrinter *)printer
{
    BOOL autoDescriptionEnabled = [self respondsToSelector:@selector(autoDescriptionEnabled)] &&
    [self performSelector:@selector(autoDescriptionEnabled)];

    if ([printer isObjectInPrintedStack:self]) {
        NSString *description = @"";
        if (autoDescriptionEnabled) {
            description = [NSString stringWithFormat:@"<%@:#%p>", NSStringFromClass([self class]), self];
        } else {
            description = [NSString stringWithFormat:@"<%@>", [self description]];
        }

        [printer printText:description];
        return;
    }

    if (!autoDescriptionEnabled) {
        NSString *description = [self description];
        if (description) {
            NSArray *descriptionComponents = [description componentsSeparatedByString:@"\n"];
            [printer printText:[NSString stringWithFormat:@"%@ <", NSStringFromClass([self class])]];
            [printer printNewLine];
            [printer increaseIndent];
            for (NSString *component in descriptionComponents) {
                [printer printLine:component];
            }
            [printer decreaseIndent];
            [printer printIndent];
            [printer printText:@">"];
            return;
        }
    }

    [printer pushPrintedObject:self];
    [printer printText:[NSString stringWithFormat:@"%@ <", NSStringFromClass([self class])]];
    [printer printNewLine];
    [printer increaseIndent];

    NSArray *propertiesNames = [self autoDescriptionPropertiesNames];

    for (NSString *propertyName in propertiesNames)
    {
        [printer printIndent];

        id object = [self valueForKey:propertyName];

        if (object) {
            [printer printText:[NSString stringWithFormat:@"%@ = ", propertyName]];
            [object autoDescribeWithPrinter:printer];
        } else {
            [printer printText:[NSString stringWithFormat:@"%@ = nil", propertyName]];
        }

        if ([propertiesNames lastObject] != propertyName) {
            [printer printText:@","];
        }
        [printer printNewLine];
    }

    [printer decreaseIndent];
    [printer printIndent];
    [printer printText:@">"];
    [printer popPrintedObject:self];
}

- (NSString *) autoDescription
{
    AutoDescriptionPrinter *printer = [AutoDescriptionPrinter new];
    [self autoDescribeWithPrinter:printer];
    NSString *result = [printer result];
    return result;
}

- (BOOL) isStandardProperty:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"description"] ||
        [propertyName isEqualToString:@"debugDescription"] ||
        [propertyName isEqualToString:@"hash"] ||
        [propertyName isEqualToString:@"superclass"]
    ) {
        return YES;
    } else {
        return NO;
    }
}

@end
