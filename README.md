# TWSlidingView

create a slide animation on the `UIView`.

like a android screen slide style(viewPager animation)<br>
https://developer.android.com/training/animation/screen-slide.html

to provide three style.<br>
Normal<br>
ZoomOut<br>
Depth

## Demo
![Demo](https://raw.githubusercontent.com/magicmon/TWSlidingView/master/demo.gif)


## Usage

```
let slidingView = TWSlidingView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
slidingView.slidingType = .ZoomOut
self.view.addSubview(slidingView)
```

add subView in slidingView
```
let sampleView = UIView(frame: slidingView.bounds)
sampleView.backgroundColor = UIColor.greenColor()
slidingView.addChildView(sampleView)
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TWSlidingView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TWSlidingView"
```


## Author
Tae Woo Kang, http://magicmon.tistory.com

## LICENSE
**TWSlidingView** is available under the MIT License. See the LICENSE file for more info.