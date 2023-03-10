# SwiftUI View Highlighter

⚠️ Please use `up to next major` and tag `1.1.3` for the Swift Package.
There was some issues with the previous version tags.

Highlight multiple view components in your SwiftUI view one by one with a text caption.
This is very helpful for building a tutorial and walk the user across different features of your app.

| VStack | ScrollView |
|---|---|
| <img width="200" alt="image" src="/demo-new.gif?raw=true"> | <img width="200" alt="image" src="https://user-images.githubusercontent.com/68307970/214223175-0f22a2bd-e369-4aee-98e4-17ac10c4f111.gif"> |

# Feature

- Create highlight for multiple view components in SwiftUI (and show one at a time)
- Show and hide the highlight
- Show a text caption besides the spotlight
- Specify the index of the highlight to show

- User can tap the empty area of the screen to switch to the next highlight
- User can also use the left/right arrow to switch between highlights

- Works in ScrollView using ScrollViewReader

# Example

Please check and run the preview of the example code first.

[ViewHighlighterExample](/Sources/ViewHighlighterExample/ViewHighlighterExample.swift)

# About using in ScrollView

In ScrollView, you have to add a ScrollView reader and scroll your view when the highlighted index changes. Please check the following example for details:

[ViewHighlighter_ScrollViewExample](/Sources/ViewHighlighterExample/ViewHighlighter_ScrollViewExample.swift)

Please note that, if your content changes according to variable (instead of static images and text), you should not use the index (0,1,2,3) as the `id`, since SwiftUI uses this id to reload the views. Instead, you should use the id of the content itself (for example, if it is for a social media post, the post ID), and call `scrollTo` with that ID.

Check the following example to see how:

[ViewHighlighter_ScrollViewExample_Dynamic](/Sources/ViewHighlighterExample/ViewHighlighter_ScrollViewExample_Dynamic.swift)

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
4. Use `Up to Next Major Version` and the version tag `1.1.3`
5. Check the example code above

![FnJPWBAaEAAHQLY](https://user-images.githubusercontent.com/68307970/213997650-46f742e9-cbd1-4b57-a83e-ad75c35b916d.jpeg)

If you already have this package imported, click on your project, click on `Xcode Packages` tab, double click on the `ViewHighlighter` package name, and set the `Up to Next Major Version` and the version tag `1.1.3`

<img width="1352" alt="スクリーンショット 2023-01-23 17 36 03" src="https://user-images.githubusercontent.com/68307970/213996135-e2299281-2cc9-41af-8820-e4da0b941984.png">

# Limitations

- Only works on iOS
- For ScrollView, you need to implement ScrollViewReader and scroll the view when the highlighted index changes (using `onChange` to monitor the changes).

# License

When using this code, you have to attach the unmodified LICENSE file to the copies of your app and make it visible to the end users.
