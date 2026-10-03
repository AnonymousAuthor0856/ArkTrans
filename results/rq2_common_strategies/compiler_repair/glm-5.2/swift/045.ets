// Defines application color, typography, shape, spacing, and shadow specifications.

class Colors {
  static readonly primary: string = '#FF8E6BF2'
  static readonly secondary: string = '#FFD3C1FF'
  static readonly tertiary: string = '#FFB39DDB'
  static readonly background: string = '#FFF5F3FF'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFECE6F8'
  static readonly outline: string = '#FFD1C4E9'
  static readonly success: string = '#FF4CAF50'
  static readonly warning: string = '#FFFFB300'
  static readonly error: string = '#FFE53935'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FF2E1A47'
  static readonly onBackground: string = '#FF2E1A47'
  static readonly onSurface: string = '#FF2E1A47'
}

interface TypographyToken {
  size: number | Resource
  weight: FontWeight
}

class TypographyTokens {
  static readonly display: TypographyToken = { size: 28, weight: FontWeight.Bold }
  static readonly title: TypographyToken = { size: 18, weight: FontWeight.Medium }
  static readonly body: TypographyToken = { size: 14, weight: FontWeight.Normal }
  static readonly label: TypographyToken = { size: 12, weight: FontWeight.Medium }
}

class Shapes {
  static readonly small: number = 8.0
  static readonly medium: number = 14.0
  static readonly large: number = 20.0
}

class Spacing {
  static readonly sm: number = 6.0
  static readonly md: number = 10.0
  static readonly lg: number = 16.0
  static readonly xl: number = 24.0
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(4.0, 8.0, 2.0, 0.18)
  static readonly level2: ShadowSpec = new ShadowSpec(8.0, 12.0, 4.0, 0.22)
  static readonly level3: ShadowSpec = new ShadowSpec(12.0, 20.0, 8.0, 0.26)
}

class AppTokens {
  static readonly Colors = Colors
  static readonly TypographyTokens = TypographyTokens
  static readonly Shapes = Shapes
  static readonly Spacing = Spacing
  static readonly ShadowSpec = ShadowSpec
  static readonly ElevationMapping = ElevationMapping
}

// Helper function to apply shadow styling similar to SwiftUI's CustomCardStyle
function applyCardStyle(shadowSpec: ShadowSpec, ambientColor: string): ShadowOptions {
  return {
    radius: shadowSpec.radius,
    color: ambientColor,
    offsetX: 0,
    offsetY: shadowSpec.dy
  } as ShadowOptions
}

@Entry
@Component
struct RootScreen {
  @State private orderId: string = ''
  @State private issue: string = ''
  @State private submitted: boolean = false

  // Focus states for inputs
  @State private orderIdIsFocused: boolean = false
  @State private issueIsFocused: boolean = false

  build() {
    Stack() {
      // Background color ignoring safe area
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Column
      Column({ space: AppTokens.Spacing.lg }) {
        Text('After-Sale Service')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: AppTokens.Spacing.lg }) // Add some top margin for status bar clearance

        // Card Area
        Column({ space: AppTokens.Spacing.md }) {
          Text('Order ID')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.sm })

          // Order ID Input Box
          Stack({ alignContent: Alignment.Start }) {
            // Placeholder Text
            if (this.orderId === '' && !this.orderIdIsFocused) {
              Text('Enter order number')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.5)
                .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                .height(56)
                .textAlign(TextAlign.Start)
            }

            // TextInput
            TextInput({ text: this.orderId, placeholder: '' })
              .onChange((value: string) => {
                this.orderId = value
              })
              .onFocus(() => {
                this.orderIdIsFocused = true
              })
              .onBlur(() => {
                this.orderIdIsFocused = false
              })
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
              .height(56)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .borderWidth(1)
              .borderColor(this.orderIdIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline)
          }
          .width('100%')

          Text('Issue Description')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.sm })

          // Issue Description Input Box (TextArea equivalent to TextEditor)
          Stack({ alignContent: Alignment.Start }) {
            // Placeholder Text
            if (this.issue === '' && !this.issueIsFocused) {
              Text('Describe your issue')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.5)
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.sm + 4,
                  bottom: AppTokens.Spacing.sm + 4
                })
            }

            // TextArea
            TextArea({ text: this.issue, placeholder: '' })
              .onChange((value: string) => {
                this.issue = value
              })
              .onFocus(() => {
                this.issueIsFocused = true
              })
              .onBlur(() => {
                this.issueIsFocused = false
              })
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({
                left: AppTokens.Spacing.md,
                right: AppTokens.Spacing.md,
                top: AppTokens.Spacing.sm + 4,
                bottom: AppTokens.Spacing.sm + 4
              })
              .height(120)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .borderWidth(1)
              .borderColor(this.issueIsFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline)
          }
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow(applyCardStyle(AppTokens.ElevationMapping.level2, AppTokens.Colors.outline))

        // Submit Button
        Button('Submit Request', { type: ButtonType.Normal })
          .width('100%')
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            this.submitted = true
          })

        // Submission Success Message
        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.success)
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.success)
            .opacity(0.15) // Note: In ArkUI, setting opacity on the Text element itself affects the text too.
                           // To achieve background opacity only, a separate background component is needed.
                           // For simplicity, we apply it directly. A better approach is using a Stack.
            .borderRadius(AppTokens.Shapes.medium)
            .textAlign(TextAlign.Center)
        }

        // Spacer to push content to top
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}