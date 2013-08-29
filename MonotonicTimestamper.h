#import <Foundation/Foundation.h>

@interface MonotonicTimestamper : NSObject

@property (nonatomic, readonly) SInt64 timeZeroMicroseconds;
+ (SInt64)uptimeMicroseconds;
- (SInt64)monotonicTimestampMicroseconds;

@end
