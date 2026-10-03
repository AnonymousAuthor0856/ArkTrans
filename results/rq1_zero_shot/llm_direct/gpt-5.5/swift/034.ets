import { window } from '@kit.ArkUI'

class AppColors {
  static readonly primary: string = '#00FF66'
  static readonly secondary: string = '#CCCCCC'
  static readonly tertiary: string = '#999999'
  static readonly background: string = '#000000'
  static readonly surface: string = '#0A0A0A'
  static readonly surfaceVariant: string = '#111111'
  static readonly outline: string = '#1F1F1F'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#FF4444'
  static readonly onPrimary: string = '#000000'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#E0E0E0'
  static readonly onSurface: string = '#E0E0E0'
}

class TypographyToken {
  size: number
  weight: FontWeight

  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class AppTypographyTokens {
  static readonly display: TypographyToken = new TypographyToken(28, FontWeight.Bold)
  static readonly headline: TypographyToken = new TypographyToken(20, FontWeight.Medium)
  static readonly title: TypographyToken = new TypographyToken(16, FontWeight.Medium)
  static readonly body: TypographyToken = new TypographyToken(13, FontWeight.Regular)
  static readonly label: TypographyToken = new TypographyToken(11, FontWeight.Medium)
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
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
  radius: number
  y: number
  opacity: number

  constructor(radius: number, y: number, opacity: number) {
    this.radius = radius
    this.y = y
    this.opacity = opacity
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(0, 0, 0)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 2, 0.12)
}

class AppTokens {
  static readonly Colors: typeof AppColors = AppColors
  static readonly TypographyTokens: typeof AppTypographyTokens = AppTypographyTokens
  static readonly Shapes: typeof AppShapes = AppShapes
  static readonly Spacing: typeof AppSpacing = AppSpacing
  static readonly ElevationMapping: typeof AppElevationMapping = AppElevationMapping
}

class MapMarker {
  readonly id: string
  readonly name: string
  readonly distance: string

  constructor(name: string, distance: string) {
    this.id = name
    this.name = name
    this.distance = distance
  }
}

@Component
struct CardView {
  marker: MapMarker = new MapMarker('', '')

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .font({
            size: AppTokens.TypographyTokens.title.size,
            weight: AppTokens.TypographyTokens.title.weight
          })
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.marker.distance)
          .font({
            size: AppTokens.TypographyTokens.body.size,
            weight: AppTokens.TypographyTokens.body.weight
          })
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button() {
        Text('View')
          .font({
            size: AppTokens.TypographyTokens.label.size,
            weight: AppTokens.TypographyTokens.label.weight
          })
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs
          })
      }
      .type(ButtonType.Normal)
      .padding(0)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        console.info(`View ${this.marker.name} Tapped`)
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: '#1F000000',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.y
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private query: string = ''
  @State private isSearchFieldFocused: boolean = false

  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ]

  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowSystemBarEnable([])
      })
      .catch(() => {
      })
  }

  build() {
    Stack() {
      Column() {
        Text('Explore Map')
          .font({
            size: AppTokens.TypographyTokens.display.size,
            weight: AppTokens.TypographyTokens.display.weight
          })
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg
          })
          .backgroundColor(AppTokens.Colors.background)

        Column({ space: AppTokens.Spacing.lg }) {
          TextInput({
            placeholder: 'Search destination',
            text: this.query
          })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(AppTokens.Colors.tertiary)
            .caretColor(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({
              width: 1,
              color: this.isSearchFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
            })
            .padding(AppTokens.Spacing.md)
            .width('100%')
            .onChange((value: string) => {
              this.query = value
            })
            .onFocus(() => {
              this.isSearchFieldFocused = true
            })
            .onBlur(() => {
              this.isSearchFieldFocused = false
            })

          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
            }, (marker: MapMarker) => marker.id)
          }
          .width('100%')

          Blank()
            .layoutWeight(1)

          Button() {
            Text('Refresh Map')
              .font({
                size: AppTokens.TypographyTokens.title.size,
                weight: AppTokens.TypographyTokens.title.weight
              })
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .padding(0)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            console.info('Refresh Map Tapped')
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}