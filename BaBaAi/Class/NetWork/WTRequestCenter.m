//
//  WTRequestCenter.m
//  TestCache
//
//  Created by song on 14-7-19.
//  Copyright (c) Mike song(mailto:275712575@qq.com). All rights reserved.
//  site:https://github.com/swtlovewtt/WTRequestCenter

#import "WTRequestCenter.h"
#import "WTURLRequestOperation.h"
#import "WTURLRequestSerialization.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif
//请求开始的消息
NSString * const WTNetworkingOperationDidStartNotification = @"WTNetworkingOperationDidStartNotification";
//请求结束的消息
NSString * const WTNetworkingOperationDidFinishNotification = @"WTNetworkingOperationDidFinishNotification";


BOOL const WTRequestCenterDebugMode = YES;

@implementation WTRequestCenter



#pragma mark - 请求队列和缓存
//请求队列
static NSOperationQueue *sharedQueue = nil;
+(NSOperationQueue*)sharedQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedQueue = [[NSOperationQueue alloc] init];
        [sharedQueue setSuspended:NO];
        [sharedQueue setMaxConcurrentOperationCount:32];
        sharedQueue.name = @"WTRequestCentersharedQueue";
    });
    return sharedQueue;
}


//缓存
static NSURLCache* sharedCache = nil;
+(NSURLCache*)sharedCache
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *diskPath = [NSString stringWithFormat:@"WTRequestCenter"];
        
        
        
        sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:1024*1024*10
                                                    diskCapacity:1024*1024*1024
                                                        diskPath:diskPath];
    });
    //    10M内存  1G硬盘
    return sharedCache;
}


#pragma mark - 配置设置

-(BOOL)isRequesting
{
    BOOL requesting = NO;
    NSOperationQueue *sharedQueue = [WTRequestCenter sharedQueue];
    
    if ([sharedQueue operationCount]!=0) {
        requesting = YES;
    }
    return requesting;
}

//清除所有缓存(clearAllCache)
+(void)clearAllCache
{
    NSURLCache *cache = [WTRequestCenter sharedCache];
    [cache removeAllCachedResponses];
    
}



//当前缓存大小
+(NSUInteger)currentDiskUsage
{
    NSURLCache *cache = [WTRequestCenter sharedCache];
    
    return [cache currentDiskUsage];
}


//当前缓存用量，直接根据大小来调节单位的显示，KB，MB，GB，TB，PB，EB
+(NSString*)currentDiskUsageString
{
    NSUInteger usage = [self currentDiskUsage];
    
    //    如果小于1M，就显示为0，因为cache数据库本身在没有数据的情况下是123KB或者218KB
    if (usage<1024*1024) {
        usage = 0;
    }
    return [NSByteCountFormatter stringFromByteCount:usage countStyle:NSByteCountFormatterCountStyleFile];
}

+(void)cancelAllRequest
{
    [[WTRequestCenter sharedQueue] cancelAllOperations];
}


//清除请求的缓存
+(void)removeCachedResponseForRequest:(NSURLRequest*)request
{
    NSURLCache *cache = [WTRequestCenter sharedCache];
    [cache removeCachedResponseForRequest:request];
}
#pragma mark - 辅助
+(id)JSONObjectWithData:(NSData*)data
{
    if (!data) {
        return nil;
    }
    //    容器解析成可变的，string解析成可变的，并且允许顶对象不是dict或者array
    NSJSONReadingOptions option = NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments;
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:option
                                             error:nil];
}

+(NSData*)dataFromJSONObject:(id)object
{
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
        return data;
    }
    return nil;
}


//这个方法用于类型不固定时候的一个过滤
//传入一个NSNumber，NSString或者NSNull类型的数据即可
+(NSString*)stringWithData:(NSObject*)data
{
    if ([data isEqual:[NSNull null]]) {
        return @"";
    }
    if ([data isKindOfClass:[NSString class]]) {
        return (NSString*)data;
    }
    if ([data isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber*)data;
        return [number stringValue];
    }
    return @"";
}


#pragma mark - Get

//get请求
//Available in iOS 5.0 and later.

+(NSURLRequest*)getWithURL:(NSString*)url
                parameters:(NSDictionary*)parameters
                  finished:(WTRequestFinishedBlock)finished
                    failed:(WTRequestFailedBlock)failed
{
    return [self getWithURL:url parameters:parameters option:WTRequestCenterCachePolicyNormal finished:finished failed:failed];
}

+(NSURLRequest*)getWithURL:(NSString*)url
                parameters:(NSDictionary *)parameters
                    option:(WTRequestCenterCachePolicy)option
                  finished:(WTRequestFinishedBlock)finished
                    failed:(WTRequestFailedBlock)failed
{
    NSURLRequest *request = [[WTURLRequestSerialization sharedRequestSerialization]requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
    
    [self doURLRequest:request option:option finished:finished failed:failed];
    
    return request;
}


#pragma mark - POST


+(NSURLRequest*)postWithURL:(NSString*)url
                 parameters:(NSDictionary*)parameters
                   finished:(WTRequestFinishedBlock)finished
                     failed:(WTRequestFailedBlock)failed
{
    NSURLRequest *request = [[WTURLRequestSerialization sharedRequestSerialization] requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
    [self doURLRequest:request finished:finished failed:failed];
    return request;
}




+(NSURLRequest*)postWithURL:(NSString*)url
                 parameters:(NSDictionary*)parameters
  constructingBodyWithBlock:(void (^)(id <WTMultipartFormData> formData))block
                   finished:(WTRequestFinishedBlock)finished
                     failed:(WTRequestFailedBlock)failed
{
    NSURLRequest *request = [[WTURLRequestSerialization sharedRequestSerialization] POSTRequestWithURL:url parameters:parameters constructingBodyWithBlock:block];
    [self doURLRequest:request finished:finished failed:failed];
    
    return request;
}


+(NSURLRequest*)putWithURL:(NSString*)url
                parameters:(NSDictionary*)parameters
                  finished:(WTRequestFinishedBlock)finished
                    failed:(WTRequestFailedBlock)failed
{
    NSURLRequest *request = [[WTURLRequestSerialization sharedRequestSerialization] requestWithMethod:@"PUT" URLString:url parameters:parameters error:nil];
    [self doURLRequest:request finished:finished failed:failed];
    return request;
}

+(NSURLRequest*)deleteWithURL:(NSString*)url
                   parameters:(NSDictionary*)parameters
                     finished:(WTRequestFinishedBlock)finished
                       failed:(WTRequestFailedBlock)failed
{
    NSURLRequest *request = [[WTURLRequestSerialization sharedRequestSerialization] requestWithMethod:@"DELETE" URLString:url parameters:parameters error:nil];
    [self doURLRequest:request
              finished:finished
                failed:failed];
    return request;
}


+(NSURLRequest*)headWithURL:(NSString*)url
                 parameters:(NSDictionary*)parameters
                   finished:(WTRequestFinishedBlock)finished
                     failed:(WTRequestFailedBlock)failed
{
    NSURLRequest *request = [[WTURLRequestSerialization sharedRequestSerialization] requestWithMethod:@"HEAD" URLString:url parameters:parameters error:nil];
    [self doURLRequest:request
              finished:finished
                failed:failed];
    return request;
}


#pragma mark - Request
+(void)doURLRequest:(NSURLRequest*)request
           finished:(WTRequestFinishedBlock)finished
             failed:(WTRequestFailedBlock)failed
{
    [self doURLRequest:request finished:finished failed:failed shouldCache:NO];
}

+(void)doURLRequest:(NSURLRequest*)request
           finished:(WTRequestFinishedBlock)finished
             failed:(WTRequestFailedBlock)failed
        shouldCache:(BOOL)shouldCache
{
    //    有效性判断
    assert(request != nil);
    
    
    [self sendRequestStartNotificationWithRequest:request];
    
    NSTimeInterval startTimeInterval = [[NSDate date] timeIntervalSince1970];
    if (WTRequestCenterDebugMode) {
//        NSLog(@"WTRequestCenter request start:%@",request);
        
    }
    
    void (^complection)(NSURLResponse *response,NSData *data,NSError *error);
    
    complection = ^(NSURLResponse *response,NSData *data,NSError *connectionError)
    {
        NSTimeInterval endTimeInterval = [[NSDate date] timeIntervalSince1970];
        
        [self sendRequestCompleteNotificationWithRequest:request
                                                response:response
                                                    data:data];
        
        
        if (connectionError) {
            if (WTRequestCenterDebugMode) {
                //                    访问出错
                NSLog(@"WTRequestCenter request failed:\n\nrequest:%@\n\nresponse：%@\n\nerror：%@  time:%f",request,response,connectionError,endTimeInterval-startTimeInterval);
            }
        }else
        {
            if (shouldCache) {
                NSNumber *endTime = [NSNumber numberWithFloat:endTimeInterval];
                NSNumber *startTime = [NSNumber numberWithFloat:startTimeInterval];
                
                NSDictionary *userInfo = @{@"requestTime":startTime.stringValue,@"responseTime": endTime.stringValue};
                
                NSCachedURLResponse *tempURLResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data userInfo:userInfo storagePolicy:NSURLCacheStorageAllowed];
                
                [[self sharedCache] storeCachedResponse:tempURLResponse forRequest:request];
            }
            
            if (WTRequestCenterDebugMode) {
//                NSLog(@"WTRequestCenter request finished:%@  time:%f",request,endTimeInterval-startTimeInterval);
            }
        }
        
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (connectionError) {
                if (failed) {
                    failed(response,connectionError);
                }
                
            }else
            {
                if (finished) {
                    finished(response,data);
                }
            }
        }];
    };
    
    
//    [[WTRequestCenter sharedQueue] addOperationWithBlock:^{
        [NSURLConnection sendAsynchronousRequest:request queue:[WTRequestCenter sharedQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            complection(response,data,connectionError);
        }];
//    }];
    
    
}


+(void)doURLRequest:(NSURLRequest*)request
             option:(WTRequestCenterCachePolicy)option
           finished:(WTRequestFinishedBlock)finished
             failed:(WTRequestFailedBlock)failed
{
    NSCachedURLResponse *response = [[self sharedCache] cachedResponseForRequest:request];
    
    switch (option) {
        case WTRequestCenterCachePolicyNormal:
        {
            //            [self doURLRequest:request finished: failed:failed];
            [self doURLRequest:request finished:finished failed:failed shouldCache:YES];
            
        }
            break;
            
        case WTRequestCenterCachePolicyCacheElseWeb:
        {
            if (response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finished) {
                        finished(response.response,response.data);
                    }
                });
            }else
            {
                [self doURLRequest:request finished:finished failed:failed shouldCache:YES];
            }
        }
            break;
            
        case WTRequestCenterCachePolicyOnlyCache:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (response) {
                    if (finished) {
                        finished(response.response,response.data);
                    }
                }else
                {
                    NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:NSURLErrorBadURL
                                                     userInfo:nil];
                    if (failed) {
                        failed(nil,error);
                    }
                }
                
            });
        }
            break;
            
        case WTRequestCenterCachePolicyCacheAndRefresh:
        {
            
            //          如果有本地的，也去刷新，刷新后不回调，如果没有，则用网络的
            
            if (response) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finished) {
                        finished(response.response,response.data);
                    }
                });
                [self doURLRequest:request finished:nil failed:nil];
            }else
            {
                [self doURLRequest:request finished:finished failed:failed shouldCache:YES];
            }
            
            
        }
            break;
        case WTRequestCenterCachePolicyCacheAndWeb:
        {
            if (response) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finished) {
                        finished(response.response,response.data);
                    }
                });
                [self doURLRequest:request finished:finished failed:failed shouldCache:YES];
            }else
            {
                [self doURLRequest:request finished:finished failed:failed shouldCache:YES];
            }
            
            
        }
            break;
            
            
        default:
            break;
    }
    
}








#pragma mark - request Notification
//请求成功的消息
+(void)sendRequestStartNotificationWithRequest:(NSURLRequest *)request
{
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (request) {
        [userInfo setValue:request forKey:@"request"];
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:WTNetworkingOperationDidStartNotification
                                                            object:nil
                                                          userInfo:userInfo];
    }];
}

//请求失败的消息
+(void)sendRequestCompleteNotificationWithRequest:(NSURLRequest*)request
                                         response:(NSURLResponse*)response
                                             data:(NSData*)data
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (request) {
        [userInfo setValue:request forKey:@"request"];
    }
    if (response) {
        [userInfo setValue:response forKey:@"response"];
    }
    if (data) {
        [userInfo setValue:data forKey:@"data"];
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:WTNetworkingOperationDidFinishNotification object:request userInfo:userInfo];
    }];
    
}






#pragma mark - URL

static NSString * const baseURL = @"http://www.baidu.com";
+(NSString *)baseURL
{
    return baseURL;
}

//实际应用示例
+(NSString*)URLWithIndex:(NSInteger)index
{
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    //    0-9
    [urls addObject:@"article/detail"];
    [urls addObject:@"interface1"];
    [urls addObject:@"interface2"];
    [urls addObject:@"interface3"];
    
    
    NSString *url = urls[index];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",[WTRequestCenter baseURL],url];
    return urlString;
}


+ (NSString *)debugDescription
{
    return @"just a joke";
}


#pragma mark - Testing Method



+(WTURLRequestOperation*)testdoURLRequest:(NSURLRequest*)request
                                 progress:(WTDownLoadProgressBlock)progress
                                 finished:(WTRequestFinishedBlock)finished
                                   failed:(WTRequestFailedBlock)failed
{
    //#pragma clang diagnostic push
    //#pragma clang diagnostic ignored "-Warc-retain-cycles"
    //#pragma clang diagnostic ignored "-Wgnu"
    WTURLRequestOperation *operation = nil;
    operation = [[WTURLRequestOperation alloc] initWithRequest:request];
    if (progress) {
        operation.downloadProgress = progress;
    }
    [operation setCompletionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            if (failed) {
                failed(response,error);
            }
        }else
        {
            if (finished) {
                finished(response,data);
            }
        }
    }];
    [[self sharedQueue] addOperation:operation];
    return operation;
    //#pragma clang diagnostic pop
    
}


+(WTURLRequestOperation*)testdoURLRequest:(NSURLRequest*)request
                                   option:(WTRequestCenterCachePolicy)option
                                 progress:(WTDownLoadProgressBlock)progress
                                 finished:(WTRequestFinishedBlock)finished
                                   failed:(WTRequestFailedBlock)failed
{
    WTURLRequestOperation *operation = nil;
    operation = [[WTURLRequestOperation alloc] initWithRequest:request];
    if (progress) {
        operation.downloadProgress = progress;
    }
    NSCachedURLResponse *response = [[self sharedCache] cachedResponseForRequest:request];
    switch (option) {
        case WTRequestCenterCachePolicyNormal:
        {
            operation = [self testdoURLRequest:request progress:progress finished:finished failed:failed];
        }
            break;
        case WTRequestCenterCachePolicyCacheElseWeb:
        {
            if (response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finished) {
                        finished(response.response,response.data);
                    }
                });
            }else
            {
                operation =  [self testdoURLRequest:request progress:progress finished:finished failed:failed];
            }
        }
            break;
        case WTRequestCenterCachePolicyOnlyCache:
        {
            if (response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finished) {
                        finished(response.response,response.data);
                    }
                });
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finished) {
                        finished(nil,nil);
                    }
                });
            }
        }
            break;
        case WTRequestCenterCachePolicyCacheAndRefresh:
        {
            if (response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finished) {
                        finished(response.response,response.data);
                    }
                });
                
            }
            
            operation = [self testdoURLRequest:request progress:progress finished:finished failed:failed];
        }
            break;
        case WTRequestCenterCachePolicyCacheAndWeb:
        {
            
            if (response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finished) {
                        finished(response.response,response.data);
                    }
                });
                operation = [self testdoURLRequest:request progress:nil finished:nil failed:nil];
            }else
            {
                operation = [self testdoURLRequest:request progress:progress finished:finished failed:failed];
            }
        }
            break;
            
        default:
            break;
    }
    
    return operation;
}



+(WTURLRequestOperation*)testGetWithURL:(NSString *)url parameters:(NSDictionary *)parameters finished:(WTRequestFinishedBlock)finished failed:(WTRequestFailedBlock)failed
{
    return [self testGetWithURL:url parameters:parameters option:WTRequestCenterCachePolicyNormal finished:finished failed:failed];
}
+(WTURLRequestOperation*)testGetWithURL:(NSString*)url
                             parameters:(NSDictionary *)parameters
                                 option:(WTRequestCenterCachePolicy)option
                               finished:(WTRequestFinishedBlock)finished
                                 failed:(WTRequestFailedBlock)failed
{
    return [self testGetWithURL:url parameters:parameters option:option progress:nil finished:finished failed:failed];
}

+(WTURLRequestOperation*)testGetWithURL:(NSString*)url
                             parameters:(NSDictionary *)parameters
                                 option:(WTRequestCenterCachePolicy)option
                               progress:(WTDownLoadProgressBlock)progress
                               finished:(WTRequestFinishedBlock)finished
                                 failed:(WTRequestFailedBlock)failed
{
    NSURLRequest *request = [[WTURLRequestSerialization sharedRequestSerialization] requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
    WTURLRequestOperation *operation = [self testdoURLRequest:request option:option progress:progress finished:finished failed:failed];
    return operation;
}



+(WTURLRequestOperation*)testPOSTWithURL:(NSString*)url
                              parameters:(NSDictionary *)parameters
                                finished:(WTRequestFinishedBlock)finished
                                  failed:(WTRequestFailedBlock)failed
{
    NSURLRequest *request = [[WTURLRequestSerialization sharedRequestSerialization] requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
    WTURLRequestOperation *operation = [self testdoURLRequest:request progress:nil finished:finished failed:failed];
    return operation;
}

#pragma mark - 延时的方法
void perform(dispatch_block_t block , double delay)
{
    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, delay*1000*1000*1000);
    dispatch_after(t, dispatch_get_main_queue(), ^{
        block();
    });
}

+(void)performBlock:(dispatch_block_t)block afterDelay:(NSTimeInterval)delay
{
    
    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, delay*1000*1000*1000);
    dispatch_after(t, dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

//执行block
+(void)performBlock:(void(^)())block
{
    
}


#pragma mark - Image
+(NSURLRequest *)uploadRequestWithURL: (NSString *)url
                                 data: (NSData *)data
                             fileName: (NSString*)fileName
{
    
    // from http://www.cocoadev.com/index.pl?HTTPFileUpload
    
    //NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init] ;
    urlRequest.URL = [NSURL URLWithString:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *myboundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",myboundary];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    //[urlRequest addValue: [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundry] forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *postData = [NSMutableData data]; //[NSMutableData dataWithCapacity:[data length] + 512];
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", myboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file1\"; filename=\"%@\"\r\n", fileName]dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[NSData dataWithData:data]];
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", myboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [urlRequest setHTTPBody:postData];
    return urlRequest;
}

//图片上传
+(void)upLoadImageWithURL:(NSString*)url
                     data:(NSData *)data
                 fileName:(NSString*)fileName
        completionHandler:(void (^)(NSURLResponse* response,NSData *data,NSError *error))handler
{
    NSURLRequest *request = [WTRequestCenter uploadRequestWithURL:url data:data fileName:fileName];
    [NSURLConnection sendAsynchronousRequest:request queue:[WTRequestCenter sharedQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (handler) {
                handler(response,data,connectionError);
            }
        });
    }];
}


@end
