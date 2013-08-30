## `MonotonicTimestamper.{h,m}`

```objc
@property (nonatomic, readonly) SInt64 timeZeroMicroseconds;
+ (SInt64)uptimeMicroseconds;
- (SInt64)monotonicTimestampMicroseconds;
```


### timeZeroMicroseconds

Returns the number of microseconds since the epoch, as determined by `gettimeofday` in `init`.


### uptimeMicroseconds

Returns the number of microseconds since the epoch (via `gettimeofday`)
minus the number of microseconds between the epoch and boottime
(via `sysctl`'s `kern.boottime`, second resolution).


### monotonicTimestampMicroseconds

Returns

    max(
      last value returned,
      timeZeroMicroseconds plus the difference in uptimeMicroseconds between init and now.
    )


## License: MIT
