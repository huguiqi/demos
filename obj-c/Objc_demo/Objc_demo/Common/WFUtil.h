//
//  WFUtil.h
//  Objc_demo
//
//  Created by sam on 16/1/21.
//  Copyright © 2016年 WF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>


@class ALAsset;
@class WFBaseController;

@interface WFUtil : NSObject

#pragma  以下方法声明为非主流写法，相当于声明宏函数的c语言写法
// 宽高
CGFloat ScaleWidth(CGFloat width);

CGFloat ScaleHeight(CGFloat height);

#pragma mark - 图片 -
// 初始化图片
UIImage * ImageWithName(NSString *imageName);
// 拉伸图片
UIImage * ResizableImageWithName(NSString *imageName, UIEdgeInsets capInsets);

#pragma mark - 初始化 -

WFBaseController * InstantiateControllerFromXIB(Class ControllerName);

UINib * InstantiateNibFromNibName(NSString * nibName);

UINib * InstantiateXIBFromXIBName(NSString * nibName);

#pragma mark - 字符串

// 过滤
NSString * StringFilterNull(id orgStr);

BOOL IsEmptyString(NSString * string);
/**
 *  验证密码是否符合规范  0 符合规范 1 缺少英文 2 缺少数字 3 包含特殊字符
 *
 *  @param pPassword 待验证密码
 *
 *  @return 验证结果
 */
+ (NSInteger)checkIsHaveNumAndLetter:(NSString *)pPassword;

/**
 *  得到时间戳
 *
 *  @return 时间戳
 */
NSString * timeInterval();

/**
 *  压缩图片
 *
 *  @param asset  原始图片
 *  @param toSize 压缩尺寸
 *
 *  @return
 */
//+ (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)toSize;

NSString * VendorString();

@end
