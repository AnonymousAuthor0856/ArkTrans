@Entry
@Component
struct Index {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}

class AppColors {
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

class TextStyleToken {
  fontSize: number = 0
  fontWeight: FontWeight = FontWeight.Normal
}

class AppTypography {
  static get display(): TextStyleToken {
    let t = new TextStyleToken()
    t.fontSize = 26
    t.fontWeight = FontWeight.Bold
    return t
  }
  static get headline(): TextStyleToken {
    let t = new TextStyleToken()
    t.fontSize = 18
    t.fontWeight = FontWeight.Medium
    return t
  }
  static get title(): TextStyleToken {
    let t = new TextStyleToken()
    t.fontSize = 14
    t.fontWeight = FontWeight.Medium
    return t
  }
  static get body(): TextStyleToken {
    let t = new TextStyleToken()
    t.fontSize = 12
    t.fontWeight = FontWeight.Normal
    return t
  }
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 22
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
      let p: ParcelPoint = { x: Math.random() * 400, y: Math.random() * 300 }
      this.parcelPoints.push(p)
    }
  }

  private draw(): void {
    let ctx = this.context
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    for (let i = 0; i < this.parcelPoints.length; i++) {
      let point = this.parcelPoints[i]
      ctx.fillStyle = AppColors.secondary
      ctx.beginPath()
      ctx.arc(point.x, point.y, 4, 0, Math.PI * 2)
      ctx.fill()
    }

    ctx.strokeStyle = AppColors.primary
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
          this.draw()
        })
        .onAreaChange((oldArea: Area, newArea: Area) => {
          this.canvasWidth = Number(newArea.width)
          this.canvasHeight = Number(newArea.height)
          this.draw()
        })

      Text('Drag to locate parcel')
        .fontSize(AppTypography.body.fontSize)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          let newX = this.dragX + event.offsetX
          let newY = this.dragY + event.offsetY
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
    Column({ space: AppSpacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(AppTypography.display.fontSize)
        .fontWeight(AppTypography.display.fontWeight)
        .fontColor(AppColors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTypography.body.fontSize)
        .fontWeight(AppTypography.body.fontWeight)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.background, 1.0]
      ]
    })
  }
}
