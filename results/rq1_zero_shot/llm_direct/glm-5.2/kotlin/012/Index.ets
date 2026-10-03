// 009FavoritesGriden - Social - Glassmorphic - en - 720x1280

class AppTokens {
  static Colors = {
    primary: '#60A5FA',
    secondary: '#93C5FD',
    tertiary: '#A5B4FC',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#EFF6FF',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E293B',
    onTertiary: '#1E1E2F',
    onBackground: '#111827',
    onSurface: '#111827'
  }
  static Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bolder },
    title: { fontSize: 18, fontWeight: FontWeight.Bold },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }
  static Shapes = {
    small: 8,
    medium: 16,
    large: 24
  }
  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

@Entry
@Component
struct RootScreen {
  private markerPositionX: number = 200;
  private markerPositionY: number = 400;

  build() {
    Column() {
      // Top App Bar
      Text('Favorite Spots Map')
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)
        .backgroundColor(AppTokens.Colors.background)

      // Content Box
      Stack() {
        // Map Container
        Stack() {
          // Canvas equivalent
          Column() {
            // Background Circle 2
            Circle({ width: 680, height: 680 })
              .fill(ColorManager.secondary)
              .opacity(0.2)
            // Background Circle 1
            Circle({ width: 440, height: 440 })
              .fill(ColorManager.secondary)
              .opacity(0.3)
            // Marker Stroke
            Circle({ width: 60, height: 60 })
              .fill(Color.Transparent)
              .stroke(ColorManager.primary)
              .strokeWidth(3)
              .opacity(0.3)
              .position(this.markerPositionX - 30, this.markerPositionY - 30)
            // Marker
            Circle({ width: 28, height: 28 })
              .fill(ColorManager.primary)
              .position(this.markerPositionX - 14, this.markerPositionY - 14)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height(400)
        .linearGradient({
          angle: 90,
          colors: [
            [AppTokens.Colors.surface, 0.8],
            [AppTokens.Colors.surfaceVariant, 0.6]
          ]
        })
        .borderRadius(AppTokens.Shapes.large)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })

        // Bottom Controls
        Column() {
          Text(`Spot Coordinates: (${this.markerPositionX}, ${this.markerPositionY})`)
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontWeight(AppTokens.Typography.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md })

          Button('Save Marker') {
            Text('Save Marker')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          ['#FFFFFF', 0.6],
          [AppTokens.Colors.surfaceVariant, 0.5],
          ['#FFFFFF', 0.7]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}