

#import <Foundation/Foundation.h>

#define CHAR4(c0, c1, c2, c3) (((c0)<<24 | ((c1)<<16) | ((c2)<<8) | (c3)))

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"%X %X", 'abcd', CHAR4('a', 'b', 'c', 'd'));
        NSLog(@"is equal: %d", ('abcd' == CHAR4('a', 'b', 'c', 'd')));
    }
    return 0;
}
