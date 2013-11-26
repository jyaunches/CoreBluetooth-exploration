#import <UIKit/UIKit.h>

@interface NearbyPeripheralsVC : UIViewController <CBCentralManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *peripheralsList;

@end
