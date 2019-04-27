//
//  ZSHTTPRequest.m
//  ZSNetworkHelper
//
//  Created by 班文政 on 2018/9/27.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "ZSHTTPRequest.h"
#import "ZSInterfacedConst.h"
#import "ZSNetworkHelper.h"
#import "NSObject+RYTool.h"
#import "UIView+Alert.h"
#import "SNLoginViewController.h"
#import "PCIGeneralRequest.h"

@implementation ZSHTTPRequest

+ (void)requestDataWithURL:(NSString *)URL parameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    if ([RYToolClass isBlankString:[PCISave account].access_token]) {
//        if (![[self currentViewController] isKindOfClass:[SULoginViewController class]]) {
//
//            SULoginViewController *vc = [[SULoginViewController alloc] init];
//            [[self currentViewController] presentViewController:vc animated:YES completion:nil];
//        }
        
        [ZSNetworkHelper setValue:nil forHTTPHeaderField:@"X-Ticket"];
        [PCIGeneralRequest GetSessionWithIsCache:NO success:^(id response) {
            
            if ([[response objectForKey:@"error_code"] isEqualToString:@"SUCCESS"]) {
                
                PCIAccount *account = [[PCIAccount alloc] init];
                account.access_token = response[@"result"][@"access_token"];
                [PCISave save:account];
                
                // 设置请求头
                [ZSNetworkHelper setValue:[PCISave account].access_token forHTTPHeaderField:@"X-Ticket"];
                // app版本
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                
                NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
                
                [ZSNetworkHelper setValue:app_Version forHTTPHeaderField:@"Version"];
                
                [self requestWithURL:URL parameters:[RYToolClass md5ParameterWithDict:parameter] isCache:isCache success:success failure:failure];
            }else{
                [[[UIApplication sharedApplication] keyWindow] showToastWithText:@"网络错误，请重试" afterDelay:0];
            }
        } failure:^(NSError *error) {
            
            [[[UIApplication sharedApplication] keyWindow] showToastWithText:@"网络错误，请重试" afterDelay:0];
        }];
    }else{
        // 设置请求头
        [ZSNetworkHelper setValue:[PCISave account].access_token forHTTPHeaderField:@"X-Ticket"];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        [ZSNetworkHelper setValue:app_Version forHTTPHeaderField:@"Version"];
        
        [self requestWithURL:URL parameters:[RYToolClass md5ParameterWithDict:parameter] isCache:isCache success:success failure:failure];
    }
}


/** 通用 | 获取session信息 */
+ (void)GetSessionWithIsCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSDictionary *parameters = @{
                                 @"channel":@"ios",
                                 @"device_id":[RYToolClass getUUID],
                                 };
    NSString *url = [kApiPrefix stringByAppendingPathComponent:kGetSession];
    // 设置请求头
    [ZSNetworkHelper setValue:nil forHTTPHeaderField:@"X-Ticket"];
    [[self requestWithURL:url parameters:parameters isCache:isCache success:success failure:failure] resume];
}
/** 通用 | OSS客户端STS凭证直传上传接口  */
+ (void)uploadDataOSSWithURL:(NSString *)URL parameters:(NSDictionary *)parameter isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kUpLoad];
    [self requestDataWithURL:url parameters:parameter isCache:isCache success:success failure:failure];
}

#pragma mark - POST 请求的公共方法
+ (NSURLSessionTask *)requestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter  isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure
{
    //打印log
    [ZSNetworkHelper openLog];
    
    // 发起请求
    if (isCache) {//判断是否需要缓存
        //缓存
        return [ZSNetworkHelper POST:URL parameters:parameter responseCache:^(id responseCache) {
        } success:^(id responseObject) {
            success(responseObject);
            if ([[responseObject objectForKey:@"error_code"] isEqualToString:@"FAIL"]) {
                
                [[UIApplication sharedApplication].keyWindow showToastWithText:[responseObject objectForKey:@"reason"] afterDelay:0];
            }
        } failure:^(NSError *error) {
            failure(error);
        }];
    }else{
        return [ZSNetworkHelper POST:URL parameters:parameter success:^(id responseObject) {
            success(responseObject);
            if ([[responseObject objectForKey:@"error_code"] isEqualToString:@"FAIL"]) {
                
                NSString *showText = [responseObject objectForKey:@"reason"];
                if (![showText isEqualToString:@"请求过于频繁"]) {
                    [[UIApplication sharedApplication].keyWindow showToastWithText:[responseObject objectForKey:@"reason"] afterDelay:0];
                }
            }
        } failure:^(NSError *error) {
            
            [self showToskWithError:error];
            failure(error);
        }];
    }
}

#pragma mark - GET 请求的公共方法
+ (NSURLSessionTask *)GETRequestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter  isCache:(BOOL)isCache success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure
{
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    
    // 设置请求头
    [ZSNetworkHelper setValue:[PCISave account].access_token forHTTPHeaderField:@"X-Ticket"];
    
    //打印log
    [ZSNetworkHelper openLog];
    
    // 发起请求
    if (isCache) {//判断是否需要缓存
        //缓存
        return [ZSNetworkHelper GET:URL parameters:parameter responseCache:^(id responseCache) {
            
        } success:^(id responseObject) {
            
            success(responseObject);
        } failure:^(NSError *error) {
            
            failure(error);
        }];
        
    }else{
        
        return [ZSNetworkHelper GET:URL parameters:parameter success:^(id responseObject) {
            
            success(responseObject);
        } failure:^(NSError *error) {
            
            failure(error);
        }];
    }
}

#pragma mark - 上传图片
+ (NSURLSessionTask *)uploadImagesParameters:(NSDictionary *)parameter  images:(NSArray <UIImage *>*)images success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure
{
    //打印log
    [ZSNetworkHelper openLog];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kUpLoad];
    
    return [ZSNetworkHelper uploadImagesWithURL:url parameters:parameter name:@"file" images:images fileNames:nil imageScale:0.5f imageType:@"png" progress:^(NSProgress *progress) {
        
        [SVProgressHUD showProgress:progress.fractionCompleted];
        
    } success:^(id responseObject) {
        [SVProgressHUD dismiss];
        success(responseObject);
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self showToskWithError:error];
        failure(error);
    }];
}

#pragma mark -- 上传文件
+ (NSURLSessionTask *)uploadFileWithParameters:(NSDictionary *)parameters name:(NSString *)name filePath:(NSString *)filePath success:(ZSRequestSuccess)success failure:(ZSRequestFailure)failure{
    
    //打印log
    [ZSNetworkHelper openLog];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kUpLoad];
    
    return [ZSNetworkHelper uploadFileWithURL:url parameters:parameters name:name filePath:filePath progress:^(NSProgress *progress) {
        [SVProgressHUD showProgress:progress.fractionCompleted];
    } success:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        success(responseObject);
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [self showToskWithError:error];
        failure(error);
    }];
}

+ (void)showToskWithError:(NSError *)error{
    
    if (error.code == NSURLErrorTimedOut) {
        
        [ZSNetworkHelper cancelAllRequest];
        [[UIApplication sharedApplication].keyWindow showToastWithText:@"网络连接超时" afterDelay:0];
    }else if (error.code == NSURLErrorBadServerResponse){
        
        PCIAccount *account = [PCISave account];
        account.access_token = @"";
        [PCISave save:account];
        [[UIApplication sharedApplication].keyWindow showToastWithText:@"您暂未登录,请登录" afterDelay:0];
        
        [ZSNetworkHelper cancelAllRequest];
        
        if (![[self currentViewController] isKindOfClass:[SNLoginViewController class]]) {
            
            SNLoginViewController *vc = [[SNLoginViewController alloc] init];
            [[self currentViewController] presentViewController:vc animated:YES completion:nil];
        }
        
    }else if (error.code == NSURLErrorNotConnectedToInternet){
        
        [ZSNetworkHelper cancelAllRequest];
        [[UIApplication sharedApplication].keyWindow showToastWithText:@"无网络连接" afterDelay:0];
    }
}

@end
