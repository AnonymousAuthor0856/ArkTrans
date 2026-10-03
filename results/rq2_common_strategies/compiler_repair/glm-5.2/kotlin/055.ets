// Index.ets

interface TextStyleSpec {
  fontSize: number;
  fontWeight: FontWeight;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF38BDF8',
    tertiary: '#FF3B82F6',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF1E293B',
  };

  static readonly TypographyTokens: Record<string, TextStyleSpec> = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 },
  };
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top App Bar
        Row() {
          Text('Workout Plan')
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Content
        Column() {
          Text('Sign In to Continue')
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.lg })

          Column() {
            Text('Workout Preview')
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(16)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .margin({ bottom: AppTokens.Spacing.lg })

          Button('Authenticate')
            .width('80%')
            .height(52)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(16)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.secondary, 0.1], [AppTokens.Colors.primary, 0.15]]
        })
        .alignItems(HorizontalAlign.Center)

        // Bottom App Bar
        Row() {
          Text('Home')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)

          Text('Plan')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(28)
        .shadow({
          radius: AppTokens.ElevationMapping.level3.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level3.dy
        })
        .margin({ right: AppTokens.Spacing.lg, bottom: 72 })
    }
    .width('100%')
    .height('100%')
  }
}