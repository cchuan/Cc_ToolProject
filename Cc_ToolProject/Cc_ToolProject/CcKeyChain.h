//
//  CcKeyChain.h
//  Cc_ToolProject
//
//  Created by cchuan on 2017/3/1.
//  Copyright © 2017年 cchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CcKeyChain : NSObject

+ (void)saveKeyChainData:(id)data forKey:(NSString *)key;
+ (id)loadKeyChainDataForKey:(NSString *)key;
+ (void)deleteKeyChainDataForKey:(NSString *)key;

@end
