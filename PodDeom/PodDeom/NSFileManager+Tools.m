//
//  NSFileManager+Tools.m
//  PodDeom
//
//  Created by Xiao Xiao on 2018/6/15.
//  Copyright © 2018年 Xiao Xiao. All rights reserved.
//

#import "NSFileManager+Tools.h"

@implementation NSFileManager (Tools)
-(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}
- (void) removeFile:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSError  *error = nil;
        [fileManager removeItemAtPath:filePath error:&error];
        NSLog(@"%@",error);
    }
}

- (NSString *)dataPath:(NSString *)floderName andFileName:(NSString *)fileName
{
    
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:floderName];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    NSString *result = [path stringByAppendingPathComponent:fileName];
    return result;
    
}
@end
