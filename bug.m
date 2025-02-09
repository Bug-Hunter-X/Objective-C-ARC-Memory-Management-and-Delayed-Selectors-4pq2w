In Objective-C, a common yet subtle issue arises when dealing with object ownership and memory management using Automatic Reference Counting (ARC).  Consider this scenario:

```objectivec
@interface MyClass : NSObject
@property (strong, nonatomic) NSString *myString;
@end

@implementation MyClass
- (void)someMethod {
    self.myString = [[NSString alloc] initWithString:@"Hello"];
    // ... some other code ...
}
@end
```

If `someMethod` is called multiple times, and the old value of `myString` is not explicitly released or set to `nil`, then each call will create a new string and increase the retain count leading to memory leak. Even though ARC handles memory automatically, developers need to ensure correct object lifecycles.  Failure to manage this correctly is a source of many memory management bugs.

Another issue relates to `performSelector:withObject:afterDelay:` or similar methods. If the object whose selector is called deallocates before the delay expires, it can lead to a crash. Proper handling of this requires ensuring the object's lifecycle outlives the delayed execution.