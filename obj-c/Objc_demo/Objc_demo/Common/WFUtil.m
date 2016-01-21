//
//  WFUtil.m
//  Objc_demo
//
//  Created by sam on 16/1/21.
//  Copyright © 2016年 WF. All rights reserved.
//

#import "WFUtil.h"

@implementation WFUtil


CGFloat ScaleWidth(CGFloat width)
{
    return width*([[UIScreen mainScreen] bounds].size.width/320.0);
}

CGFloat ScaleHeight(CGFloat height)
{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    if (screenWidth >= 414) {
        return height*(screenWidth/320.0);
    }else {
        return height;
    }
}


UIImage * ImageWithName(NSString *imageName)
{
    return [UIImage imageNamed:imageName];
}

UIImage * ResizableImageWithName(NSString *imageName, UIEdgeInsets capInsets)
{
    if (imageName) {
        UIImage * image = [UIImage imageNamed:imageName];
        return [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    }else {
        return nil;
    }
}

WFBaseController * InstantiateControllerFromXIB(Class ControllerName)
{
    WFBaseController * vc = [[ControllerName alloc] initWithNibName:NSStringFromClass(ControllerName) bundle:nil];
    
    return vc;
}

UINib * InstantiateNibFromNibName(NSString * nibName)
{
    return ([UINib nibWithNibName:nibName bundle:Nil]);
}

UINib * InstantiateXIBFromXIBName(NSString * nibName)
{
    return ([[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject]);
}

NSString * StringFilterNull(id orgStr)
{
    if (orgStr == nil || orgStr == NULL || [orgStr isKindOfClass:[NSNull class]]) {
        return @"";
    }else {
        return [NSString stringWithFormat:@"%@", orgStr];
    }
}

BOOL IsEmptyString(NSString * string)
{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        return YES;
    }
    return NO;
}

+ (NSInteger)checkIsHaveNumAndLetter:(NSString *)pPassword
{
    //數字條件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合數字條件的有幾個字元
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:pPassword
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, pPassword.length)];
    //英文字條件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合英文字條件的有幾個字元
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:pPassword options:NSMatchingReportProgress range:NSMakeRange(0, pPassword.length)];
    if (tNumMatchCount == pPassword.length){
        //全部符合數字，表示沒有英文
        return 1;
    }else if (tLetterMatchCount == pPassword.length){
        //全不符合英文，表示沒有數字
        return 2;
    }else if (tNumMatchCount + tLetterMatchCount == pPassword.length){
        //符合英文和符合數字條件的相加等於密碼長度
        return 0;
    }else {
        return 3;
        //可能包含標點符號的情況，或是包含非英文的文字，這裡再依照需求詳細判斷想呈現的錯誤
    }
}

NSString * timeInterval()
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    return [[NSString stringWithFormat:@"%lf", interval] substringToIndex:10];
}




@end
