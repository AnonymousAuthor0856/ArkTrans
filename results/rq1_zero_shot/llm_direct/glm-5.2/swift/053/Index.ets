// index.ets
import { Length, ResourceStr } from '@ohos.arkui.UIContext';

// MARK: - AppTokens (Atomic Design System)
class AppTokens {
  static readonly Colors = {
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

  static readonly Typography = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static readonly ShadowSpec = {
    level1: { radius: 2, y: 1, opacity: 0.1 },
    level2: { radius: 4, y: 2, opacity: 0.14 },
    level3: { radius: 6, y: 3, opacity: 0.16 }
  };
}

// MARK: - Data Model
class CodeMarker {
  id: number;
  name: string;
  desc: string;

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

// MARK: - Custom Views
// ArkUI Custom Component equivalent to SwiftUI's View struct
@Component
struct CustomTopAppBar {
  private title: string;

  constructor(title: string) {
    this.title = title;
  }

  build() {
    Row() {
      Blank()
      Text(this.title)
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
      Blank()
    }
    .width('100%')
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CodeMarkerCard {
  private marker: CodeMarker;

  constructor(marker: CodeMarker) {
    this.marker = marker;
  }

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      // ZStack equivalent for ID Badge
      Stack() {
        Text(this.marker.id.toString())
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(32)
      .height(32)
      .borderRadius(AppTokens.Shapes.small)
      .backgroundColor(AppTokens.Colors.secondary)

      // VStack equivalent for Text Content
      Column({ space: 2 }) {
        Text(this.marker.name)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.marker.desc)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ShadowSpec.level1.radius,
      color: `rgba(0,0,0,${AppTokens.ShadowSpec.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ShadowSpec.level1.y
    })
  }
}

// MARK: - RootScreen
// The main content view, equivalent to Kotlin's RootScreen Composable.
@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    new CodeMarker(1, "Main.kt", "Entry point for Compose app"),
    new CodeMarker(2, "Utils.kt", "Helper functions"),
    new CodeMarker(3, "Theme.kt", "Color & Typography setup"),
    new CodeMarker(4, "Data.kt", "Repository and model classes")
  ];

  build() {
    Column() {
      CustomTopAppBar({ title: "CodeIDE Terminal" })

      // ScrollView equivalent
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text("Project Files")
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          // LazyVStack equivalent
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            })
          }
          .padding({ bottom: AppTokens.Spacing.xl })

          Text("Live Terminal")
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          // Terminal Box
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
          .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })

          // Run Code Button
          Button("Run Code") {
            // Action placeholder
          }
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .width('60%')
          .height(48)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ShadowSpec.level1.radius,
            color: `rgba(0,0,0,${AppTokens.ShadowSpec.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ShadowSpec.level1.y
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      // Background Gradient equivalent
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.primary, 0.8],
          [AppTokens.Colors.surface, 0.9]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}