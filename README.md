# SwiftUI View Highlighter

Highlight multiple view components in your SwiftUI view one by one with a text caption.
This is very helpful for building a tutorial and walk the user across different features of your app.

<img width="300" alt="image" src="/demo.gif?raw=true">

# Feature

- Create highlight for multiple view components in SwiftUI (and show one at a time)
- Show and hide the highlight
- Show a text caption besides the spotlight
- Specify the index of the highlight to show

- User can tap the empty area of the screen to switch to the next highlight
- User can also use the left/right arrow to switch between highlights

# Example

Please check and run the preview of the example code first.

[ViewHighlighterExample](/Sources/ViewHighlighterExample/ViewHighlighterExample.swift)

# Usage

First, integrate the Swift Package, please refer to the [Installation](#Installation) section.

Prepare the variables, there is only one needed:

```swift
@State var currentSpot: Int? = 0
```

When the `currentSpot` is `nil`, there is no spotlights (highlighted views) shown; set it to the index of the spotlight you want to show (index is defined later for each view component).

Basically, you can set the initial value of `currentSpot` to `nil`, and only set it to the index when you want the spotlight to be shown.

Next, within your SwiftUI view, import the framework

```swift
import ViewHighlighter
```

In your top level view (the first view under the `var body: some View`), use the following view modifier:

```diff
struct ViewHighlighterExample: View {
    
    @State var currentSpot: Int? = 0
    
    var body: some View {
        
        VStack {
            // TODO
        }
+        .applySpotlightOverlay(currentSpot: $currentSpot)
        
    }
}
```

Then, use the following modifier for each view element on screen you want to highlight. Remember to define a unique index for each one. And the index should be from 0, and going up.

```diff
SearchTextFieldView(searchText: .constant("Some search text"))
+    .addSpotlight(0, text: "Search for the name of a location")
```

For example, in the above code, the `SearchTextFieldView` is at index 0, which is the first element to be shown in the highlight view. The text will also be shown as a caption.

<img width="300" alt="image" src="/first-example.jpg?raw=true">

```diff
Button {
    self.currentSpot = 0
} label: {
    Image(systemName: "star")
}
    .buttonStyle(.borderedProminent)
    .font(.system(size: 30))
+    .addSpotlight(1, text: "Button in the middle of the view just to test the feature of this framework")
```

In the above code, the `Button` is the second element to be shown in the spotlight view.

<img width="300" alt="image" src="/second-example.jpg?raw=true">

# Installation

1. Open your project in Xcode
2. Click on the `File` menu on top, and click on `Add Packages...`
3. Copy and paste the URL to search box `https://github.com/mszpro/ViewHighlighter.git` and hit enter
4. Use the `main` branch or version tag
5. Check the example code above

# Limitations

- Only works on iOS
- Might not work on ScrollViews (in future release, might need to scroll the view to show the highlighted components)
