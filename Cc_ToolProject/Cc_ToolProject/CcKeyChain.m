//
//  CcKeyChain.m
//  Cc_ToolProject
//
//  Created by cchuan on 2017/3/1.
//  Copyright © 2017年 cchuan. All rights reserved.
//

#import "CcKeyChain.h"
#import <Security/Security.h>


@implementation CcKeyChain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)key {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            key, (id)kSecAttrService,
            key, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)saveKeyChainData:(id)data forKey:(NSString *)key
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [CcKeyChain getKeychainQuery:key];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)loadKeyChainDataForKey:(NSString *)key
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [CcKeyChain getKeychainQuery:key];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        } @finally {
            
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeyChainDataForKey:(NSString *)key
{
    NSMutableDictionary *keychainQuery = [CcKeyChain getKeychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
