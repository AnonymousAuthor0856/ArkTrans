class AppColors {
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

class AppTypographyTokens {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 22
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

@Entry
@Component
struct MetroPlannerPage {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawMetroMap(): void {
    const width = this.canvasContext.width
    const height = this.canvasContext.height

    if (width <= 0 || height <= 0) {
      return
    }

    this.canvasContext.clearRect(0, 0, width, height)

    const radius = 16
    const innerStart = radius
    const innerWidth = width - radius * 2
    const step = innerWidth / (this.stations.length - 1)

    const gradient = this.canvasContext.createLinearGradient(0, 0, width, 0)
    gradient.addColorStop(0, AppColors.secondary)
    gradient.addColorStop(1, AppColors.primary)

    this.canvasContext.beginPath()
    this.stations.forEach((_: string, index: number) => {
      const x = innerStart + index * step
      const y = index % 2 === 0 ? height / 4 : height * 3 / 4

      if (index === 0) {
        this.canvasContext.moveTo(x, y)
      } else {
        this.canvasContext.lineTo(x, y)
      }
    })

    this.canvasContext.strokeStyle = gradient
    this.canvasContext.lineWidth = 6
    this.canvasContext.lineCap = 'round'
    this.canvasContext.lineJoin = 'round'
    this.canvasContext.stroke()

    this.stations.forEach((_: string, index: number) => {
      const x = innerStart + index * step
      const y = index % 2 === 0 ? height / 4 : height * 3 / 4

      this.canvasContext.beginPath()
      this.canvasContext.fillStyle = AppColors.primary
      this.canvasContext.arc(x, y, 16, 0, Math.PI * 2)
      this.canvasContext.fill()

      this.canvasContext.beginPath()
      this.canvasContext.fillStyle = AppColors.background
      this.canvasContext.arc(x, y, 6, 0, Math.PI * 2)
      this.canvasContext.fill()
    })
  }

  build() {
    Stack() {
      Column() {
        Text('Metro Planner')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height(240)
            .onReady(() => {
              this.drawMetroMap()
            })
            .onAreaChange(() => {
              this.drawMetroMap()
            })
        }
        .width('100%')
        .height(260)
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.large)

        Column({ space: AppSpacing.sm }) {
          Text('Next Departures')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .width('100%')

          ForEach(this.departures, (item: string) => {
            Row() {
              Text(item)
                .fontSize(AppTypographyTokens.bodySize)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppColors.onSurface)

              Text('On Time')
                .fontSize(AppTypographyTokens.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.success)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (item: string) => item)
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4
        })

        Blank()
          .height(AppSpacing.md)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: 96
      })
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 0.5],
          [AppColors.background, 1.0]
        ]
      })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .space(AppSpacing.lg)

      Row() {
        Text('Routes')
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.secondary)

        Text('Planner')
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)

        Text('Tickets')
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)

        Text('Profile')
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .align(Alignment.Bottom)

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width(56)
      .height(56)
      .backgroundColor(AppColors.primary)
      .align(Alignment.BottomEnd)
      .margin({
        right: AppSpacing.xl,
        bottom: 72
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}