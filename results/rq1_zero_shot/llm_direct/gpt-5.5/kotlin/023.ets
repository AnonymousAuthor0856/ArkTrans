const NAME: string = '024PomodoroTimeren'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Soft Pastel'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#FF8FAB'
  static readonly secondary: string = '#B4E3D0'
  static readonly tertiary: string = '#FFD6A5'
  static readonly background: string = '#FFFCF9'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FDE2E4'
  static readonly outline: string = '#FCC2D7'
  static readonly success: string = '#4ADE80'
  static readonly warning: string = '#FACC15'
  static readonly error: string = '#FB7185'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#1E1E1E'
  static readonly onBackground: string = '#1E1E1E'
  static readonly onSurface: string = '#1E1E1E'
}

class AppTypographyTokens {
  static readonly displaySize: number = 30
  static readonly titleSize: number = 20
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppSpacing {
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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
}

@Entry
@Component
struct PomodoroTimerPage {
  private readonly canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings)

  @State private knobX: number = 0
  @State private knobY: number = 0
  @State private isRunning: boolean = false

  private get progressValue(): number {
    return (((this.knobX + this.knobY) % 400) / 400) * 100
  }

  private drawTimerCanvas(): void {
    this.canvasContext.clearRect(0, 0, 280, 280)

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = 'rgba(180, 227, 208, 0.4)'
    this.canvasContext.arc(140, 140, 180, 0, Math.PI * 2)
    this.canvasContext.fill()

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = AppColors.primary
    this.canvasContext.arc(this.knobX, this.knobY, 30, 0, Math.PI * 2)
    this.canvasContext.fill()
  }

  build() {
    Column() {
      Row() {
        Text('Pomodoro Timer')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.xl }) {
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.canvasContext)
            .width(280)
            .height(280)
            .onReady(() => {
              this.drawTimerCanvas()
            })
            .onTouch((event: TouchEvent) => {
              if ((event.type === TouchType.Down || event.type === TouchType.Move) && event.touches.length > 0) {
                this.knobX = event.touches[0].x
                this.knobY = event.touches[0].y
                this.drawTimerCanvas()
              }
            })
        }
        .width(280)
        .height(280)
        .borderRadius(140)
        .clip(true)
        .backgroundColor(AppColors.surfaceVariant)
        .shadow({
          radius: AppElevationMapping.level2.radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })

        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? AppColors.success : AppColors.error)

        Row({ space: AppSpacing.lg }) {
          Button() {
            Text('Start')
              .fontSize(AppTypographyTokens.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onPrimary)
          }
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(AppColors.primary)
          .onClick(() => {
            this.isRunning = true
          })

          Button() {
            Text('Stop')
              .fontSize(AppTypographyTokens.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSecondary)
          }
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(AppColors.tertiary)
          .onClick(() => {
            this.isRunning = false
          })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Progress({
          value: this.progressValue,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(4)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}