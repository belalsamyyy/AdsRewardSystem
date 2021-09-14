# DesignX ( X for Extensions )
Collection of Design & Layout extensions to speed up making complex user interfaces ✨


## Features

### constraints and layouts 
- [X] Constraints are active by default.
- [X] No need to set `translatesAutoresizingMaskIntoConstraints` because `MagiConstraints` does it for you.
- [X] Satisfy all constraints `X-axis`, `Width`, `Y-axis` & `Height` in one line function `layout()`
- [X] by covering different ways to statisfy each constraint using `enum` parameters
- [X] also have `constraint()` function to use constraints individually 
- [X] add array of subviews 

### create
- [X] create dynamic `UIScrollView` by one line function `create`
- [X] create `UIStackView` by one line function `create`
- [X] create attributed `UILabel` text by one line function `create`

### style 
- [X] fill with image, gradient or color ( `hex`, `uicolor`, `rgb` )
- [X] rounded corners for all corners or specify each corner individually
- [X] rotate the view to a certain angle 
- [X] make a shadow background for your view 
- [X] change the shape of your view to a square or circle 
- [X] make a stroke or border to your view 


## Installation

MagiConstriants is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DesignX'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift 
    import 'DesignX'
```

## Usage 

Constraints behave different if it's attach to `superview` or `any other view`

 `nil = superview` by default, so its easy to change superview without change alot of code 

### superview :
- [X] leading to `leading` of  superview
- [X] trailling to `trailing` of superview
- [X] top to `top` of superview
- [X] bottom to `bottom` of superview

### any other view :
- [X] leading to `trailing` of view
- [X] trailling to `leading` of view
- [X] top to `bottom` of view
- [X] bottom to `top` of view

## Author

BelalSamy, belalsamy10@gmail.com

## License

DesignX is available under the MIT license. See the LICENSE file for more info.
