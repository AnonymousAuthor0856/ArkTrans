import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens (Atomic Design System)
export class AppTokens {
  static Colors = {
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
    onSurface: '#E2E8F0'
  };

  static TypographyTokens = {
    display: { size: 26, weight: 700 }, // bold
    headline: { size: 20, weight: 600 }, // semibold
    title: { size: 16, weight: 500 }, // medium
    body: { size: 14, weight: 400 }, // regular
    label: { size: 12, weight: 500 } // medium
  };

  static Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static ShadowSpec = {
    level1: { radius: 2, y: 1, opacity: 0.1 },
    level2: { radius: 4, y: 2, opacity: 0.14 },
    level3: { radius: 6, y: 3, opacity: 0.16 }
  };
}

// MARK: - Data Model
interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

@Entry
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
            .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight as FontWeight })
            .fontColor(AppTokens.Colors.onBackground)
            .align(Alignment.Start)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            })
          }
          .padding({ bottom: AppTokens.Spacing.xl })

          Text('Live Terminal')
            .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight as FontWeight })
            .fontColor(AppTokens.Colors.onBackground)
            .align(Alignment.Start)

          Stack({ alignContent: Alignment.TopStart }) {
            Row()
              .width('100%')
              .height(240)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })

            Text('> println("Hello, Kotlin!")')
              .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }

          Button('Run Code')
            .type(ButtonType.Normal)
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
            .fontColor(AppTokens.Colors.onSecondary)
            .width('60%')
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ShadowSpec.level1.radius,
              color: Color.Black.opacity(AppTokens.ShadowSpec.level1.opacity),
              offsetX: 0,
              offsetY: AppTokens.ShadowSpec.level1.y
            })
            .onClick(() => {
              // Action placeholder
            })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.primary, 0.8],
        [AppTokens.Colors.surface, 0.9]
      ]
    })
  }
}

@Component
struct CustomTopAppBar {
  controller?: any;
  @Prop title: string;

  build() {
    Row() {
      Text(this.title)
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight as FontWeight })
        .fontColor(AppTokens.Colors.onBackground)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CodeMarkerCard {
  @Prop marker: CodeMarker;

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Stack() {
        Rect()
          .width(32)
          .height(32)
          .fill(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)

        Text(String(this.marker.id))
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSecondary)
      }

      Column({ space: 4 }) {
        Text(this.marker.name)
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSurface)
          .align(Alignment.Start)

        Text(this.marker.desc)
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSurface)
          .align(Alignment.Start)
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ShadowSpec.level1.radius,
      color: Color.Black.opacity(AppTokens.ShadowSpec.level1.opacity),
      offsetX: 0,
      offsetY: AppTokens.ShadowSpec.level1.y
    })
  }
}