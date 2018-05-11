#import "TLColorPlus.h"
#import <objc/runtime.h>

@implementation UIColor (TLColorPlus)

@dynamic gradientImage;

#pragma mark - Chameleon - Getter & Setter Methods for Instance Variables

+ (void)setGradientImage:(UIImage *)gradientImage {
    
    objc_setAssociatedObject(self, @selector(gradientImage), gradientImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)gradientImage {
    
    return objc_getAssociatedObject(self, @selector(gradientImage));
}

+ (UIColor *)colorWithGradientColor:(NSArray<UIColor *> * _Nonnull)colors withPositions:(NSArray<NSNumber *> * _Nonnull)positions withAngle:(float)angle withFrame:(CGRect)frame {
    
    //Create our background gradient layer
    CAGradientLayer *backgroundGradientLayer = [CAGradientLayer layer];
    
    //Set the frame to our object's bounds
    backgroundGradientLayer.frame = frame;
    
    //To simplfy formatting, we'll iterate through our colors array and create a mutable array with their CG counterparts
    NSMutableArray *cgColors = [[NSMutableArray alloc] init];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    
    //Set out gradient's colors
    backgroundGradientLayer.colors = cgColors;
    // @[@0.05,@0.99];
    backgroundGradientLayer.locations = positions;
    
    //Specify the direction our gradient will take
    float startX, startY, endX, endY;
    
    // angle 0 ~ 180
    if (angle < 90) {
        startX = 0;
        startY = 0;
        if (angle >= 45) {
            endX = sinf(angle)/sinf(90-angle);
            endY = 1;
        }else {
            endX = 1;
            endY = sinf(angle)/sinf(90-angle);
        }
    }else if (angle > 90) {
        // > 90
        startX = 0;
        startY = 1;
        if (angle >= 135) {
            endX = 1;
            endY = 1 - sinf(180-angle)/sinf(angle - 90);
        }else {
            endX = 1 - sinf(180-angle)/sinf(angle - 90);
            endY = 0;
        }
    }else {
        // == 90
        startX = 0;
        startY = 0;
        endX = 0;
        endY = 1;
    }
    
    CGPoint startPoint = CGPointMake(startX, startY);
    CGPoint endPoint = CGPointMake(endX, endY);
    [backgroundGradientLayer setStartPoint:startPoint];
    [backgroundGradientLayer setEndPoint:endPoint];
    
    //Convert our CALayer to a UIImage object
    UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
    [backgroundGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setGradientImage:backgroundColorImage];
    return [UIColor colorWithPatternImage:backgroundColorImage];
}

+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string {
    
    //Color with string and a defualt alpha value of 1.0
    return [self colorWithHexString:string withAlpha:1.0];
}

+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string withAlpha:(CGFloat)alpha {
    
    //Quick return in case string is empty
    if (string.length == 0) {
        return nil;
    }
    
    //Check to see if we need to add a hashtag
    if('#' != [string characterAtIndex:0]) {
        string = [NSString stringWithFormat:@"#%@", string];
    }
    
    //Make sure we have a working string length
    if (string.length != 7 && string.length != 4) {
        
        #ifdef DEBUG
        NSLog(@"Unsupported string format: %@", string);
        #endif
        
        return nil;
    }
    
    //Check for short hex strings
    if(string.length == 4) {
        
        //Convert to full length hex string
        string = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                  [string substringWithRange:NSMakeRange(1, 1)],[string substringWithRange:NSMakeRange(1, 1)],
                  [string substringWithRange:NSMakeRange(2, 1)],[string substringWithRange:NSMakeRange(2, 1)],
                  [string substringWithRange:NSMakeRange(3, 1)],[string substringWithRange:NSMakeRange(3, 1)]];
    }
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(1, 2)]];
    unsigned red = [[self class] hexValueToUnsigned:redHex];
    
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(3, 2)]];
    unsigned green = [[self class] hexValueToUnsigned:greenHex];
    
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(5, 2)]];
    unsigned blue = [[self class] hexValueToUnsigned:blueHex];
    
    return [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue {
    
    //Define default unsigned value
    unsigned value = 0;
    
    //Scan unsigned value
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    //Return found value
    return value;
}
@end
