//
//  NSObject+ZZAutoDescription.h
//

#import <Foundation/Foundation.h>

@interface NSObject (ZZAutoDescription)

/// Will return description always using ZZAutoDescription algorithm. You may use it for getting in-depth
/// description for objects you don't own (for example, UIView created by some UIViewController).
- (NSString *)zz_autoDescription;

@end

/**
 * Fine-tuning options
 * ===================
 *
 * Implement the following method in your subclass to fine-control which properties should be printed:
 *
 * + (BOOL)zz_shouldAutoDescribeProperty:(NSString *)propertyName;
 *
 *
 * Implement the following method in your subclass to control whether properties of super class(es) should be printed:
 *
 * + (BOOL)zz_shouldAutoDescribePropertiesOfSuperClass:(Class)superClass;
 *
 */
