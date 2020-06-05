//
// Copyright (c) 2014 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

#define HUD_STATUS_FONT			[UIFont systemFontOfSize:16.0f]
#define HUD_STATUS_COLOR		[UIColor blackColor]

#define HUD_TEXT_FONT			[UIFont systemFontOfSize:13.0f]
#define HUD_TEXT_COLOR          [UIColor grayColor]

#define HUD_BACKGROUND_COLOR	[UIColor colorWithWhite:0 alpha:0.1]
#define HUD_WINDOW_COLOR		[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2]

#define HUD_IMAGE_SUCCESS		[UIImage imageNamed:@"APProgressHUD.bundle/progresshud-success.png"]
#define HUD_IMAGE_ERROR			[UIImage imageNamed:@"APProgressHUD.bundle/progresshud-error.png"]
#define HUD_TIMED_DELAY 3.0f

@interface APProgressHUD : UIView

+ (APProgressHUD *)shared;

+ (void)dismiss;

+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status text:(NSString *)text;
+ (void)show:(NSString *)status interaction:(BOOL)interaction;

+ (void)showSuccess:(NSString *)status;
+ (void)showSuccess:(NSString *)status text:(NSString *)text;
+ (void)showSuccess:(NSString *)status interaction:(BOOL)interaction;

+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status text:(NSString *)text;
+ (void)showError:(NSString *)status interaction:(BOOL)interaction;

@property (nonatomic, assign) BOOL interaction;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIView *background;
@property (nonatomic, retain) UIToolbar *hud;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UILabel *statusLabel;
@property (nonatomic, retain) UILabel *textLabel;

@end
