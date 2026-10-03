import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens (Atomic Design System)
namespace AppTokens {
  export namespace Colors {
    export const primary = '#1E293B';
    export const secondary = '#0EA5E9';
    export const tertiary = '#FACC15';
    export const background = '#1E293B';
    export const surface = '#1E293B';
    export const surfaceVariant = '#334155';
    export const outline = '#475569';
    export const success = '#22C55E';
    export const warning = '#F59E0B';
    export const error = '#EF4444';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#FFFFFF';
    export const onTertiary = '#0B1220';
    export const onBackground = '#E2E8F0';
    export const onSurface = '#E2E8F0';
  }

  export namespace Typography {
    export const displaySize = 26;
    export const headlineSize = 20;
    export const titleSize = 16;
    export const bodySize = 14;
    export const labelSize = 12;
  }

  export namespace Shapes {
    export const small = 4;
    export const medium = 8;
    export const large = 12;
  }

  export namespace Spacing {
    export const xs = 4;
    export const sm = 8;
    export const md = 12;
    export const lg = 16;
    export const xl = 24;
    export const xxl = 36;
  }

  export namespace Shadow {
    export const level1Radius = 2;
    export const level1Y = 1;
    export const level1Opacity = 0.1;
    export const level2Radius = 4;
    export const level2Y = 2;
    export const level2Opacity = 0.14;
    export const level3Radius = 6;
    export const level3Y = 3;
    export const level3Opacity = 0.16;
  }
}

// MARK: - Data Model
interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

// MARK: - CodeMarkerCard Component
@Component
struct CodeMarkerCard {
  marker: CodeMarker = { id: 0, name: '', desc: '' };

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Stack() {
        Text(String(this.marker.id))
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Medium)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(AppTokens.Shapes.small)

      Column({ space: 4 }) {
        Text(this.marker.name)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        Text(this.marker.desc)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.Shadow.level1Radius,
      color: `rgba(0,0,0,${AppTokens.Shadow.level1Opacity})`,
      offsetX: 0,
      offsetY: AppTokens.Shadow.level1Y
    })
  }
}

// MARK: - CustomTopAppBar Component
@Component
struct CustomTopAppBar {
  title: string = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - RootScreen
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
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (marker: CodeMarker) => {
              CodeMarkerCard({ marker: marker })
            }, (marker: CodeMarker) => String(marker.id))
          }
          .width('100%')
          .padding({ bottom: AppTokens.Spacing.xl })

          Text('Live Terminal')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          Stack({ alignContent: Alignment.TopStart }) {
            Column()
              .width('100%')
              .height(240)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: AppTokens.Colors.outline,
                radius: AppTokens.Shapes.medium
              })

            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTokens.Typography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }
          .width('100%')
          .height(240)

          Row() {
            Button('Run Code')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('60%')
              .height(48)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: AppTokens.Shadow.level1Radius,
                color: `rgba(0,0,0,${AppTokens.Shadow.level1Opacity})`,
                offsetX: 0,
                offsetY: AppTokens.Shadow.level1Y
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['rgba(30,41,59,0.8)', 0.0],
          ['rgba(30,41,59,0.9)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}