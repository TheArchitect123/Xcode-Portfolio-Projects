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

#import "APProgressHUD.h"

@implementation APProgressHUD

@synthesize interaction, window, background, hud, spinner, image, statusLabel, textLabel;

+ (APProgressHUD *)shared {
	static dispatch_once_t once = 0;
	static APProgressHUD *progressHUD;

    dispatch_once(&once, ^{ progressHUD = [[APProgressHUD alloc] init]; });

    return progressHUD;
}

+ (void)dismiss {
	[[self shared] hudHide];
}

+ (void)show:(NSString *)status {
	[self shared].interaction = YES;
	[[self shared] hudMake:status image:nil spin:YES hide:NO text:nil];
}

+ (void)show:(NSString *)status text:(NSString *)text {
    [self shared].interaction = YES;
    [[self shared] hudMake:status image:nil spin:YES hide:NO text:text];
}

+ (void)show:(NSString *)status interaction:(BOOL)interaction {
	[self shared].interaction = interaction;
	[[self shared] hudMake:status image:nil spin:YES hide:NO text:nil];
}

+ (void)showSuccess:(NSString *)status {
	[self shared].interaction = YES;
	[[self shared] hudMake:status image:HUD_IMAGE_SUCCESS spin:NO hide:YES text:nil];
}

+ (void)showSuccess:(NSString *)status text:(NSString *)text {
    [self shared].interaction = YES;
    [[self shared] hudMake:status image:HUD_IMAGE_SUCCESS spin:NO hide:YES text:text];
}

+ (void)showSuccess:(NSString *)status interaction:(BOOL)interaction {
	[self shared].interaction = interaction;
	[[self shared] hudMake:status image:HUD_IMAGE_SUCCESS spin:NO hide:YES text:nil];
}

+ (void)showError:(NSString *)status {
	[self shared].interaction = YES;
	[[self shared] hudMake:status image:HUD_IMAGE_ERROR spin:NO hide:YES text:nil];
}

+ (void)showError:(NSString *)status text:(NSString *)text {
    [self shared].interaction = YES;
    [[self shared] hudMake:status image:HUD_IMAGE_ERROR spin:NO hide:YES text:text];
}

+ (void)showError:(NSString *)status interaction:(BOOL)interaction {
	[self shared].interaction = interaction;
	[[self shared] hudMake:status image:HUD_IMAGE_ERROR spin:NO hide:YES text:nil];
}


- (id)init {
	self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
	id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
	if ([delegate respondsToSelector:@selector(window)])
		window = [delegate performSelector:@selector(window)];
	else window = [[UIApplication sharedApplication] keyWindow];
	background = nil; hud = nil; spinner = nil; image = nil; statusLabel = nil;
	self.alpha = 0;
	return self;
}

- (void)hudMake:(NSString *)status image:(UIImage *)img spin:(BOOL)spin hide:(BOOL)hide text:(NSString *)text {
    
	[self hudCreate];
    
	statusLabel.text = status;
	statusLabel.hidden = (status == nil) ? YES : NO;
    
    textLabel.text = text;
    textLabel.hidden = (text == nil) ? YES : NO;
    
	image.image = img;
	image.hidden = (img == nil) ? YES : NO;
    
	if (spin) [spinner startAnimating]; else [spinner stopAnimating];

    [self hudSize];
	[self hudPosition:nil];
	[self hudShow];

    if (hide) [NSThread detachNewThreadSelector:@selector(timedHide) toTarget:self withObject:nil];
}

- (void)hudCreate {
	if (hud == nil)
	{
		hud = [[UIToolbar alloc] initWithFrame:CGRectZero];
		hud.translucent = YES;
		hud.backgroundColor = HUD_BACKGROUND_COLOR;
		hud.layer.cornerRadius = 10;
		hud.layer.masksToBounds = YES;
		[self registerNotifications];
	}

    if (hud.superview == nil)
	{
		if (interaction == NO)
		{
			CGRect frame = CGRectMake(window.frame.origin.x, window.frame.origin.y, window.frame.size.width, window.frame.size.height);
			background = [[UIView alloc] initWithFrame:frame];
			background.backgroundColor = HUD_WINDOW_COLOR;
			[window addSubview:background];
			[background addSubview:hud];
		}
		else [window addSubview:hud];
	}

    if (spinner == nil)
	{
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		spinner.hidesWhenStopped = YES;
	}
	if (spinner.superview == nil) [hud addSubview:spinner];

    if (image == nil)
	{
		image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
	}
	if (image.superview == nil) [hud addSubview:image];

    if (statusLabel == nil) {
		statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		statusLabel.font = HUD_STATUS_FONT;
		statusLabel.textColor = HUD_STATUS_COLOR;
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.textAlignment = NSTextAlignmentCenter;
		statusLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		statusLabel.numberOfLines = 0;
	}
	if (statusLabel.superview == nil) [hud addSubview:statusLabel];
    
    if (textLabel == nil) {
        textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.font = HUD_TEXT_FONT;
        textLabel.textColor = HUD_TEXT_COLOR;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        textLabel.numberOfLines = 0;
    }
    if (textLabel.superview == nil) [hud addSubview:textLabel];

}

- (void)registerNotifications {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:)
												 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardDidHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudPosition:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)hudDestroy {
	[[NSNotificationCenter defaultCenter] removeObserver:self];

    [statusLabel removeFromSuperview];	statusLabel = nil;
    [textLabel removeFromSuperview];	textLabel = nil;
	[image removeFromSuperview];		image = nil;
	[spinner removeFromSuperview];		spinner = nil;
	[hud removeFromSuperview];			hud = nil;
	[background removeFromSuperview];	background = nil;
}

- (void)hudSize {
	CGRect statusLabelRect = CGRectZero;
    CGRect textLabelRect = CGRectZero;
	CGFloat hudWidth = 100, hudHeight = 100;

    if (statusLabel.text != nil) {
		NSDictionary *attributes = @{NSFontAttributeName:statusLabel.font};
		NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
		statusLabelRect = [statusLabel.text boundingRectWithSize:CGSizeMake(200, 300) options:options attributes:attributes context:NULL];

		statusLabelRect.origin.x = 12;
		statusLabelRect.origin.y = 66;

		hudWidth = statusLabelRect.size.width + 24;
		hudHeight = statusLabelRect.size.height + 80;

		if (hudWidth < 100) {
			hudWidth = 100;
			statusLabelRect.origin.x = 0;
			statusLabelRect.size.width = 100;
		}
	}
    
    if (textLabel.text != nil) {
        NSDictionary *attributes = @{NSFontAttributeName:textLabel.font};
        NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
        textLabelRect = [textLabel.text boundingRectWithSize:CGSizeMake(200, 300) options:options attributes:attributes context:NULL];
        
        textLabelRect.origin.x = 12;
        textLabelRect.origin.y = statusLabelRect.origin.y+statusLabelRect.size.height+6;
        
        if (textLabelRect.size.width + 24 > hudWidth) {
            hudWidth = textLabelRect.size.width + 24;
            statusLabelRect = CGRectMake(textLabelRect.origin.x, statusLabelRect.origin.y, textLabelRect.size.width, statusLabelRect.size.height);
        }
        else {
            textLabelRect.size.width = statusLabelRect.size.width;
            textLabelRect.origin.x = statusLabelRect.origin.x;
        }
        
        hudHeight = hudHeight + textLabelRect.size.height + 6;
    }

    hud.bounds = CGRectMake(0, 0, hudWidth, hudHeight);

    CGFloat imagex = hudWidth/2;
	CGFloat imagey = (statusLabel.text == nil) ? hudHeight/2 : 36;
	image.center = spinner.center = CGPointMake(imagex, imagey);

    statusLabel.frame = statusLabelRect;
    textLabel.frame = textLabelRect;
}

- (void)hudPosition:(NSNotification *)notification {
	CGFloat heightKeyboard = 0;
	NSTimeInterval duration = 0;

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    if (notification != nil)
	{
		NSDictionary *keyboardInfo = [notification userInfo];
		duration = [[keyboardInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
		CGRect keyboard = [[keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];

		if ((notification.name == UIKeyboardWillShowNotification) || (notification.name == UIKeyboardDidShowNotification))
		{
			if (UIInterfaceOrientationIsPortrait(orientation))
				heightKeyboard = keyboard.size.height;
			else heightKeyboard = keyboard.size.width;
		}
	}
	else heightKeyboard = [self keyboardHeight];

    CGRect screen = [UIScreen mainScreen].bounds;
	if (UIInterfaceOrientationIsLandscape(orientation))
	{
		CGFloat temp = screen.size.width;
		screen.size.width = screen.size.height;
		screen.size.height = temp;
	}

    CGFloat posX = screen.size.width / 2;
	CGFloat posY = (screen.size.height - heightKeyboard) / 2;

    CGPoint center;
	if (orientation == UIInterfaceOrientationPortrait)				center = CGPointMake(posX, posY);
	if (orientation == UIInterfaceOrientationPortraitUpsideDown)	center = CGPointMake(posX, screen.size.height-posY);
	if (orientation == UIInterfaceOrientationLandscapeLeft)			center = CGPointMake(posY, posX);
	if (orientation == UIInterfaceOrientationLandscapeRight)		center = CGPointMake(screen.size.height-posY, posX);

    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		hud.center = CGPointMake(center.x, center.y);
	} completion:nil];
}

- (CGFloat)keyboardHeight {
	for (UIWindow *testWindow in [[UIApplication sharedApplication] windows])
	{
		if ([[testWindow class] isEqual:[UIWindow class]] == NO)
		{
			for (UIView *possibleKeyboard in [testWindow subviews])
			{
				if ([possibleKeyboard isKindOfClass:NSClassFromString(@"UIPeripheralHostView")] ||
					[possibleKeyboard isKindOfClass:NSClassFromString(@"UIKeyboard")])
					return possibleKeyboard.bounds.size.height;
			}
		}
	}
	return 0;
}

- (void)hudShow {
	if (self.alpha == 0) {
		self.alpha = 1;

		hud.alpha = 0;
		hud.transform = CGAffineTransformScale(hud.transform, 1.4, 1.4);

		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			hud.transform = CGAffineTransformScale(hud.transform, 1/1.4, 1/1.4);
			hud.alpha = 1;
		} completion:nil];
	}
}

- (void)hudHide {
	if (self.alpha == 1) {
		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;
		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			hud.transform = CGAffineTransformScale(hud.transform, 0.7, 0.7);
			hud.alpha = 0;
		}
		completion:^(BOOL finished) {
			[self hudDestroy];
			self.alpha = 0;
		}];
	}
}

- (void)timedHide {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HUD_TIMED_DELAY * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hudHide];
    });
}

@end
