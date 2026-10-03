class AppColors {
  static readonly primary: string = '#38BDF8'
  static readonly secondary: string = '#A78BFA'
  static readonly tertiary: string = '#7DD3FC'
  static readonly background: string = '#F1F5F9'
  static readonly surface: string = '#FFFFFF'
  static readonly surface70: string = '#B3FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly surfaceVariant80: string = '#CCE2E8F0'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#1E1E1E'
  static readonly onBackground: string = '#1E1E1E'
  static readonly onSurface: string = '#1E1E1E'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class AppSpacing {
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
}

@Entry
@Component
struct RootScreen {
  @State private scrollOffsetY: number = 0
  private readonly lines: number[] = [1, 2, 3, 4, 5, 6, 7, 8]

  build() {
    Column({ space: 0 }) {
      Text('Glass Doc Reader')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({
          top: 36,
          bottom: AppSpacing.lg
        })
        .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Column({ space: AppSpacing.md }) {
          Text('Document Reader')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          ForEach(this.lines, (index: number) => {
            Text(`This is a sample line of text content number ${index}.`)
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)
          }, (index: number) => index.toString())

          Blank()
            .layoutWeight(1)
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        .width('90%')
        .height(400)
        .backgroundColor(AppColors.surface70)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevation.level2.radius,
          color: '#2E000000',
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })
        .offset({
          x: 0,
          y: this.scrollOffsetY / 5
        })
        .gesture(
          PanGesture({ fingers: 1, direction: PanDirection.Vertical })
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY += event.offsetY
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.surfaceVariant80, 0.0],
          [AppColors.background, 0.5],
          [AppColors.surfaceVariant80, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}