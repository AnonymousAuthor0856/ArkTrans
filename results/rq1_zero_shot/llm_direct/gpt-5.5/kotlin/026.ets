const NAME: string = '027*DocReader*en'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Glassmorphic'
const LANG: string = 'en'
const BASELINE_SIZE: string = '750x1334'

class AppColors {
  static readonly primary: ResourceColor = '#FF38BDF8'
  static readonly secondary: ResourceColor = '#FFA78BFA'
  static readonly tertiary: ResourceColor = '#FF7DD3FC'
  static readonly background: ResourceColor = '#FFF1F5F9'
  static readonly surface: ResourceColor = '#FFFFFFFF'
  static readonly surfaceVariant: ResourceColor = '#FFE2E8F0'
  static readonly outline: ResourceColor = '#FFCBD5E1'
  static readonly success: ResourceColor = '#FF22C55E'
  static readonly warning: ResourceColor = '#FFF59E0B'
  static readonly error: ResourceColor = '#FFEF4444'
  static readonly onPrimary: ResourceColor = '#FFFFFFFF'
  static readonly onSecondary: ResourceColor = '#FF1E1E1E'
  static readonly onTertiary: ResourceColor = '#FF1E1E1E'
  static readonly onBackground: ResourceColor = '#FF1E1E1E'
  static readonly onSurface: ResourceColor = '#FF1E1E1E'

  static readonly surfaceVariant80: ResourceColor = 'rgba(226, 232, 240, 0.8)'
  static readonly surface70: ResourceColor = 'rgba(255, 255, 255, 0.7)'
}

class AppTypographyTokens {
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

interface ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = {
    elevation: 2,
    radius: 4,
    dy: 2,
    opacity: 0.12
  }

  static readonly level2: ShadowSpec = {
    elevation: 6,
    radius: 8,
    dy: 4,
    opacity: 0.18
  }
}

@Component
struct RootScreen {
  @State private scrollOffsetY: number = 0
  private dragStartY: number = 0

  private readonly lines: string[] = [
    'This is a sample line of text content number 1.',
    'This is a sample line of text content number 2.',
    'This is a sample line of text content number 3.',
    'This is a sample line of text content number 4.',
    'This is a sample line of text content number 5.',
    'This is a sample line of text content number 6.',
    'This is a sample line of text content number 7.',
    'This is a sample line of text content number 8.'
  ]

  build() {
    Column() {
      Row() {
        Text('Glass Doc Reader')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Column({ space: AppSpacing.md }) {
          Text('Document Reader')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          ForEach(this.lines, (line: string) => {
            Text(line)
              .fontSize(AppTypographyTokens.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)
              .width('100%')
          }, (line: string) => line)
        }
        .width('90%')
        .height(400)
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Start)
        .backgroundColor(AppColors.surface70)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevationMapping.level2.radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })
        .backdropBlur(20)
        .offset({ y: this.scrollOffsetY / 5 })
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
      .gesture(
        PanGesture({ direction: PanDirection.All })
          .onActionStart(() => {
            this.dragStartY = this.scrollOffsetY
          })
          .onActionUpdate((event: GestureEvent) => {
            this.scrollOffsetY = this.dragStartY + event.offsetY
          })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}

@Preview
@Component
struct PreviewScreen {
  build() {
    RootScreen()
      .backgroundColor(AppColors.background)
  }
}