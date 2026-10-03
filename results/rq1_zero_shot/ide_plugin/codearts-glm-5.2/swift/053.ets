class AppTokens {
  static readonly Colors = {
    primary: '#FF1E293B',
    secondary: '#FF0EA5E9',
    tertiary: '#FFFACC15',
    background: '#FF1E293B',
    surface: '#FF1E293B',
    surfaceVariant: '#FF334155',
    outline: '#FF475569',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0B1220',
    onBackground: '#FFE2E8F0',
    onSurface: '#FFE2E8F0',
  }
  static readonly Typography = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  }
}

class CodeMarker {
  id: number
  name: string
  desc: string

  constructor(id: number, name: string, desc: string) {
    this.id = id
    this.name = name
    this.desc = desc
  }
}

@Component
struct CodeMarkerCard {
  @Prop id: number
  @Prop name: string
  @Prop desc: string

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Stack() {
        Text(`${this.id}`)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.small)

      Column() {
        Text(this.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.desc)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })
  }
}

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes'),
  ]

  build() {
    Column() {
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Project Files')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (m: CodeMarker) => {
              CodeMarkerCard({ id: m.id, name: m.name, desc: m.desc })
            })
          }
          .margin({ bottom: AppTokens.Spacing.xl })

          Text('Live Terminal')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          Stack({ alignContent: Alignment.TopStart }) {
            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }
          .width('100%')
          .height(240)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })

          Row() {
            Button('Run Code')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('100%')
              .height(48)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        angle: 180,
        colors: [['#CC1E293B', 0.0], ['#E61E293B', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}