@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}

class AppTokens {
  static readonly Colors = class {
    static readonly primary: string = '#FF111827'
    static readonly secondary: string = '#FF374151'
    static readonly tertiary: string = '#FF6B7280'
    static readonly background: string = '#FFF9FAFB'
    static readonly surface: string = '#FFFFFFFF'
    static readonly surfaceVariant: string = '#FFE5E7EB'
    static readonly outline: string = '#FFD1D5DB'
    static readonly onPrimary: string = '#FFFFFFFF'
    static readonly onSecondary: string = '#FFFFFFFF'
    static readonly onBackground: string = '#FF111827'
    static readonly onSurface: string = '#FF1F2937'
  }

  static readonly Typography = class {
    static readonly display: { fontSize: number, fontWeight: FontWeight } = {
      fontSize: 26,
      fontWeight: FontWeight.Bold
    }
    static readonly headline: { fontSize: number, fontWeight: FontWeight } = {
      fontSize: 18,
      fontWeight: FontWeight.SemiBold
    }
    static readonly title: { fontSize: number, fontWeight: FontWeight } = {
      fontSize: 14,
      fontWeight: FontWeight.Medium
    }
    static readonly body: { fontSize: number, fontWeight: FontWeight } = {
      fontSize: 12,
      fontWeight: FontWeight.Normal
    }
  }

  static readonly Shapes = class {
    static readonly small: number = 6
    static readonly medium: number = 10
    static readonly large: number = 16
  }

  static readonly Spacing = class {
    static readonly sm: number = 6
    static readonly md: number = 10
    static readonly lg: number = 14
    static readonly xl: number = 22
  }
}

interface ParcelPoint {
  x: number
  y: number
}

@Component
struct ParcelCanvas {
  @State dragX: number = 0
  @State dragY: number = 0
  @State parcelPoints: ParcelPoint[] = []
  private canvasWidth: number = 0
  private canvasHeight: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
    this.parcelPoints = []
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push({
        x: Math.random() * 400,
        y: Math.random() * 300
      })
    }
  }

  private draw() {
    const ctx = this.context
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    this.parcelPoints.forEach((point) => {
      ctx.fillStyle = AppTokens.Colors.secondary
      ctx.beginPath()
      ctx.arc(point.x, point.y, 4, 0, Math.PI * 2)
      ctx.fill()
    })

    ctx.strokeStyle = AppTokens.Colors.primary
    ctx.lineWidth = 3
    ctx.beginPath()
    ctx.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2)
    ctx.stroke()
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .padding(10)
        .onReady(() => {
          const info = this.context.measureText('')
          this.draw()
        })
        .onAreaChange((oldArea: Area, newArea: Area) => {
          this.canvasWidth = Number(newArea.width)
          this.canvasHeight = Number(newArea.height)
          this.draw()
        })

      Text('Drag to locate parcel')
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          const newX = this.dragX + event.offsetX
          const newY = this.dragY + event.offsetY
          this.dragX = Math.max(0, Math.min(this.canvasWidth, newX))
          this.dragY = Math.max(0, Math.min(this.canvasHeight, newY))
          this.draw()
        })
    )
  }
}

@Component
struct RootScreen {
  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.background, 1.0]
      ]
    })
  }
}
