## Overview

APProgressHUD is a lightweight and easy-to-use HUD for iOS 8 (written in Objective-C).

![ProgressHUD](http://relatedcode.com/github/progresshud801.png)
.
![ProgressHUD](http://relatedcode.com/github/progresshud802.png)
.
![ProgressHUD](http://relatedcode.com/github/progresshud803.png)

## Installation

### CocoaPods

Add the following to your Podfile:

``` ruby
pod 'APProgressHUD', '~> 1.0'
```

## Requirements

- Xcode 6
- iOS 8
- ARC

## Usage

1., Add the following import to the top of the file:

```objective-c
#import "APProgressHUD.h"
```

2., Use the following to display the HUD:

```objective-c
[APProgressHUD show:@"Please wait..."];
```

3., Simply dismiss after complete your task:

```objective-c
[APProgressHUD dismiss];
```

4., To show a success momentarily:

```objective-c
[APProgressHUD showSuccess:@"Congratulations!"];
```

5., To show an error momentarily:

```objective-c
[APProgressHUD showError:@"Something went wrong"];
```

## Customisation

You can change the color of the activity indicator using UI appearance selector.

```objective-c
[[UIActivityIndicatorView appearance] setColor:[UIColor orangeColor]];
```

## Credits

This project is a fork of [ProgressHUD](https://github.com/relatedcode/ProgressHUD).

ProgressHUD was inspired by [SVProgressHUD](https://github.com/samvermette/SVProgressHUD) project.

The success and error icons are from [Glyphish](http://glyphish.com).

## License

Source code of this project is available under the standard MIT license. Please see [the license file](LICENSE).
