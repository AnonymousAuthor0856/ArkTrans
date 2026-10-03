interface ParcelPoint {
  x: number
  y: number
}

// MARK: - AppTokens
// 集中管理应用程序的颜色、字体、形状和间距。
// 这使得全局修改 UI 样式变得非常方便。
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#111827'
    export const secondary: ResourceColor = '#374151'
    export const tertiary: ResourceColor = '#6B7280'
    export const background: ResourceColor = '#F9FAFB'
    export const surface: ResourceColor = '#FFFFFF'
    export const surfaceVariant: ResourceColor = '#E5E7EB'
    export const outline: ResourceColor = '#D1D5DB'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#FFFFFF'
    export const onBackground: ResourceColor = '#111827'
    export const onSurface: ResourceColor = '#1F2937'
  }

  export namespace TypographyTokens {
    export const display: Font = { size: 26, weight: FontWeight.Bold }
    export const headline: Font = { size: 18, weight: 600 }
    export const title: Font = { size: 14, weight: FontWeight.Medium }
    export const body: Font = { size: 12, weight: FontWeight.Regular }
  }

  export namespace Shapes {
    export const smallCornerRadius: Length = 6
    export const mediumCornerRadius: Length = 10
    export const largeCornerRadius: Length = 16
  }

  export namespace Spacing {
    export const sm: Length = 6
    export const md: Length = 10
    export const lg: Length = 14
    export const xl: Length = 22
  }
}

// MARK: - ParcelCanvas
// 对应 Kotlin 的 ParcelCanvas Composable 函数 / SwiftUI 的 ParcelCanvas View
@Component
export struct ParcelCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  @State dragX: number = 0
  @State dragY: number = 0
  @State parcelPoints: ParcelPoint[] = []

  private canvasWidth: number = 0
  private canvasHeight: number = 0
  private readonly circleRadius: number = 20
  private readonly pointRadius: number = 4
  private readonly paddingValue: number = 10
  private readonly canvasHeightValue: number = 300

  private generateRandomPoints(width: number, height: number): ParcelPoint[] {
    const points: ParcelPoint[] = []
    for (let i = 0; i < 25; i++) {
      const p: ParcelPoint = {
        x: Math.random() * width,
        y: Math.random() * height
      }
      points.push(p)
    }
    return points
  }

  private draw(): void {
    const ctx = this.context
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    // 绘制所有包裹点
    ctx.fillStyle = AppTokens.Colors.secondary as string
    for (let i = 0; i < this.parcelPoints.length; i++) {
      const point = this.parcelPoints[i]
      ctx.beginPath()
      ctx.arc(point.x, point.y, this.pointRadius, 0, Math.PI * 2)
      ctx.fill()
    }

    // 绘制可拖动的中心圆圈
    ctx.strokeStyle = AppTokens.Colors.primary as string
    ctx.lineWidth = 3
    ctx.beginPath()
    ctx.arc(this.dragX, this.dragY, this.circleRadius, 0, Math.PI * 2)
    ctx.stroke()
  }

  private onCanvasReady(): void {
    const effectiveWidth = this.canvasWidth - this.paddingValue * 2
    const effectiveHeight = this.canvasHeight - this.paddingValue * 2

    this.parcelPoints = this.generateRandomPoints(effectiveWidth, effectiveHeight)
    this.dragX = this.circleRadius + Math.random() * (effectiveWidth - this.circleRadius * 2)
    this.dragY = this.circleRadius + Math.random() * (effectiveHeight - this.circleRadius * 2)

    // 偏移以适应内部 padding
    this.dragX += this.paddingValue
    this.dragY += this.paddingValue
    for (let i = 0; i < this.parcelPoints.length; i++) {
      this.parcelPoints[i].x += this.paddingValue
      this.parcelPoints[i].y += this.paddingValue
    }

    this.draw()
  }

  private handlePanUpdate(event: GestureEvent): void {
    const effectiveWidth = this.canvasWidth - this.paddingValue * 2
    const effectiveHeight = this.canvasHeight - this.paddingValue * 2

    // 获取相对于 Canvas 的位置
    let x = event.offsetX
    let y = event.offsetY

    // 限制在有效绘制区域内（考虑内部 padding 和圆圈半径）
    x = Math.max(this.paddingValue + this.circleRadius,
      Math.min(x, this.paddingValue + effectiveWidth - this.circleRadius))
    y = Math.max(this.paddingValue + this.circleRadius,
      Math.min(y, this.paddingValue + effectiveHeight - this.circleRadius))

    this.dragX = x
    this.dragY = y
    this.draw()
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .padding(this.paddingValue)
        .onReady(() => {
          this.onCanvasReady()
        })

      Text('Drag to locate parcel')
        .font(AppTokens.TypographyTokens.body)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(this.canvasHeightValue)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.largeCornerRadius
    })
    .onAreaChange((oldArea: Area, newArea: Area) => {
      this.canvasWidth = newArea.width as number
      this.canvasHeight = newArea.height as number
    })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          this.handlePanUpdate(event)
        })
    )
  }
}

// MARK: - RootScreen
// 对应 Kotlin 的 RootScreen Composable 函数 / SwiftUI 的 RootScreen View
@Entry
@Component
struct RootScreen {
  build() {
    Column({ space: AppTokens.Spacing.xl }) {
      Text('Parcel Tracker')
        .font(AppTokens.TypographyTokens.display)
        .fontColor(AppTokens.Colors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .font(AppTokens.TypographyTokens.body)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      colors: [[AppTokens.Colors.surfaceVariant, 0], [AppTokens.Colors.background, 1]],
      direction: GradientDirection.Bottom
    })
  }
}
