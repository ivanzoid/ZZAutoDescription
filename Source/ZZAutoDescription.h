////////////////////////////////////////////////////////////////////////////////
//
//  IVAN ZEZYULYA
//  Copyright 2016 Ivan Zezyulya Pty Ltd
//  All Rights Reserved.
//
//  NOTICE: Prepared by AppsQuick.ly on behalf of Ivan Zezyulya. This software
//  is proprietary information. Unauthorized use is prohibited.
//
////////////////////////////////////////////////////////////////////////////////

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
