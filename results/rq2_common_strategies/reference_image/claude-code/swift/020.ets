// Retro Remote Control - ArkTS

class AppColors {
  static readonly primary: Color = Color.rgb(255, 122, 0)
  static readonly secondary: Color = Color.rgb(255, 195, 0)
  static readonly tertiary: Color = Color.rgb(255, 243, 192)
  static readonly background: Color = Color.rgb(255, 248, 231)
  static readonly surface: Color = Color.rgb(255, 255, 255)
  static readonly surfaceVariant: Color = Color.rgb(255, 235, 200)
  static readonly outline: Color = Color.rgb(188, 167, 137)
  static readonly success: Color = Color.rgb(40, 167, 69)
  static readonly warning: Color = Color.rgb(255, 193, 7)
  static readonly error: Color = Color.rgb(220, 53, 69)
  static readonly onPrimary: Color = Color.rgb(255, 255, 255)
  static readonly onSecondary: Color = Color.rgb(30, 30, 30)
  static readonly onTertiary: Color = Color.rgb(30, 30, 30)
  static readonly onBackground: Color = Color.rgb(30, 30, 30)
  static readonly onSurface: Color = Color.rgb(30, 30, 30)
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 90
  @State knobPositionY: number = 140
  @State powerOn: boolean = false

  private handleDragUpdate(x: number, y: number): void {
    const boundedX = Math.max(16, Math.min(264, x))
    const boundedY = Math.max(16, Math.min(264, y))
    this.knobPositionX = boundedX
    this.knobPositionY = boundedY
  }

  build() {
    Column() {
      Column()
        .height(40)

      Stack() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column() {
          Stack() {
            // Knob surface background
            Stack()
              .width(280)
              .height(280)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(24)
              .shadow({
                radius: 4,
                color: 'rgba(0, 0, 0, 0.12)',
                offsetY: 2
              })

            // Canvas for knob circles
            Canvas(this.knobDraw.bind(this))
              .width(280)
              .height(280)
              .gesture(
                PanGesture({ distance: 0 })
                  .onActionUpdate((event: GestureEvent) => {
                    const x = event.locationX
                    const y = event.locationY
                    this.handleDragUpdate(x, y)
                  })
              )
          }
          .width(280)
          .height(280)
          .margin({ top: AppSpacing.lg, left: AppSpacing.lg, right: AppSpacing.lg })

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? AppColors.success : AppColors.error)
            .margin({ top: AppSpacing.xl })

          // Buttons Row
          Row() {
            // On button
            Button('On')
              .width(80)
              .height(80)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
              .backgroundColor(AppColors.primary)
              .borderRadius(40)
              .onClick(() => {
                this.powerOn = !this.powerOn
              })

            // Reset button
            Button() {
              Column({ space: 0 }) {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)
                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)
              }
            }
            .width(80)
            .height(80)
            .backgroundColor(AppColors.secondary)
            .borderRadius(40)
            .onClick(() => {
              this.knobPositionX = 90
              this.knobPositionY = 140
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: AppSpacing.xl })
          .gap(60)

          // Progress Bar
          Stack()
            .width('100%')
            .height(6)
            .backgroundColor(AppColors.primary)
            .borderRadius(3)
            .margin({ top: AppSpacing.xl, left: AppSpacing.lg, right: AppSpacing.lg })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  private knobDraw(canvas: CanvasRenderingContext2D): void {
    const centerX = 140
    const centerY = 140

    // Background circle
    canvas.beginPath()
    canvas.arc(centerX, centerY, 100, 0, Math.PI * 2)
    canvas.fillStyle = 'rgba(255, 195, 0, 0.2)'
    canvas.fill()

    // Knob circle
    canvas.beginPath()
    canvas.arc(this.knobPositionX, this.knobPositionY, 16, 0, Math.PI * 2)
    canvas.fillStyle = '#ff7a00'
    canvas.fill()
  }
}
