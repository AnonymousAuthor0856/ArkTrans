class AppColors {
  static readonly primary: string = '#06B6D4'
  static readonly secondary: string = '#3B82F6'
  static readonly tertiary: string = '#8B5CF6'
  static readonly background: string = '#F0F9FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surface90: string = '#E6FFFFFF'
  static readonly surfaceVariant: string = '#E0F2FE'
  static readonly outline: string = '#BAE6FD'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#FACC15'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct RootScreen {
  @State private markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ]
  @State private scanning: boolean = false

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private canvasReady: boolean = false
  private canvasWidth: number = 0
  private canvasHeight: number = 0

  private drawCanvas(): void {
    if (!this.canvasReady || this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return
    }

    const ctx = this.canvasContext
    const width = this.canvasWidth
    const height = this.canvasHeight
    const centerX = width / 2
    const centerY = height / 2
    const radius = Math.min(width, height) / 2.5

    ctx.clearRect(0, 0, width, height)

    ctx.beginPath()
    ctx.fillStyle = AppColors.surfaceVariant
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = AppColors.primary
    this.markers.forEach((marker: Marker) => {
      ctx.beginPath()
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2)
      ctx.fill()
    })
  }

  private addMarker(): void {
    if (!this.scanning) {
      return
    }

    const x = Math.floor(Math.random() * 501) + 80
    const y = Math.floor(Math.random() * 501) + 150
    const nextMarkers: Marker[] = this.markers.concat([
      new Marker(x, y, `N${this.markers.length + 1}`)
    ])

    this.markers = nextMarkers
    this.drawCanvas()
  }

  @Builder
  private ScannerToggle() {
    Stack() {
      Row()
        .width(50)
        .height(30)
        .borderRadius(15)
        .backgroundColor(this.scanning ? AppColors.secondary : AppColors.surfaceVariant)

      Stack({ alignContent: this.scanning ? Alignment.End : Alignment.Start }) {
        Row()
          .width(26)
          .height(26)
          .borderRadius(13)
          .backgroundColor(this.scanning ? AppColors.secondary : AppColors.outline)
      }
      .width(46)
      .height(26)
    }
    .width(50)
    .height(30)
    .onClick(() => {
      this.scanning = !this.scanning
    })
  }

  build() {
    Column({ space: 0 }) {
      Text('Invoice Scanner')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .padding({
          top: AppSpacing.lg,
          bottom: AppSpacing.lg
        })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.canvasReady = true
              this.drawCanvas()
            })
            .onAreaChange((oldArea, newArea) => {
              this.canvasWidth = Number(newArea.width)
              this.canvasHeight = Number(newArea.height)
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(400)
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface90)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 4
        })
        .clip(true)

        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          this.ScannerToggle()
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Button() {
          Text('Add Marker')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .type(ButtonType.Normal)
        .width('100%')
        .height(48)
        .borderRadius(AppShapes.medium)
        .backgroundColor(AppColors.primary)
        .onClick(() => {
          this.addMarker()
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          [AppColors.background, 0.5],
          ['#4D06B6D4', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}