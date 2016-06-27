//
//  NSString+ZZAutoDescription.h
//
//  Created by Ivan Zezyulya on 15.04.14.
//  Copyright (c) 2014 Ivan Zezyulya. All rights reserved.
//

#import "NSObject+ZZAutoDescription.h"

// See also notes in NSObject+ZZAutoDescription.h

#define ZZ_AUTO_DESCRIPTION             \
- (NSString *) description              \
{                                       \
    return [self zz_autoDescription];   \
}                                       \
- (BOOL) zz_autoDescriptionEnabled      \
{                                       \
    return YES;                         \
}
