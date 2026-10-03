// MARK: - AppTokens (Atomic Design System)

interface FontStyle {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#1E293B',
    secondary: '#0EA5E9',
    tertiary: '#FACC15',
    background: '#1E293B',
    surface: '#1E293B',
    surfaceVariant: '#334155',
    outline: '#475569',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#E2E8F0',
    onSurface: '#E2E8F0',
  };

  static readonly Typography: Record<string, FontStyle> = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes: Record<string, number> = {
    small: 4,
    medium: 8,
    large: 12,
  };

  static readonly Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };

  static readonly ShadowSpec: Record<string, ShadowSpec> = {
    level1: { radius: 2, y: 1, opacity: 0.1 },
    level2: { radius: 4, y: 2, opacity: 0.14 },
    level3: { radius: 6, y: 3, opacity: 0.16 },
  };
}

interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

@Component
struct CustomTopAppBar {
  title: string = '';

  build() {
    Row() {
      Blank()
      Text(this.title)
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
      Blank()
    }
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
  }
}

@Component
struct CodeMarkerCard {
  marker: CodeMarker = { id: 0, name: '', desc: '' };

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Stack() {
        Text(this.marker.id.toString())
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.small)

      Column() {
        Text(this.marker.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.marker.desc)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ShadowSpec.level1.radius,
      color: '#1A000000',
      offsetX: 0,
      offsetY: AppTokens.ShadowSpec.level1.y
    })
  }
}

@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ];

  build() {
    Column() {
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Project Files')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            }, (marker: CodeMarker) => marker.id.toString())
          }
          .padding({ bottom: AppTokens.Spacing.xl })

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

          Button() {
            Text('Run Code')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('100%')
          }
          .width('60%')
          .height(48)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ShadowSpec.level1.radius,
            color: '#1A000000',
            offsetX: 0,
            offsetY: AppTokens.ShadowSpec.level1.y
          })
          .alignSelf(ItemAlign.Center)
          .onClick(() => {})
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CC1E293B', 0.0],
          ['#E61E293B', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    // statusBarHidden(true) has no direct ArkUI declarative equivalent.
    RootScreen()
  }
}
