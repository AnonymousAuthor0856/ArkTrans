// InstallmentPlan.ets
// ArkTS conversion of SwiftUI Installment Plan screen

// ---- App Tokens ----
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFA500'
    export const secondary: string = '#FFC107'
    export const tertiary: string = '#FFE066'
    export const background: string = '#FFFBF2'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#FFEED6'
    export const onSurface: string = '#1E1E1E'
    export const onTertiary: string = '#1E1E1E'
  }

  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 12
    export const large: number = 20
  }

  export namespace Spacing {
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 32
  }

  export namespace Elevation {
    export const level2Radius: number = 8
    export const level2Dy: number = 4
    export const level2Opacity: number = 0.18
  }
}

// ---- Custom Linear Progress Indicator ----
@Component
struct CustomLinearProgressIndicator {
  @Prop progress: number = 0
  @Prop color: string = AppTokens.Colors.primary
  @Prop trackColor: string = AppTokens.Colors.surfaceVariant
  @Prop indicatorHeight: number = 8

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(this.indicatorHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.indicatorHeight / 2)

      // Progress fill
      Row()
        .width(`${this.progress * 100}%`)
        .height(this.indicatorHeight)
        .backgroundColor(this.color)
        .borderRadius(this.indicatorHeight / 2)
    }
    .width('100%')
    .height(this.indicatorHeight)
  }
}

// ---- Surface with Canvas (sine wave drawing) ----
@Component
struct SurfaceWithCanvas {
  @Link paymentProgress: number

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear(): void {
    this.drawWave()
  }

  aboutToUpdate(): void {
    this.drawWave()
  }

  drawWave(): void {
    const w: number = this.context.width
    const h: number = this.context.height
    if (w === 0 || h === 0) {
      return
    }
    const step: number = w / 20

    this.context.clearRect(0, 0, w, h)
    this.context.strokeStyle = AppTokens.Colors.primary
    this.context.lineWidth = 5
    this.context.lineCap = 'round'
    this.context.lineJoin = 'round'

    this.context.beginPath()
    const initialY: number = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
    this.context.moveTo(0, initialY)

    for (let i: number = 1; i <= 20; i++) {
      const x: number = i * step
      const y: number = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
      this.context.lineTo(x, y)
    }

    this.context.stroke()
  }

  build() {
    Stack() {
      // Surface background with shadow
      Row()
        .width('100%')
        .height(240)
        .backgroundColor('rgba(255, 255, 255, 0.9)')
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level2Radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: AppTokens.Elevation.level2Dy
        })

      Canvas(this.context)
        .width('100%')
        .height(240)
        .padding(AppTokens.Spacing.lg)
        .onReady(() => {
          this.drawWave()
        })
    }
    .width('100%')
  }
}

// ---- Root Screen ----
@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3

  build() {
    Column() {
      // Top bar
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      // Content area
      Column({ space: AppTokens.Spacing.lg }) {
        SurfaceWithCanvas({ paymentProgress: $paymentProgress })

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        CustomLinearProgressIndicator({
          progress: this.paymentProgress,
          color: AppTokens.Colors.primary,
          trackColor: AppTokens.Colors.surfaceVariant,
          indicatorHeight: 8
        })
        .width('100%')

        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .blockColor(AppTokens.Colors.secondary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .onChange((value: number) => {
            this.paymentProgress = value
          })

        Button('Reset Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onTertiary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.paymentProgress = 0.0
          })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        colors: [
          [AppTokens.Colors.secondary + '40', 0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary + '40', 1]
        ],
        direction: GradientDirection.Bottom
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
