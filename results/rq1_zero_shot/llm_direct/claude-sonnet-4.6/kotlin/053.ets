import { LengthMetrics } from '@kit.ArkUI'

// Token definitions
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#1E293B'
    export const secondary: ResourceColor = '#0EA5E9'
    export const tertiary: ResourceColor = '#FACC15'
    export const background: ResourceColor = '#111827'
    export const surface: ResourceColor = '#1E293B'
    export const surfaceVariant: ResourceColor = '#334155'
    export const outline: ResourceColor = '#475569'
    export const success: ResourceColor = '#22C55E'
    export const warning: ResourceColor = '#F59E0B'
    export const error: ResourceColor = '#EF4444'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#FFFFFF'
    export const onTertiary: ResourceColor = '#0B1220'
    export const onBackground: ResourceColor = '#E2E8F0'
    export const onSurface: ResourceColor = '#E2E8F0'
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 36
  }
}

interface CodeMarker {
  id: number
  name: string
  desc: string
}

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' },
  ]

  @Builder
  MarkerCard(m: CodeMarker) {
    Row({ space: AppTokens.Spacing.md }) {
      // ID Badge
      Stack() {
        Text(m.id.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(4)
      .alignContent(Alignment.Center)

      // File info
      Column({ space: 4 }) {
        Text(m.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(m.desc)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(8)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // Main content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Project Files header
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          // File list
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.markers, (m: CodeMarker) => {
              this.MarkerCard(m)
            }, (m: CodeMarker) => m.id.toString())
          }
          .width('100%')

          // Live Terminal header
          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          // Terminal box
          Stack({ alignContent: Alignment.TopStart }) {
            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
              .padding(AppTokens.Spacing.md)
          }
          .width('100%')
          .height(240)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(8)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: 8
          })

          // Run Code button
          Button('Run Code')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('60%')
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(12)
            .alignSelf(ItemAlign.Center)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .constraintSize({ minHeight: '100%' })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
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