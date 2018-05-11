#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface UIColor (TLColorPlus)

#pragma mark - Instance Variables
@property (nonatomic, strong) UIImage *gradientImage;

+ (UIColor *)colorWithGradientColor:(NSArray<UIColor *> * _Nonnull)colors withPositions:(NSArray<NSNumber *> * _Nonnull)positions withAngle:(float)angle withFrame:(CGRect)frame;
+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string;
+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string withAlpha:(CGFloat)alpha;
@end
