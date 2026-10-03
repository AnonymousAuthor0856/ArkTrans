// AppTokens
class AppTokens {
  static Colors = class {
    static readonly primary: string = '#FF7A00'
    static readonly secondary: string = '#FFC300'
    static readonly tertiary: string = '#FFF3C0'
    static readonly background: string = '#FFF8E7'
    static readonly surface: string = '#FFFFFF'
    static readonly surfaceVariant: string = '#FFEBC8'
    static readonly outline: string = '#BCA789'
    static readonly success: string = '#28A745'
    static readonly warning: string = '#FFC107'
    static readonly error: string = '#DC3545'
    static readonly onPrimary: string = '#FFFFFF'
    static readonly onSecondary: string = '#1E1E1E'
    static readonly onTertiary: string = '#1E1E1E'
    static readonly onBackground: string = '#1E1E1E'
    static readonly onSurface: string = '#1E1E1E'
  }

  static Spacing = class {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 32
  }
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 90
  @State knobPositionY: number = 140
  @State powerOn: boolean = false
  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings)

  aboutToAppear(): void {
    this.drawCanvas()
  }

  drawCanvas(): void {
    const ctx = this.canvasCtx
    const size = 280
    const centerX = size / 2
    const centerY = size / 2

    ctx.clearRect(0, 0, size, size)

    // Background circle
    ctx.beginPath()
    ctx.arc(centerX, centerY, 100, 0, Math.PI * 2)
    ctx.fillStyle = AppTokens.Colors.secondary
    ctx.globalAlpha = 0.2
    ctx.fill()
    ctx.globalAlpha = 1.0

    // Knob circle (diameter 32, radius 16)
    ctx.beginPath()
    ctx.arc(this.knobPositionX, this.knobPositionY, 16, 0, Math.PI * 2)
    ctx.fillStyle = AppTokens.Colors.primary
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
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppTokens.Colors.background)

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
                  .onActionUpdate((event: GestureEvent) => {
                    const newX = event.locationX
                    const newY = event.locationY
                    const boundedX = Math.max(16, Math.min(264, newX))
                    const boundedY = Math.max(16, Math.min(264, newY))
                    this.knobPositionX = boundedX
                    this.knobPositionY = boundedY
                    this.drawCanvas()
                  })
              )
          }
          .width(280)
          .height(280)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(24)
          .shadow({
            radius: 4,
            color: 'rgba(0,0,0,0.12)',
            offsetX: 0,
            offsetY: 2
          })
          .padding(AppTokens.Spacing.lg)

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)
            .margin({ top: AppTokens.Spacing.xl })

          // Buttons Row
          Row() {
            Button({ type: ButtonType.Circle }) {
              Text('On')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.primary)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

            Button({ type: ButtonType.Circle }) {
              Column() {
                Text('Res')
                Text('et')
              }
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.secondary)
            .onClick(() => {
              this.knobPositionX = 90
              this.knobPositionY = 140
              this.drawCanvas()
            })
          }
          .margin({ top: AppTokens.Spacing.xl })
          .justifyContent(FlexAlign.Center)
          .width('100%')

          // Progress Bar
          Column()
            .width('100%')
            .height(6)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(3)
            .margin({
              top: AppTokens.Spacing.xl,
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
