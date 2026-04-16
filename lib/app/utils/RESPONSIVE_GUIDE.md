# E-Campus Responsive Design Guide

This guide explains how to implement responsive design across all screens in the E-Campus application.

## Responsive Utils

The application now includes responsive utilities that make it easy to create UIs that adapt to different screen sizes:

### 1. Using the ResponsiveUtils Class

```dart
// Initialize the utils in your build method
ResponsiveUtils.init(context);

// Use responsive sizing
Container(
  width: ResponsiveUtils.wp(50),  // 50% of screen width
  height: ResponsiveUtils.hp(10), // 10% of screen height
  child: Text(
    'Example text',
    style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
  ),
)
```

### 2. Using the ResponsiveScreen Widget

For new screens, use the `ResponsiveScreen` widget as a wrapper:

```dart
@override
Widget build(BuildContext context) {
  return ResponsiveScreen(
    appBar: AppBar(title: Text('Screen Title')),
    scrollable: true, // Enable scrolling
    child: Column(
      children: [
        // Your UI components here
      ],
    ),
  );
}
```

### 3. Using Extension Methods

```dart
// Responsive text styling
Text(
  'Example',
  style: TextStyle(fontSize: 16).responsive,
)

// Responsive widget sizing
Image(image: AssetImage('assets/image.png')).responsive(
  width: 50, // 50% of screen width
  height: 30, // 30% of screen height
)
```

## Guidelines for Converting Existing Screens

1. Replace fixed dimensions with responsive ones:
   - Change `height: 100` to `height: ResponsiveUtils.hp(12)`
   - Change `width: 200` to `width: ResponsiveUtils.wp(50)`

2. Make text sizes responsive:
   - Change `fontSize: 16` to `fontSize: ResponsiveUtils.fontSize(16)`

3. Make padding and margins responsive:
   - Change `padding: EdgeInsets.all(20)` to `padding: ResponsiveUtils.padding(horizontal: 5, vertical: 2.5)`

4. Use the `ResponsiveScreen` wrapper for easier implementation

## Testing

Always test your screens on different device sizes and orientations to ensure proper adaptation.
