// MARK: - AppTokens

class Colors {
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

class TypographyTokens {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly titleSize: number = 18
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class Shapes {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 24
}

class Spacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16)
}

class AppTokens {
  static readonly Colors = Colors
  static readonly TypographyTokens = TypographyTokens
  static readonly Shapes = Shapes
  static readonly Spacing = Spacing
  static readonly ElevationMapping = ElevationMapping
}

// MARK: - RootScreen View

@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 90
  @State knobPositionY: number = 140 // 初始位置靠左
  @State powerOn: boolean = false

  private startX: number = 90
  private startY: number = 140

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawKnob(): void {
    const width: number = this.context.width
    const height: number = this.context.height
    const centerX: number = width / 2
    const centerY: number = height / 2

    this.context.clearRect(0, 0, width, height)

    // Background circle
    this.context.beginPath()
    this.context.arc(centerX, centerY, 100, 0, Math.PI * 2)
    this.context.fillStyle = 'rgba(255, 195, 0, 0.2)' // secondary with opacity 0.2
    this.context.fill()

    // Knob circle - 直径缩小
    this.context.beginPath()
    this.context.arc(this.knobPositionX, this.knobPositionY, 16, 0, Math.PI * 2) // 半径16，直径32
    this.context.fillStyle = AppTokens.Colors.primary
    this.context.fill()
  }

  build() {
    Column({ space: 0 }) {
      // 移除顶部状态栏，增加标题上方的空白
      Row()
        .height(40) // 增加标题上方的空白

      // Top Bar
      Stack() {
        Text('Retro Remote Control')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column({ space: AppTokens.Spacing.xl }) {
          // Knob Surface
          Stack() {
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawKnob()
              })
              .gesture(
                PanGesture({ fingers: 1, distance: 0 })
                  .onActionStart((event: GestureEvent) => {
                    this.startX = this.knobPositionX
                    this.startY = this.knobPositionY
                  })
                  .onActionUpdate((event: GestureEvent) => {
                    const newX: number = this.startX + event.offsetX
                    const newY: number = this.startY + event.offsetY
                    this.knobPositionX = Math.max(16, Math.min(264, newX))
                    this.knobPositionY = Math.max(16, Math.min(264, newY))
                    this.drawKnob()
                  })
              )
          }
          .width(280)
          .height(280)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: 'rgba(0, 0, 0, ' + AppTokens.ElevationMapping.level1.opacity + ')',
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .padding(AppTokens.Spacing.lg)

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)

          // Buttons Row - 增加按钮间距
          Row({ space: 60 }) { // 进一步增加按钮间距
            Button() {
              Text('On')
                .fontSize(AppTokens.TypographyTokens.titleSize)
                .fontWeight(AppTokens.TypographyTokens.titleWeight)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(40)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

            Button() {
              Column({ space: 0 }) {
                Text('Res')
                  .fontSize(AppTokens.TypographyTokens.titleSize)
                  .fontWeight(AppTokens.TypographyTokens.titleWeight)
                  .fontColor(AppTokens.Colors.onSecondary)
                Text('et')
                  .fontSize(AppTokens.TypographyTokens.titleSize)
                  .fontWeight(AppTokens.TypographyTokens.titleWeight)
                  .fontColor(AppTokens.Colors.onSecondary)
              }
            }
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(40)
            .onClick(() => {
              this.knobPositionX = 90 // 重置到靠左位置
              this.knobPositionY = 140
              this.drawKnob()
            })
          }

          // Progress Bar - 整个条都是红色
          Row()
            .width('100%')
            .height(6)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(3)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .padding(AppTokens.Spacing.lg)
      }
      .backgroundColor(AppTokens.Colors.background)
    }
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea()
  }
}

// MARK: - App Entry Point
// Swift 的 @main RetroRemoteControlApp: App 入口由 @Entry RootScreen 组件替代；
// WindowGroup { RootScreen().statusBar(hidden: true) } 对应 @Entry RootScreen 页面（隐藏状态栏）。
