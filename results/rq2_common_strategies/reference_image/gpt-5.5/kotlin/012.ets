const NAME: string = '009FavoritesGriden'
const UI_TYPE: string = 'Social'
const STYLE_THEME: string = 'Glassmorphic'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#60A5FA'
  static readonly secondary: string = '#93C5FD'
  static readonly tertiary: string = '#A5B4FC'
  static readonly background: string = '#F9FAFB'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#EFF6FF'
  static readonly outline: string = '#D1D5DB'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#DC2626'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E293B'
  static readonly onTertiary: string = '#1E1E2F'
  static readonly onBackground: string = '#111827'
  static readonly onSurface: string = '#111827'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

@Entry
@Component
struct Index {
  private readonly markerX: number = 200
  private readonly markerY: number = 400
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawMap(): void {
    const width: number = this.context.width
    const height: number = this.context.height

    this.context.clearRect(0, 0, width, height)

    const centerX: number = width / 2
    const centerY: number = height / 2
    const markerDrawX: number = px2vp(this.markerX)
    const markerDrawY: number = px2vp(this.markerY)

    this.context.beginPath()
    this.context.fillStyle = 'rgba(147, 197, 253, 0.20)'
    this.context.arc(centerX, centerY, px2vp(340), 0, Math.PI * 2)
    this.context.fill()

    this.context.beginPath()
    this.context.fillStyle = 'rgba(147, 197, 253, 0.30)'
    this.context.arc(centerX, centerY, px2vp(220), 0, Math.PI * 2)
    this.context.fill()

    this.context.beginPath()
    this.context.fillStyle = AppColors.primary
    this.context.arc(markerDrawX, markerDrawY, px2vp(14), 0, Math.PI * 2)
    this.context.fill()

    this.context.beginPath()
    this.context.strokeStyle = 'rgba(96, 165, 250, 0.30)'
    this.context.lineWidth = px2vp(3)
    this.context.arc(markerDrawX, markerDrawY, px2vp(30), 0, Math.PI * 2)
    this.context.stroke()
  }

  build() {
    Column() {
      Row() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawMap()
            })
            .onAreaChange(() => {
              this.drawMap()
            })
        }
        .width('100%')
        .height(400)
        .backgroundColor('#CCFFFFFF')
        .border({
          width: 1,
          color: AppColors.outline
        })
        .borderRadius(24)
        .clip(true)

        Column({ space: AppSpacing.md }) {
          Text(`Spot Coordinates: (${Math.trunc(this.markerX)}, ${Math.trunc(this.markerY)})`)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)

          Button('Save Marker', { type: ButtonType.Normal, stateEffect: true })
            .width('100%')
            .height(48)
            .borderRadius(16)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
            })
        }
        .width('100%')
        .align(Alignment.Bottom)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .linearGradient({
        angle: 135,
        colors: [
          [0x99FFFFFF, 0.0],
          [0x80EFF6FF, 0.5],
          [0xB3FFFFFF, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}