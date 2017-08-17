
#import <UIKit/UIKit.h>

@interface SGLNavigationViewController : UINavigationController

- (void)addFullScreenPopBlackListItem:(UIViewController *)viewController;
- (void)removeFromFullScreenPopBlackList:(UIViewController *)viewController;

@end
