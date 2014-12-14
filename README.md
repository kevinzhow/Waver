#Waver

[![Build Status](https://travis-ci.org/kevinzhow/PNChart.png?branch=master)](https://travis-ci.org/kevinzhow/PNChart)

A Siri like wave effect

[![](https://dl.dropboxusercontent.com/u/1599662/waver/waver.png)](https://dl.dropboxusercontent.com/u/1599662/waver/wave.mov)

## Requirements

Waver works on iOS 7.0 and later version and is compatible with ARC projects. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* Foundation.framework
* UIKit.framework
* CoreGraphics.framework
* QuartzCore.framework

You will need LLVM 3.0 or later in order to build Waver.


## Usage

### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add Waver to your project.

1. Add a pod entry for Waver to your Podfile `pod 'Waver', '~> 0.1.0'`
2. Install the pod(s) by running `pod install`.
3. Include Waver wherever you need it with `#import "Waver.h"`.


### Or Copy the Waver folder to your project


## Example


```objective-c
Waver * waver = [[Waver alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)/2.0 - 50.0, CGRectGetWidth(self.view.bounds), 100.0)];

__weak Waver * weakWaver = waver;
waver.waverLevelCallback = ^() {

    [self.recorder updateMeters];

    CGFloat normalizedValue = pow (10, [self.recorder averagePowerForChannel:0] / 50);

    weakWaver.level = normalizedValue;

};
[self.view addSubview:waver];

```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## SpecialThanks
https://github.com/stefanceriu/SCSiriWaveformView

