// AppTokens (Atomic Design System)
interface ColorToken {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShadowSpecItem {
  radius: number;
  y: number;
  opacity: number;
}

interface ShadowSpec {
  level1: ShadowSpecItem;
  level2: ShadowSpecItem;
  level3: ShadowSpecItem;
}

const AppTokens = {
  Colors: {
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
  } as ColorToken,
  TypographyTokens: {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  } as TypographyTokens,
  Shapes: {
    small: 4,
    medium: 8,
    large: 12
  } as ShapeToken,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  } as SpacingToken,
  ShadowSpec: {
    level1: { radius: 2, y: 1, opacity: 0.1 },
    level2: { radius: 4, y: 2, opacity: 0.14 },
    level3: { radius: 6, y: 3, opacity: 0.16 }
  } as ShadowSpec
};

// Data Model
interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    { id: 1, name: "Main.kt", desc: "Entry point for Compose app" },
    { id: 2, name: "Utils.kt", desc: "Helper functions" },
    { id: 3, name: "Theme.kt", desc: "Color & Typography setup" },
    { id: 4, name: "Data.kt", desc: "Repository and model classes" }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("CodeIDE Terminal")
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.background)

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Project Files Section
          Text("Project Files")
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .alignSelf(ItemAlign.Start)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              this.CodeMarkerCard(marker)
            })
          }

          // Live Terminal Section
          Text("Live Terminal")
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .alignSelf(ItemAlign.Start)

          Stack({ alignContent: Alignment.TopStart }) {
            // Terminal Background
            Rect()
              .fill(AppTokens.Colors.surfaceVariant)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .borderRadius(AppTokens.Shapes.medium)
              .height(240)
              .width('100%')

            // Terminal Text
            Text("> println(\"Hello, Kotlin!\")")
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }

          // Run Button
          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text("Run Code")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .width('60%')
          .height(48)
          .shadow({ radius: AppTokens.ShadowSpec.level1.radius, color: new Color('#000000').withOpacity(AppTokens.ShadowSpec.level1.opacity), offsetY: AppTokens.ShadowSpec.level1.y })
          .margin({ top: AppTokens.Spacing.xl })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  CodeMarkerCard(marker: CodeMarker) {
    Row({ space: AppTokens.Spacing.md }) {
      // Icon Box
      Stack() {
        Rect()
          .fill(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .width(32)
          .height(32)
        
        Text(`${marker.id}`)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
      }

      // Text Content
      Column({ space: 2 }) {
        Text(marker.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(marker.desc)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({ radius: AppTokens.ShadowSpec.level1.radius, color: new Color('#000000').withOpacity(AppTokens.ShadowSpec.level1.opacity), offsetY: AppTokens.ShadowSpec.level1.y })
  }
}