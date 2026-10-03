const Colors = {
  primary: '#111827',
  secondary: '#374151',
  tertiary: '#6B7280',
  background: '#F9FAFB',
  surface: '#FFFFFF',
  surfaceVariant: '#E5E7EB',
  outline: '#D1D5DB',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onBackground: '#111827',
  onSurface: '#1F2937',
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 22,
}

interface Point {
  x: number
  y: number
}

@Component
struct ParcelCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State dragX: number = 200
  @State dragY: number = 150
  private points: Point[] = []

  aboutToAppear(): void {
    for (let i = 0; i < 25; i++) {
      this.points.push({ x: Math.random() * 400, y: Math.random() * 300 })
    }
  }

  private drawParcel(): void {
    this.context.clearRect(0, 0, 400, 300)
    for (const p of this.points) {
      this.context.beginPath()
      this.context.fillStyle = Colors.secondary
      this.context.arc(p.x, p.y, 4, 0, Math.PI * 2)
      this.context.fill()
    }
    this.context.beginPath()
    this.context.strokeStyle = Colors.primary
    this.context.lineWidth = 3
    this.context.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2)
    this.context.stroke()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height(300)
        .onReady(() => {
          this.drawParcel()
        })
      Text('Drag to locate parcel')
        .fontSize(12)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(Colors.surface)
    .borderRadius(16)
    .border({ width: 1, color: Colors.outline })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Move && event.touches.length > 0) {
        this.dragX = Math.min(400, Math.max(0, event.touches[0].x))
        this.dragY = Math.min(300, Math.max(0, event.touches[0].y))
        this.drawParcel()
      }
    })
  }
}

@Entry
@Component
struct Index {
  build() {
    Column({ space: Spacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)
      ParcelCanvas()
      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(Spacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[Colors.surfaceVariant, 0], [Colors.background, 1]]
    })
  }
}
