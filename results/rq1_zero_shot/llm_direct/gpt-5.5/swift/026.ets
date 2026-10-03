import { window } from '@kit.ArkUI'

class AppTokens {
  static readonly Colors = class {
    static readonly primary: ResourceColor = 0xFF38BDF8
    static readonly secondary: ResourceColor = 0xFFA78BFA
    static readonly tertiary: ResourceColor = 0xFF7DD3FC
    static readonly background: ResourceColor = 0xFFF1F5F9
    static readonly surface: ResourceColor = 0xFFFFFFFF
    static readonly surfaceVariant: ResourceColor = 0xFFE2E8F0
    static readonly outline: ResourceColor = 0xFFCBD5E1
    static readonly success: ResourceColor = 0xFF22C55E
    static readonly warning: ResourceColor = 0xFFF59E0B
    static readonly error: ResourceColor = 0xFFEF4444
    static readonly onPrimary: ResourceColor = 0xFFFFFFFF
    static readonly onSecondary: ResourceColor = 0xFF1E1E1E
    static readonly onTertiary: ResourceColor = 0xFF1E1E1E
    static readonly onBackground: ResourceColor = 0xFF1E1E1E
    static readonly onSurface: ResourceColor = 0xFF1E1E1E
  }

  static readonly TypographyTokens = class {
    static readonly displaySize: number = 28
    static readonly displayWeight: FontWeight = FontWeight.Bold
    static readonly titleSize: number = 18
    static readonly titleWeight: FontWeight = FontWeight.Medium
    static readonly bodySize: number = 14
    static readonly bodyWeight: FontWeight = FontWeight.Regular
    static readonly labelSize: number = 12
    static readonly labelWeight: FontWeight = FontWeight.Medium
  }

  static readonly Shapes = class {
    static readonly small: number = 6
    static readonly medium: number = 12
    static readonly large: number = 20
  }

  static readonly Spacing = class {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 32
  }

  static readonly ElevationMapping = class {
    static readonly level1: ShadowOptions = {
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 2
    }

    static readonly level2: ShadowOptions = {
      radius: 8,
      color: 'rgba(0, 0, 0, 0.18)',
      offsetX: 0,
      offsetY: 4
    }
  }
}

@Entry
@Component
struct RootScreen {
  @State private scrollOffsetY: number = 0

  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err, data) => {
      if (!err) {
        data.setWindowLayoutFullScreen(true)
        data.setWindowSystemBarEnable([])
      }
    })
  }

  build() {
    Column({ space: 0 }) {
      Text('Glass Doc Reader')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({
          top: 36,
          bottom: AppTokens.Spacing.lg,
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg
        })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [0xCCE2E8F0, 0.0],
              [AppTokens.Colors.background, 0.5],
              [0xCCE2E8F0, 1.0]
            ]
          })

        Column({ space: AppTokens.Spacing.md }) {
          Text('Document Reader')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.primary)

          ForEach([0, 1, 2, 3, 4, 5, 6, 7], (index: number) => {
            Text(`This is a sample line of text content number ${index + 1}.`)
              .fontSize(AppTokens.TypographyTokens.bodySize)
              .fontWeight(AppTokens.TypographyTokens.bodyWeight)
              .fontColor(AppTokens.Colors.onSurface)
          })

          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .width('90%')
        .height(400)
        .backgroundColor(0xB3FFFFFF)
        .borderRadius(AppTokens.Shapes.large)
        .shadow(AppTokens.ElevationMapping.level2)
        .translate({ y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY += event.offsetY
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}