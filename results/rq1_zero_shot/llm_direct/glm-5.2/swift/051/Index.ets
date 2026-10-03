// AppTokens: Centralized design tokens for colors, typography, shapes, spacing, and elevation.
class AppTokens {
  static readonly Colors = {
    primary: '#FF00FFFF', // Cyan
    secondary: '#FF00B4FF', // Light Blue
    tertiary: '#FF8A2BE2', // Blue Violet
    background: '#FF0A0A1A', // Dark Navy
    surface: '#FF141436', // Darker Purple-Blue
    surfaceVariant: '#FF1E1E4A', // Even Darker Purple-Blue
    outline: '#FF2E2E5C', // Dark Purple-Blue
    success: '#FF00FFAA', // Greenish Cyan
    warning: '#FFFFCC00', // Yellow
    error: '#FFFF4444', // Red
    onPrimary: '#FF0A0A1A', // Dark Navy (on primary)
    onSecondary: '#FFFFFFFF', // White
    onBackground: '#FFFFFFFF', // White
    onSurface: '#FFFFFFFF' // White
  }

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes = {
    smallCornerRadius: 8,
    mediumCornerRadius: 14,
    largeCornerRadius: 22
  }

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  }
}

// Helper function to apply typography styles to Text components
function applyTypography(text: Text, config: { size: number, weight: FontWeight }): Text {
  return text.fontSize(config.size).fontWeight(config.weight)
}

// Helper function to convert hex color to rgba string for shadow opacity
function hexToRgba(hex: string, opacity: number): string {
  const r = parseInt(hex.slice(3, 5), 16)
  const g = parseInt(hex.slice(5, 7), 16)
  const b = parseInt(hex.slice(7, 9), 16)
  return `rgba(${r}, ${g}, ${b}, ${opacity})`
}

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private bottomBarHeight: number = 56
  private fabSize: number = 56
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Main content area with vertical gradient background
      Column() {
        // Title
        applyTypography(Text('Metro Planner'), AppTokens.Typography.display)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        // Canvas for drawing the metro line and stations
        Canvas(this)
          .width('100%')
          .height(260)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .margin({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .onReady((context: CanvasRenderingContext2D) => {
            const canvasWidth = context.canvas.width
            const canvasHeight = context.canvas.height
            const step = canvasWidth / (this.stations.length - 1)

            // Draw the line with a linear gradient
            const gradient = context.createLinearGradient(0, 0, canvasWidth, 0)
            gradient.addColorStop(0, AppTokens.Colors.secondary)
            gradient.addColorStop(1, AppTokens.Colors.primary)
            
            context.beginPath()
            for (let i = 0; i < this.stations.length; i++) {
              const x = i * step
              const y = i % 2 === 0 ? canvasHeight / 4 : (canvasHeight * 3) / 4
              if (i === 0) {
                context.moveTo(x, y)
              } else {
                context.lineTo(x, y)
              }
            }
            context.lineWidth = 6
            context.strokeStyle = gradient
            context.stroke()

            // Draw the circles for stations
            for (let i = 0; i < this.stations.length; i++) {
              const x = i * step
              const y = i % 2 === 0 ? canvasHeight / 4 : (canvasHeight * 3) / 4

              // Outer circle
              context.beginPath()
              context.arc(x, y, 16, 0, Math.PI * 2)
              context.fillStyle = AppTokens.Colors.primary
              context.fill()

              // Inner circle
              context.beginPath()
              context.arc(x, y, 6, 0, Math.PI * 2)
              context.fillStyle = AppTokens.Colors.background
              context.fill()
            }
          })

        // Card for "Next Departures" section
        Column() {
          applyTypography(Text('Next Departures'), AppTokens.Typography.title)
            .fontColor(AppTokens.Colors.secondary)
            .margin({ bottom: AppTokens.Spacing.sm })

          ForEach(this.departures, (departure: string) => {
            Row() {
              applyTypography(Text(departure), AppTokens.Typography.body)
                .fontColor(AppTokens.Colors.onSurface)
              Blank() // Acts like Spacer() in SwiftUI
              applyTypography(Text('On Time'), AppTokens.Typography.label)
                .fontColor(AppTokens.Colors.success)
            }
            .width('100%')
            .margin({ top: AppTokens.Spacing.sm })
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: hexToRgba(AppTokens.Colors.outline, AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .margin({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        Blank() // Pushes content up
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 0.5], [AppTokens.Colors.background, 1.0]]
      })
      .padding({ bottom: this.bottomBarHeight })

      // Floating Action Button (FAB)
      Row() {
        Blank()
        Button({ type: ButtonType.Circle }) {
          Text('+')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppTokens.Colors.primary)
        .margin({ right: AppTokens.Spacing.lg, bottom: this.bottomBarHeight + AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar
      Column() {
        Blank() // Pushes the bottom bar to the very bottom
        Row() {
          applyTypography(Text('Routes'), AppTokens.Typography.body)
            .fontColor(AppTokens.Colors.secondary)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          applyTypography(Text('Planner'), AppTokens.Typography.body)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          applyTypography(Text('Tickets'), AppTokens.Typography.body)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          applyTypography(Text('Profile'), AppTokens.Typography.body)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(this.bottomBarHeight)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}