import { Color, FontSize, FontWeight, PixelMap, Rect, RenderContext, StrokeCapStyle, TextAlign } from '@kit.ArkGraphics'
import { BusinessError } from '@kit.BasicServicesKit'

// --- App Tokens & Constants ---
const NAME = "068*MetroPlanner*en"
const UI_TYPE = "Travel"
const STYLE_THEME = "Dark Neon"
const LANG = "en"
const BASELINE_SIZE = "720x1280"

class AppTokens {
  static Colors = {
    primary: '#00FFFF',
    secondary: '#00B4FF',
    tertiary: '#8A2BE2',
    background: '#0A0A1A',
    surface: '#141436',
    surfaceVariant: '#1E1E4A',
    outline: '#2E2E5C',
    success: '#00FFAA',
    warning: '#FFCC00',
    error: '#FF4444',
    onPrimary: '#0A0A1A',
    onSecondary: '#FFFFFF',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF'
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  }
}

// --- Custom Metro Map Component ---
@Component
struct MetroMapCanvas {
  private stations: string[] = ["A", "B", "C", "D", "E", "F"]
  
  build() {
    Canvas(this)
      .width('100%')
      .height(260)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(22)
      .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
  }

  onDraw(context: RenderContext, size: { width: number, height: number }): void {
    const path = context.createPath()
    const step = size.width / (this.stations.length - 1)
    
    // Draw Line
    this.stations.forEach((_, i) => {
      const x = i * step
      const y = i % 2 === 0 ? size.height / 4 : size.height * 3 / 4
      
      if (i === 0) {
        path.moveTo(x, y)
      } else {
        path.lineTo(x, y)
      }
    })

    // Gradient Brush for line
    const gradientBrush = context.createLinearGradient(0, 0, size.width, 0)
    gradientBrush.addColorStop(0, new Color(AppTokens.Colors.secondary))
    gradientBrush.addColorStop(1, new Color(AppTokens.Colors.primary))
    
    context.strokePath(path, {
      brush: gradientBrush,
      strokeWidth: 6,
      strokeCapStyle: StrokeCapStyle.ROUND
    })

    // Draw Stations
    this.stations.forEach((_, i) => {
      const x = i * step
      const y = i % 2 === 0 ? size.height / 4 : size.height * 3 / 4
      
      // Outer Circle
      context.drawCircle(x, y, 16, {
        brush: new Color(AppTokens.Colors.primary)
      })
      
      // Inner Circle
      context.drawCircle(x, y, 6, {
        brush: new Color(AppTokens.Colors.background)
      })
    })
  }
}

// --- Main Page ---
@Entry
@Component
struct MetroPlannerPage {
  @State departures: string[] = [
    "08:45 • Line 1",
    "09:10 • Line 2",
    "09:30 • Line 3"
  ]

  build() {
    Stack() {
      Column() {
        // Header
        Text("Metro Planner")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.lg })

        // Map Section
        MetroMapCanvas()

        // Departures Card
        Column() {
          Text("Next Departures")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
            .margin({ bottom: AppTokens.Spacing.sm })

          ForEach(this.departures, (item: string) => {
            Row() {
              Text(item)
                .fontSize(14)
                .fontColor(AppTokens.Colors.onSurface)
                .textAlign(TextAlign.Start)
              
              Blank()

              Text("On Time")
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.success)
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.sm })
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(22)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.15)', offsetY: 4 })
        
        Spacer().size({ height: AppTokens.Spacing.md })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.background, 0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1]
        ]
      })

      // Floating Action Button
      Button("+", { type: ButtonType.Circle })
        .width(64)
        .height(64)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .position({ x: 'calc(100% - 60vp)', y: 'calc(100% - 140vp)' })

      // Bottom Navigation Bar
      Row() {
        Text("Routes")
          .fontSize(14)
          .fontColor(AppTokens.Colors.secondary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Text("Planner")
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          
        Text("Tickets")
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          
        Text("Profile")
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .position({ x: 0, y: 'calc(100% - 60vp)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}