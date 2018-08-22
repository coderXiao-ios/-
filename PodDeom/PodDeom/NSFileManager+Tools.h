//
//  NSFileManager+Tools.h
//  PodDeom
//
//  Created by Xiao Xiao on 2018/6/15.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Tools)
-(BOOL) isFileExist:(NSString *)fileName;
- (void) removeFile:(NSString *)fileName;
- (NSString *)dataPath:(NSString *)floderName andFileName:(NSString *)fileName;
@end
