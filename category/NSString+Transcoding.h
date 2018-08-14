//
//  NSString+Transcoding.h
//  demo
//
//  Created by addcn on 2018/8/13.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Transcoding)

/**
 *  字符串转义
 *  @param originalString 传入的字符串
  * @param stringEncoding 转义类型
 */
+(NSString*)urlEncode:(NSString *)originalString
       stringEncoding:(NSStringEncoding)stringEncoding;

@end
