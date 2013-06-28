/*
 
 Copyright (c) 2012, SMB Phone Inc.
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those
 of the authors and should not be interpreted as representing official policies,
 either expressed or implied, of the FreeBSD Project.
 
 */

#import "HOPCache.h"
#import <openpeer/core/ICache.h>

using namespace openpeer;
using namespace openpeer::core;

@implementation HOPCache

+ (NSString*) fetchForCookieNamePath:(NSString*) cookieNamePath
{
    NSString* ret = nil;
    
    if ([cookieNamePath length] > 0)
    {
        zsLib::String data = ICache::singleton()->fetch([cookieNamePath UTF8String]);
        if (!data.isEmpty())
            ret = [NSString stringWithUTF8String:data];
    }
    
    return ret;
}

+ (void) store:(NSString*) stringToStore expireDate:(NSDate*) expireDate cookieNamePath:(NSString*) cookieNamePath
{
    if ([stringToStore length] > 0 && [cookieNamePath length] > 0)
        ICache::singleton()->store([stringToStore UTF8String], boost::posix_time::from_time_t([expireDate timeIntervalSince1970]), [cookieNamePath UTF8String]);
}

+ (void) clearForCookieNamePath:(NSString*) cookieNamePath
{
    if ([cookieNamePath length] > 0)
        ICache::singleton()->clear([cookieNamePath UTF8String]);
}

@end