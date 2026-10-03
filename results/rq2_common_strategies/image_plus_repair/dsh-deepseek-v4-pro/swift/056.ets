import display from '@ohos.display';

// MARK: - AppTokens (Atomic Design System)

// Extension to initialize Color from a hex value (e.g., 0xFFRRGGBB).
// ArkUI accepts colors directly as 0xAARRGGBB numbers, so the SwiftUI
// Color(hex:) initializer maps to plain numeric literals below.

// Applies an opacity factor to a 0xAARRGGBB color value.
function colorWithAlpha(color: number, alpha: number): number {
  return (color & 0x00FFFFFF) | (Math.round(alpha * 255) << 24)
}

// Helper to mimic Kotlin's coerceAtMost (clamps a value into a range).
function coerce(value: number, lower: number, upper: number): number {
  return Math.max(lower, Math.min(value, upper))
}

// Returns the screen width in vp (the ArkUI equivalent of UIScreen.main.bounds.width).
function screenWidthVp(): number {
  return px2vp(display.getDefaultDisplaySync().width)
}

class AppColors {
  static readonly primary: number = 0xFF0EA5E9
  static readonly secondary: number = 0xFF6366F1
  static readonly tertiary: number = 0xFF06B6D4
  static readonly background: number = 0xFFF1F5F9
  static readonly surface: number = 0xFFFFFFFF
  static readonly surfaceVariant: number = 0xFFE2E8F0
  static readonly outline: number = 0xFFD1D5DB
  static readonly success: number = 0xFF22C55E
  static readonly warning: number = 0xFFF59E0B
  static readonly error: number = 0xFFEF4444
  static readonly onPrimary: number = 0xFFFFFFFF
  static readonly onSecondary: number = 0xFFFFFFFF
  static readonly onTertiary: number = 0xFF0F172A
  static readonly onBackground: number = 0xFF1E293B
  static readonly onSurface: number = 0xFF1E293B
}

class AppTypographyTokens {
  // SwiftUI's Font.system uses points (pt) by default, which is a good equivalent for fp/sp in ArkUI for UI scaling.
  static readonly display: Font = { size: 28, weight: FontWeight.Bold }
  static readonly headline: Font = { size: 20, weight: 600 } // .semibold
  static readonly title: Font = { size: 16, weight: FontWeight.Medium }
  static readonly body: Font = { size: 14, weight: FontWeight.Regular } // Normal maps to regular
  static readonly label: Font = { size: 12, weight: FontWeight.Medium }
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class AppTokens {
  static readonly Colors = AppColors
  static readonly TypographyTokens = AppTypographyTokens
  static readonly Shapes = AppShapes
  static readonly Spacing = AppSpacing
}

// ElevationMapping is not directly translatable to ArkUI's built-in shadow attributes
// without a custom modifier or explicit parameters. The Kotlin code doesn't explicitly
// apply these shadows to the UI elements, so we will omit direct translation for now.
// If shadows were explicitly used, we would use .shadow({ radius, color, offsetX, offsetY }).

// MARK: - MealsPage

@Component
struct MealsPage {
  private meals: number[] = [0, 1, 2]

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .font(AppTokens.TypographyTokens.headline)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.meals, (it: number) => {
        Stack() { // Equivalent to Box with contentAlignment: .Center
          Text(`Meal ${it + 1}`)
            .font(AppTokens.TypographyTokens.body)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%') // Equivalent to fillMaxWidth()
        .height(80) // Fixed height
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium }) // Equivalent to border()
      }, (it: number, index: number) => it.toString())

      Blank() // Pushes content to the top
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start) // Align content to top-leading
    .backgroundColor(Color.Transparent) // Ensure background is transparent to show RootScreen's gradient
  }
}

// MARK: - ChatPage

@Component
struct ChatPage {
  private messages: number[] = [0, 1, 2, 3, 4]

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Diet Chat")
        .font(AppTokens.TypographyTokens.headline)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.messages, (it: number) => {
        Row() { // Equivalent to Row
          if (it % 2 === 0) { // Arrangement.Start
            Text(`Message ${it + 1}`)
              .font(AppTokens.TypographyTokens.body)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
            Blank() // Pushes content to the start
          } else { // Arrangement.End
            Blank() // Pushes content to the end
            Text(`Message ${it + 1}`)
              .font(AppTokens.TypographyTokens.body)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
          }
        }
        .width('100%') // Ensure Row takes full width
      }, (it: number, index: number) => it.toString())

      Blank() // Pushes content to the top
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.Transparent)
  }
}

// MARK: - StatsPage

@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6]

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Weekly Calories")
        .font(AppTokens.TypographyTokens.headline)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.days, (it: number) => {
        Row() {
          // Progress bar segment
          Rect()
            .fill(AppTokens.Colors.primary)
            // Calculate width based on screen width, padding, and the dynamic factor
            .width((screenWidthVp() - AppTokens.Spacing.lg * 2) * coerce(0.3 + it * 0.1, 0, 1))
            .borderRadius(AppTokens.Shapes.small) // Apply corner radius to the filled part
          Blank() // Fills the rest of the width
        }
        .width('100%') // Equivalent to fillMaxWidth()
        .height(24) // Fixed height
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small) // Apply corner radius to the background container
      }, (it: number, index: number) => it.toString())

      Blank() // Pushes content to the top and the button to the bottom
        .height(AppTokens.Spacing.lg) // Spacer height from Kotlin code

      Button({ type: ButtonType.Normal }) {
        Text("Share Report")
          .font(AppTokens.TypographyTokens.title)
          .fontColor(AppTokens.Colors.onSecondary)
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center) // Make text fill button for centering
      }
      // Equivalent to fillMaxWidth(0.6f) and height(48.dp)
      .width(screenWidthVp() * 0.6)
      .height(48)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.large)
      .onClick(() => {})
      // No explicit bottom padding in Kotlin, Spacer handles vertical distribution
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center) // Align content to top-center
    .backgroundColor(Color.Transparent)
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0
  private tabs: string[] = ["Meals", "Chat", "Stats"]

  build() {
    // VStack acts as the main container, similar to Scaffold's content area.
    // We use expandSafeArea for the background gradient to cover the entire screen,
    // including the area under the status bar.
    Column({ space: 0 }) {
      // Title Box equivalent
      Row() {
        Text("Diet Log")
          .font(AppTokens.TypographyTokens.display)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%') // Equivalent to fillMaxWidth()
      .padding(AppTokens.Spacing.lg)

      // Custom TabRow equivalent
      Column({ space: 0 }) {
        Row({ space: 0 }) {
          ForEach(this.tabs, (item: string, index: number) => {
            Button({ type: ButtonType.Normal }) {
              Text(item)
                .font(AppTokens.TypographyTokens.body)
                .fontColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
                .width('100%') // Each tab takes equal width
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.selectedTab = index
            })
          }, (item: string, index: number) => item)
        }
        .width('100%')

        // Tab indicator line
        Rect()
          .fill(AppTokens.Colors.primary)
          .width(screenWidthVp() / this.tabs.length)
          .height(2)
          // Calculate offset to position the indicator under the selected tab
          .offset({ x: (screenWidthVp() / this.tabs.length) * this.selectedTab - screenWidthVp() / 2 + screenWidthVp() / this.tabs.length / 2, y: 0 })
          .animation({ duration: 200, curve: Curve.EaseInOut }) // Animate indicator movement
      }
      .backgroundColor(AppTokens.Colors.surface) // TabRow background color
      .width('100%')

      // HorizontalPager equivalent using Swiper
      Swiper() {
        MealsPage()
        ChatPage()
        StatsPage()
      }
      .index(this.selectedTab)
      .indicator(false) // Hide default page indicator dots
      .duration(200)
      .curve(Curve.EaseInOut) // Animate page transitions
      .onChange((index: number) => {
        this.selectedTab = index
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // Fallback background color for the entire view
    .linearGradient({
      angle: 180, // top to bottom
      colors: [
        [colorWithAlpha(AppTokens.Colors.primary, 0.1), 0.0],
        [colorWithAlpha(AppTokens.Colors.secondary, 0.1), 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM]) // Requirement: Hide the top status bar
  }
}

// MARK: - App Entry Point

// SwiftUI's @main App / WindowGroup maps to the @Entry page above (RootScreen),
// which the ability loads as the main page. The PreviewProvider has no ArkUI
// runtime equivalent and is omitted here.
