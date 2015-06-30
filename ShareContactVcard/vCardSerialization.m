// vCardSerialization.m
// 
// Copyright (c) 2014 Mattt Thompson
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "vCardSerialization.h"

#import <AddressBook/AddressBook.h>

@implementation vCardSerialization

+ (NSArray *)addressBookRecordsWithVCardData:(NSData *)data
                                       error:(NSError * __autoreleasing *)error
{
    CFErrorRef addressBookError = NULL;
    CFArrayRef people = ABPersonCreatePeopleInSourceWithVCardRepresentation(NULL, (__bridge CFDataRef)data);

    if (error) {
        *error = (__bridge_transfer NSError *)addressBookError;
    }

    return (__bridge_transfer NSArray *)people;
}

#pragma mark -

+ (NSData *)vCardDataWithAddressBookRecords:(NSArray *)records
                                      error:(NSError * __autoreleasing *)error
{
    CFDataRef data = ABPersonCreateVCardRepresentationWithPeople((__bridge CFArrayRef)records);

    return (__bridge_transfer NSData *)data;
}

@end
