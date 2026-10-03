// Retro Remote Control - ArkTS

class AppColors {
  static readonly primary: ResourceColor = '#FF7A00'
  static readonly secondary: ResourceColor = '#FFC300'
  static readonly tertiary: ResourceColor = '#FFF3C0'
  static readonly background: ResourceColor = '#FFF8E7'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#FFEBC8'
  static readonly outline: ResourceColor = '#BCA789'
  static readonly success: ResourceColor = '#28A745'
  static readonly warning: ResourceColor = '#FFC107'
  static readonly error: ResourceColor = '#DC3545'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#1E1E1E'
  static readonly onTertiary: ResourceColor = '#1E1E1E'
  static readonly onBackground: ResourceColor = '#1E1E1E'
  static readonly onSurface: ResourceColor = '#1E1E1E'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

interface KnobEvent {
  offsetX: number
  offsetY: number
}

@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 90
  @State knobPositionY: number = 140
  @State powerOn: boolean = false
  @State isDragging: boolean = false

  private handleDragUpdate(x: number, y: number): void {
    const boundedX: number = Math.max(16, Math.min(264, x))
    const boundedY: number = Math.max(16, Math.min(264, y))
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

            Canvas(this.knobDraw.bind(this))
              .width(280)
              .height(280)
              .onTouch((event: TouchEvent) => {
                if (event.type === TouchType.Down || event.type === TouchType.Move) {
                  const touchList: TouchObject[] = event.touches
                  if (touchList.length > 0) {
                    const touch: TouchObject = touchList[0]
                    const x: number = touch.x
                    const y: number = touch.y
                    this.handleDragUpdate(x, y)
                  }
                }
              })
          }
          .width(280)
          .height(280)
          .margin({ top: AppSpacing.lg, left: AppSpacing.lg, right: AppSpacing.lg })

          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? AppColors.success : AppColors.error)
            .margin({ top: AppSpacing.xl })

          Row({ space: 60 }) {
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
    const centerX: number = 140
    const centerY: number = 140

    canvas.beginPath()
    canvas.arc(centerX, centerY, 100, 0, Math.PI * 2)
    canvas.fillStyle = 'rgba(255, 195, 0, 0.2)'
    canvas.fill()

    canvas.beginPath()
    canvas.arc(this.knobPositionX, this.knobPositionY, 16, 0, Math.PI * 2)
    canvas.fillStyle = '#ff7a00'
    canvas.fill()
  }
}
