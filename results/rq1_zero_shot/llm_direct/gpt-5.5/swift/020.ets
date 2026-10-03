class AppColors {
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

class AppTypographyTokens {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 14
  static readonly large: number = 24
}

class AppSpacing {
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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16)
}

@Entry
@Component
struct RootScreen {
  @State private knobX: number = 90
  @State private knobY: number = 140
  @State private powerOn: boolean = false

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  private readonly knobSurfaceSize: number = 280
  private readonly knobRadius: number = 16

  private bound(value: number, minValue: number, maxValue: number): number {
    return Math.max(minValue, Math.min(maxValue, value))
  }

  private drawKnob(): void {
    const center: number = this.knobSurfaceSize / 2

    this.canvasContext.clearRect(0, 0, this.knobSurfaceSize, this.knobSurfaceSize)

    this.canvasContext.beginPath()
    this.canvasContext.arc(center, center, 100, 0, Math.PI * 2)
    this.canvasContext.fillStyle = 'rgba(255, 195, 0, 0.2)'
    this.canvasContext.fill()

    this.canvasContext.beginPath()
    this.canvasContext.arc(this.knobX, this.knobY, this.knobRadius, 0, Math.PI * 2)
    this.canvasContext.fillStyle = AppColors.primary
    this.canvasContext.fill()
  }

  build() {
    Column({ space: 0 }) {
      Blank()
        .height(40)

      Stack({ alignContent: Alignment.Center }) {
        Text('Retro Remote Control')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.xl }) {
          Stack() {
            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawKnob()
              })
          }
          .width(280)
          .height(280)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)
          .clip(true)
          .shadow({
            radius: AppElevationMapping.level1.radius,
            color: 'rgba(0, 0, 0, 0.12)',
            offsetX: 0,
            offsetY: AppElevationMapping.level1.dy
          })
          .margin(AppSpacing.lg)
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              const touch = event.touches[0]
              this.knobX = this.bound(touch.x, this.knobRadius, this.knobSurfaceSize - this.knobRadius)
              this.knobY = this.bound(touch.y, this.knobRadius, this.knobSurfaceSize - this.knobRadius)
              this.drawKnob()
            }
          })

          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? AppColors.success : AppColors.error)

          Row({ space: 60 }) {
            Stack({ alignContent: Alignment.Center }) {
              Text('On')
                .fontSize(AppTypographyTokens.titleSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppColors.primary)
            .borderRadius(40)
            .onClick(() => {
              this.powerOn = !this.powerOn
            })

            Stack({ alignContent: Alignment.Center }) {
              Column({ space: 0 }) {
                Text('Res')
                  .fontSize(AppTypographyTokens.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)

                Text('et')
                  .fontSize(AppTypographyTokens.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)
              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppColors.secondary)
            .borderRadius(40)
            .onClick(() => {
              this.knobX = 90
              this.knobY = 140
              this.drawKnob()
            })
          }
          .justifyContent(FlexAlign.Center)

          Row() {
            Row()
              .width('100%')
              .height(6)
              .backgroundColor(AppColors.primary)
              .borderRadius(3)
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}