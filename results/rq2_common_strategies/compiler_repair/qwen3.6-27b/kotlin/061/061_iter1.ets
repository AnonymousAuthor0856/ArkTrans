import { random } from '@kit.ArkTS'

// Token Definitions matching AppTokens
const COLORS = {
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
  onSurface: '#1F2937'
}

interface TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

const TYPOGRAPHY = {
  display: { fontSize: 26, fontWeight: FontWeight.Bold },
  headline: { fontSize: 18, fontWeight: FontWeight.Medium },
  title: { fontSize: 14, fontWeight: FontWeight.Medium },
  body: { fontSize: 12, fontWeight: FontWeight.Normal }
}

const SHAPES = {
  small: 6,
  medium: 10,
  large: 16
}

const SPACING = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 22
}

@Entry
@Component
struct ParcelTrackerApp {
  @State dragOffset: Point = new Point(0, 0)
  @State parcelPoints: Point[] = []
  private canvasSize: Size = new Size(0, 0)

  aboutToAppear() {
    // Generate 25 random points
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push(new Point(
        Math.random() * 400,
        Math.random() * 300
      ))
    }
  }

  build() {
    Column() {
      Text('Parcel Tracker')
        .font({ size: TYPOGRAPHY.display.fontSize, weight: TYPOGRAPHY.display.fontWeight })
        .fontColor(COLORS.onBackground)
        .margin({ top: SPACING.lg })

      // Parcel Canvas Component
      Column() {
        Canvas(this)
          .width('100%')
          .height(300)
          .backgroundColor(COLORS.surface)
          .borderRadius(SHAPES.large)
          .border({ width: 1, color: COLORS.outline, radius: SHAPES.large })
          .onTouch((event: TouchEvent) => {
            if (event.touches.length > 0) {
              const touch = event.touches[0]
              let newX = this.dragOffset.x + touch.location.x - touch.preLocation.x
              let newY = this.dragOffset.y + touch.location.y - touch.preLocation.y

              // Clamp values within canvas bounds (approximate based on padding)
              const padding = 10
              const maxX = this.canvasSize.width - padding * 2
              const maxY = this.canvasSize.height - padding * 2

              newX = Math.max(padding, Math.min(maxX, newX))
              newY = Math.max(padding, Math.min(maxY, newY))

              this.dragOffset = new Point(newX, newY)
            }
          })
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.canvasSize = new Size(newValue.width, newValue.height)
          })

        Text('Drag to locate parcel')
          .font({ size: TYPOGRAPHY.body.fontSize, weight: TYPOGRAPHY.body.fontWeight })
          .fontColor(COLORS.onSurface)
          .margin({ top: 10 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: SPACING.xl })

      Text('Visualize parcel movements and positions.')
        .font({ size: TYPOGRAPHY.body.fontSize, weight: TYPOGRAPHY.body.fontWeight })
        .fontColor(COLORS.onSurface)
        .margin({ top: SPACING.xl })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Top,
      colors: [[COLORS.surfaceVariant, 0], [COLORS.background, 1]]
    })
    .padding(SPACING.lg)
  }

  draw(canvas: CanvasRenderingContext2D, area: Area) {
    // Draw Parcel Points
    this.parcelPoints.forEach(point => {
      canvas.beginPath()
      canvas.arc(point.x, point.y, 4, 0, 2 * Math.PI)
      canvas.fillStyle = COLORS.secondary
      canvas.fill()
    })

    // Draw Drag Circle
    canvas.beginPath()
    canvas.arc(this.dragOffset.x, this.dragOffset.y, 20, 0, 2 * Math.PI)
    canvas.strokeStyle = COLORS.primary
    canvas.lineWidth = 3
    canvas.stroke()
  }
}