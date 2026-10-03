const NAME: string = '025Whiteboarden'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#EF476F'
  static readonly secondary: string = '#FFD166'
  static readonly tertiary: string = '#06D6A0'
  static readonly background: string = '#FFFCF2'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F7EDE2'
  static readonly outline: string = '#E5D4B1'
  static readonly success: string = '#06D6A0'
  static readonly warning: string = '#FFA600'
  static readonly error: string = '#D62828'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#1E1E1E'
  static readonly onBackground: string = '#1E1E1E'
  static readonly onSurface: string = '#1E1E1E'
}

class AppTypography {
  static readonly displaySize: number = 26
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
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
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16)
}

interface BoardPoint {
  x: number
  y: number
}

@Entry
@Component
struct MainActivity {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  @State private points: BoardPoint[] = []
  @State private color: string = AppColors.primary
  @State private canvasWidth: number = 0
  @State private canvasHeight: number = 0

  private drawBoard(): void {
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
    this.context.fillStyle = AppColors.background
    this.context.fillRect(0, 0, this.canvasWidth, this.canvasHeight)

    this.points.forEach((point: BoardPoint) => {
      this.context.beginPath()
      this.context.fillStyle = this.color
      this.context.arc(point.x, point.y, 10, 0, Math.PI * 2)
      this.context.fill()
      this.context.closePath()
    })
  }

  private addPoint(x: number, y: number): void {
    this.points.push({ x: x, y: y })
    this.drawBoard()
  }

  private clearBoard(): void {
    this.points = []
    this.drawBoard()
  }

  private selectColor(color: string): void {
    this.color = color
    this.drawBoard()
  }

  @Builder
  TopBar() {
    Row() {
      Text('Retro Whiteboard')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  BottomBar() {
    Row() {
      Button('Red')
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)
        .onClick(() => {
          this.selectColor(AppColors.primary)
        })

      Button('Yellow')
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .onClick(() => {
          this.selectColor(AppColors.secondary)
        })

      Button('Green')
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onTertiary)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.small)
        .onClick(() => {
          this.selectColor(AppColors.tertiary)
        })
    }
    .width('100%')
    .height(80)
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: ElevationMapping.level1.radius,
      color: '#1F000000',
      offsetX: 0,
      offsetY: ElevationMapping.level1.dy
    })
  }

  @Builder
  FloatingClearButton() {
    Button('Clear')
      .width(64)
      .height(64)
      .borderRadius(32)
      .fontSize(AppTypography.labelSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSecondary)
      .backgroundColor(AppColors.secondary)
      .shadow({
        radius: ElevationMapping.level2.radius,
        color: '#29000000',
        offsetX: 0,
        offsetY: ElevationMapping.level2.dy
      })
      .onClick(() => {
        this.clearBoard()
      })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        Canvas(this.context)
          .width('100%')
          .layoutWeight(1)
          .backgroundColor(AppColors.background)
          .onReady(() => {
            this.drawBoard()
          })
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.canvasWidth = Number(newValue.width)
            this.canvasHeight = Number(newValue.height)
            this.drawBoard()
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              if (event.touches.length > 0) {
                this.addPoint(event.touches[0].x, event.touches[0].y)
              }
            }
          })

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      this.FloatingClearButton()
        .margin({
          right: AppSpacing.lg,
          bottom: 96
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}