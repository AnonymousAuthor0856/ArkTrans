import promptAction from '@ohos.promptAction'

// MARK: - AppTokens

class ShadowSpec {
  elevation: number = 0
  radius: number = 0
  dy: number = 0
  opacity: number = 0

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

namespace AppTokens {
  export class Colors {
    static readonly primary: string = '#00FFFF'
    static readonly secondary: string = '#00B4FF'
    static readonly tertiary: string = '#8A2BE2'
    static readonly background: string = '#0A0A1A'
    static readonly surface: string = '#141436'
    static readonly surfaceVariant: string = '#1E1E4A'
    static readonly outline: string = '#2E2E5C'
    static readonly success: string = '#00FFAA'
    static readonly warning: string = '#FFCC00'
    static readonly error: string = '#FF4444'
    static readonly onPrimary: string = '#0A0A1A'
    static readonly onSecondary: string = '#FFFFFF'
    static readonly onBackground: string = '#FFFFFF'
    static readonly onSurface: string = '#FFFFFF'
  }

  export class TypographyTokens {
    static readonly displaySize: number = 28
    static readonly displayWeight: FontWeight = FontWeight.Bold
    static readonly titleSize: number = 18
    static readonly titleWeight: FontWeight = FontWeight.Medium
    static readonly bodySize: number = 14
    static readonly bodyWeight: FontWeight = FontWeight.Regular
    static readonly labelSize: number = 12
    static readonly labelWeight: FontWeight = FontWeight.Medium
  }

  export class Shapes {
    static readonly smallCornerRadius: number = 8
    static readonly mediumCornerRadius: number = 14
    static readonly largeCornerRadius: number = 22
  }

  export class Spacing {
    static readonly sm: number = 6
    static readonly md: number = 10
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 36
  }

  export class ElevationMapping {
    static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1)
    static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15)
    static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18)
  }
}

interface Station {
  label: string
}

interface DepartureItem {
  text: string
  status: string
}

// MARK: - MetroLineCanvas

@Component
struct MetroLineCanvas {
  private stations: Station[] = [
    { label: 'A' }, { label: 'B' }, { label: 'C' },
    { label: 'D' }, { label: 'E' }, { label: 'F' }
  ]
  @State canvasWidth: number = 0
  @State canvasHeight: number = 260
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width('100%')
      .height(260)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .padding(AppTokens.Spacing.md)
      .onAreaChange((oldVal: Area, newVal: Area) => {
        this.canvasWidth = newVal.width as number
        this.canvasHeight = (newVal.height as number) - 20
        this.onDraw()
      })
  }

  onDraw(): void {
    const ctx = this.context
    const width = this.canvasWidth - 20
    const height = this.canvasHeight
    const step = width / (this.stations.length - 1)
    const offsetX = 10
    const offsetY = 10

    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight + 20)

    // Draw metro line path
    ctx.beginPath()
    for (let i = 0; i < this.stations.length; i++) {
      const x = offsetX + i * step
      const y = offsetY + (i % 2 === 0 ? height / 4 : height * 3 / 4)
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }

    // Create gradient for the line
    const gradient = ctx.createLinearGradient(offsetX, 0, offsetX + width, 0)
    gradient.addColorStop(0, AppTokens.Colors.secondary)
    gradient.addColorStop(1, AppTokens.Colors.primary)

    ctx.strokeStyle = gradient
    ctx.lineWidth = 6
    ctx.lineCap = 'round'
    ctx.stroke()

    // Draw station circles
    for (let i = 0; i < this.stations.length; i++) {
      const x = offsetX + i * step
      const y = offsetY + (i % 2 === 0 ? height / 4 : height * 3 / 4)

      // Outer circle
      ctx.beginPath()
      ctx.arc(x, y, 16, 0, Math.PI * 2)
      ctx.fillStyle = AppTokens.Colors.primary
      ctx.fill()

      // Inner circle
      ctx.beginPath()
      ctx.arc(x, y, 6, 0, Math.PI * 2)
      ctx.fillStyle = AppTokens.Colors.background
      ctx.fill()
    }
  }
}

// MARK: - DepartureCard

@Component
struct DepartureCard {
  private departures: DepartureItem[] = [
    { text: '08:45 • Line 1', status: 'On Time' },
    { text: '09:10 • Line 2', status: 'On Time' },
    { text: '09:30 • Line 3', status: 'On Time' }
  ]

  build() {
    Column() {
      Text('Next Departures')
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.secondary)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.sm })

      ForEach(this.departures, (item: DepartureItem) => {
        Row() {
          Text(item.text)
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text(item.status)
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(AppTokens.TypographyTokens.labelWeight)
            .fontColor(AppTokens.Colors.success)
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.sm })
      }, (item: DepartureItem) => item.text)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: AppTokens.Colors.outline,
      offsetY: AppTokens.ElevationMapping.level2.dy,
      fill: false
    })
  }
}

// MARK: - BottomNavBar

@Component
struct BottomNavBar {
  @State selectedIndex: number = 0
  private items: string[] = ['Routes', 'Planner', 'Tickets', 'Profile']

  build() {
    Row() {
      ForEach(this.items, (item: string, index: number) => {
        Text(item)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(index === this.selectedIndex
            ? AppTokens.Colors.secondary
            : AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.selectedIndex = index
          })
      }, (item: string) => item)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  private readonly bottomBarHeight: number = 56
  private readonly fabSize: number = 56

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main content
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Metro Planner')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        MetroLineCanvas()
          .width('100%')

        DepartureCard()
          .width('100%')

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({
        top: AppTokens.Spacing.lg,
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        bottom: this.bottomBarHeight + AppTokens.Spacing.md
      })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      })

      // Floating Action Button
      Button('+')
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(this.fabSize / 2)
        .margin({
          right: AppTokens.Spacing.lg,
          bottom: this.bottomBarHeight + AppTokens.Spacing.lg
        })
        .onClick(() => {
          promptAction.showToast({ message: 'Add route' })
        })

      // Bottom navigation bar
      BottomNavBar()
        .width('100%')
        .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
