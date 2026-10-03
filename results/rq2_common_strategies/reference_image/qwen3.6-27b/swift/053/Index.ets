// AppTokens (Atomic Design System)
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
  },
  TypographyTokens: {
    display: { size: 26, weight: 'bold' },
    headline: { size: 20, weight: 'semibold' },
    title: { size: 16, weight: 'medium' },
    body: { size: 14, weight: 'regular' },
    label: { size: 12, weight: 'medium' }
  },
  Shapes: {
    small: 4,
    medium: 8,
    large: 12
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  },
  ShadowSpec: {
    level1: { radius: 2, y: 1, opacity: 0.1 },
    level2: { radius: 4, y: 2, opacity: 0.14 },
    level3: { radius: 6, y: 3, opacity: 0.16 }
  }
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
          .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight as FontWeight })
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
            .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight as FontWeight })
            .fontColor(AppTokens.Colors.onBackground)
            .alignSelf(ItemAlign.Start)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              this.CodeMarkerCard(marker)
            })
          }

          // Live Terminal Section
          Text("Live Terminal")
            .font({ size: AppTokens.TypographyTokens.headline.size, weight: AppTokens.TypographyTokens.headline.weight as FontWeight })
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
              .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }

          // Run Button
          Button("Run Code") {
            // Action
          }
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .width('60%')
          .height(48)
          .shadow({ radius: AppTokens.ShadowSpec.level1.radius, color: Color.Black.opacity(AppTokens.ShadowSpec.level1.opacity), offsetY: AppTokens.ShadowSpec.level1.y })
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
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSecondary)
      }

      // Text Content
      Column({ space: 2 }) {
        Text(marker.name)
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(marker.desc)
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight as FontWeight })
          .fontColor(AppTokens.Colors.onSurface)
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({ radius: AppTokens.ShadowSpec.level1.radius, color: Color.Black.opacity(AppTokens.ShadowSpec.level1.opacity), offsetY: AppTokens.ShadowSpec.level1.y })
  }
}