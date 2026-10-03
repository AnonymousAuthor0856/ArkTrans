// AppTokens - Colors
namespace Colors {
  export const primary: string = '#FF7A00'
  export const secondary: string = '#FFC300'
  export const tertiary: string = '#FFF3C0'
  export const background: string = '#FFF8E7'
  export const surface: string = '#FFFFFF'
  export const surfaceVariant: string = '#FFEBC8'
  export const outline: string = '#BCA789'
  export const success: string = '#28A745'
  export const warning: string = '#FFC107'
  export const error: string = '#DC3545'
  export const onPrimary: string = '#FFFFFF'
  export const onSecondary: string = '#1E1E1E'
  export const onTertiary: string = '#1E1E1E'
  export const onBackground: string = '#1E1E1E'
  export const onSurface: string = '#1E1E1E'
}

// AppTokens - Spacing
namespace Spacing {
  export const xs: number = 4
  export const sm: number = 8
  export const md: number = 12
  export const lg: number = 16
  export const xl: number = 24
  export const xxl: number = 32
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 90
  @State knobPositionY: number = 140
  @State powerOn: boolean = false
  private dragStartX: number = 0
  private dragStartY: number = 0
  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings)

  aboutToAppear(): void {
    this.drawCanvas()
  }

  drawCanvas(): void {
    const ctx: CanvasRenderingContext2D = this.canvasCtx
    const size: number = 280
    const centerX: number = size / 2
    const centerY: number = size / 2

    ctx.clearRect(0, 0, size, size)

    // Background circle
    ctx.beginPath()
    ctx.arc(centerX, centerY, 100, 0, Math.PI * 2)
    ctx.fillStyle = Colors.secondary
    ctx.globalAlpha = 0.2
    ctx.fill()
    ctx.globalAlpha = 1.0

    // Knob circle (diameter 32, radius 16)
    ctx.beginPath()
    ctx.arc(this.knobPositionX, this.knobPositionY, 16, 0, Math.PI * 2)
    ctx.fillStyle = Colors.primary
    ctx.fill()
  }

  build() {
    Column() {
      // Top spacer
      Column()
        .height(40)

      // Top Bar
      Stack() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(Colors.background)

      Scroll() {
        Column() {
          // Knob Surface
          Stack() {
            Canvas(this.canvasCtx)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawCanvas()
              })
              .gesture(
                PanGesture({ distance: 0 })
                  .onActionStart(() => {
                    this.dragStartX = this.knobPositionX
                    this.dragStartY = this.knobPositionY
                  })
                  .onActionUpdate((event: PanGestureEvent) => {
                    const newX: number = this.dragStartX + event.offsetX
                    const newY: number = this.dragStartY + event.offsetY
                    const boundedX: number = Math.max(16, Math.min(264, newX))
                    const boundedY: number = Math.max(16, Math.min(264, newY))
                    this.knobPositionX = boundedX
                    this.knobPositionY = boundedY
                    this.drawCanvas()
                  })
              )
          }
          .width(280)
          .height(280)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(24)
          .shadow({
            radius: 4,
            color: 'rgba(0,0,0,0.12)',
            offsetX: 0,
            offsetY: 2
          })
          .padding(Spacing.lg)

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? Colors.success : Colors.error)
            .margin({ top: Spacing.xl })

          // Buttons Row
          Row() {
            Button({ type: ButtonType.Circle }) {
              Text('On')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
            }
            .width(80)
            .height(80)
            .backgroundColor(Colors.primary)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

            Button({ type: ButtonType.Circle }) {
              Column() {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSecondary)
                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSecondary)
              }
            }
            .width(80)
            .height(80)
            .backgroundColor(Colors.secondary)
            .onClick(() => {
              this.knobPositionX = 90
              this.knobPositionY = 140
              this.drawCanvas()
            })
          }
          .margin({ top: Spacing.xl })
          .justifyContent(FlexAlign.Center)
          .width('100%')

          // Progress Bar
          Column()
            .width('100%')
            .height(6)
            .backgroundColor(Colors.primary)
            .borderRadius(3)
            .margin({
              top: Spacing.xl,
              left: Spacing.lg,
              right: Spacing.lg
            })
        }
        .width('100%')
        .padding(Spacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
