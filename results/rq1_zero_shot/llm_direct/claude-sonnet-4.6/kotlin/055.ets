import { LengthMetrics } from '@kit.ArkUI'

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#2563EB'
    export const secondary: ResourceColor = '#38BDF8'
    export const tertiary: ResourceColor = '#3B82F6'
    export const background: ResourceColor = '#F8FAFC'
    export const surface: ResourceColor = '#FFFFFF'
    export const surfaceVariant: ResourceColor = '#E2E8F0'
    export const outline: ResourceColor = '#CBD5E1'
    export const success: ResourceColor = '#22C55E'
    export const warning: ResourceColor = '#F59E0B'
    export const error: ResourceColor = '#EF4444'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#0F172A'
    export const onTertiary: ResourceColor = '#FFFFFF'
    export const onBackground: ResourceColor = '#0F172A'
    export const onSurface: ResourceColor = '#1E293B'
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28
    export const headlineSize: number = 20
    export const titleSize: number = 16
    export const bodySize: number = 14
    export const labelSize: number = 12
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 36
  }

  export namespace ShapeRadius {
    export const small: number = 8
    export const medium: number = 12
    export const large: number = 16
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content with top bar and scrollable body
      Column() {
        // Top App Bar
        Row() {
          Text('Workout Plan')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)

        // Body content
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Sign In to Continue')
            .fontSize(AppTokens.TypographyTokens.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          // Workout Preview Box
          Stack() {
            Text('Workout Preview')
              .fontSize(AppTokens.TypographyTokens.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.ShapeRadius.large)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: AppTokens.ShapeRadius.large
          })
          .alignContent(Alignment.Center)

          // Authenticate Button
          Button('Authenticate')
            .width('80%')
            .height(52)
            .borderRadius(AppTokens.ShapeRadius.large)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['#1A38BDF8', 0.0],
            ['#262563EB', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Bottom App Bar
      Column() {
        // Bottom Navigation
        Row() {
          Text('Home')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)

          Text('Plan')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Text('Profile')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: 8,
          color: '#24000000',
          offsetY: -2
        })
      }
      .width('100%')

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .shadow({
          radius: 8,
          color: '#242563EB',
          offsetY: 4
        })
        .margin({ bottom: 72, right: AppTokens.Spacing.lg })
        .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}