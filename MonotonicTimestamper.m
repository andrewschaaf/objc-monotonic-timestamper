#import "MonotonicTimestamper.h"
#import <sys/time.h>
#import <sys/sysctl.h>

@interface MonotonicTimestamper () {
    SInt64 _timeZeroUptimeMicroseconds;
    SInt64 _lastTimestamp;
}
@property (nonatomic) SInt64 timeZeroMicroseconds;
@end

@implementation MonotonicTimestamper

+ (SInt64)uptimeMicroseconds {

    SInt64 gettimeofdayMicroseconds = [self gettimeofdayMicroseconds];

    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    struct timeval boottime;
    size_t sysctl_size;
    sysctl(mib, 2, &boottime, &sysctl_size, NULL, 0);

    SInt64 boottimeMicroseconds = ((SInt64)boottime.tv_sec) * 1000000;
    return gettimeofdayMicroseconds - boottimeMicroseconds;
}

- (instancetype)init {
    self = [super self];
    if (self) {
        _timeZeroMicroseconds = [MonotonicTimestamper gettimeofdayMicroseconds];
        _timeZeroUptimeMicroseconds = [MonotonicTimestamper uptimeMicroseconds];
    }
    return self;
}

- (SInt64)monotonicTimestampMicroseconds {
    SInt64 timestamp = _timeZeroMicroseconds + ([MonotonicTimestamper uptimeMicroseconds] - _timeZeroUptimeMicroseconds);
    if (_lastTimestamp > timestamp) {
        timestamp = _lastTimestamp;
    }
    _lastTimestamp = timestamp;
    return timestamp;
}

#pragma mark - Internal Methods

+ (SInt64)gettimeofdayMicroseconds {
    struct timeval time;
    struct timezone tz;
    gettimeofday(&time, &tz);
    SInt64 seconds = time.tv_sec;
    return (seconds * 1000000) + time.tv_usec;
}

@end
