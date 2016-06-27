//
//  NSObject+ZZAutoDescription.m
//

#import "NSObject+ZZAutoDescription.h"
#import "ZZAutoDescriptionPrinter.h"
#import <objc/runtime.h>

@interface NSObject ()
- (BOOL)zz_shouldAutoDescribeProperty:(NSString *)propertyName;
- (BOOL)zz_shouldAutoDescribePropertiesOfSuperClass:(Class)superClass;
- (BOOL)zz_autoDescriptionEnabled;
@end

@implementation NSObject (ZZAutoDescription)

+ (NSArray *) autoDescriptionPropertiesNames
{
    if (self == [NSObject class]) {
        return @[];
    }

    BOOL respondsToShouldAutoDescribeProperty = (BOOL)[self respondsToSelector:@selector(zz_shouldAutoDescribeProperty:)];
    BOOL respondsToShouldAutoDescribeSuperClassProperties = [self respondsToSelector:@selector(zz_shouldAutoDescribePropertiesOfSuperClass:)];

    NSMutableArray *names = [NSMutableArray new];

    Class superClass = [self superclass];

    BOOL shouldAutoDescribeSuperClassProperties = !respondsToShouldAutoDescribeSuperClassProperties || [self zz_shouldAutoDescribePropertiesOfSuperClass:superClass];

    if (shouldAutoDescribeSuperClassProperties) {
        NSArray *superPropertiesNames = [superClass autoDescriptionPropertiesNames];
        for (NSString *propertyName in superPropertiesNames) {
            if (!respondsToShouldAutoDescribeProperty || [self zz_shouldAutoDescribeProperty:propertyName])
            {
                [names addObject:propertyName];
            }
        }
    }

    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(self, &count);

    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = properties[i];

        NSString *name = @(property_getName(property));

        BOOL isStandardProperty = [self isStandardProperty:name];
        BOOL respondsToPropertySelector = [self instancesRespondToSelector:NSSelectorFromString(name)];

        if (respondsToPropertySelector &&
            !isStandardProperty &&
            (!respondsToShouldAutoDescribeProperty || [self zz_shouldAutoDescribeProperty:name]))
        {
            [names addObject:name];
        }
    }

    free(properties);

    return names;
}

- (void)zz_autoDescribeWithPrinter:(ZZAutoDescriptionPrinter *)printer
{
    [self autoDescribeWithPrinter:printer force:NO];
}

- (void)autoDescribeWithPrinter:(ZZAutoDescriptionPrinter *)printer force:(BOOL)force
{
    BOOL autoDescriptionEnabled = NO;
    if (force) {
        autoDescriptionEnabled = YES;
    } else {
        if ([self respondsToSelector:@selector(zz_autoDescriptionEnabled)]) {
            autoDescriptionEnabled = (BOOL)[self performSelector:@selector(zz_autoDescriptionEnabled)];
        }
    }

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

    NSArray *propertiesNames = [[self class] autoDescriptionPropertiesNames];

    for (NSString *propertyName in propertiesNames)
    {
        [printer printIndent];

        NSObject *object = [self valueForKey:propertyName];

        if (object) {
            [printer printText:[NSString stringWithFormat:@"%@ = ", propertyName]];
            [object zz_autoDescribeWithPrinter:printer];
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

- (NSString *)zz_autoDescription
{
    ZZAutoDescriptionPrinter *printer = [ZZAutoDescriptionPrinter new];
    [self autoDescribeWithPrinter:printer force:YES];
    NSString *result = [printer result];
    return result;
}

- (BOOL)isStandardProperty:(NSString *)propertyName
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
