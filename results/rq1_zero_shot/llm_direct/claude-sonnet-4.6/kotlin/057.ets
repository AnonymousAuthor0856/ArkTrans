import { LengthMetrics } from '@kit.ArkUI'

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#FF2563EB'
    export const secondary: ResourceColor = '#FF38BDF8'
    export const tertiary: ResourceColor = '#FF60A5FA'
    export const background: ResourceColor = '#FFF8FAFC'
    export const surface: ResourceColor = '#FFFFFFFF'
    export const surfaceVariant: ResourceColor = '#FFE2E8F0'
    export const outline: ResourceColor = '#FFCBD5E1'
    export const success: ResourceColor = '#FF22C55E'
    export const warning: ResourceColor = '#FFF59E0B'
    export const error: ResourceColor = '#FFEF4444'
    export const onPrimary: ResourceColor = '#FFFFFFFF'
    export const onSecondary: ResourceColor = '#FF0F172A'
    export const onTertiary: ResourceColor = '#FFFFFFFF'
    export const onBackground: ResourceColor = '#FF0F172A'
    export const onSurface: ResourceColor = '#FF1E293B'
  }

  export namespace Typography {
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

@Component
struct NavIconBack {
  build() {
    Button({ type: ButtonType.Circle }) {
      Text('<')
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
    }
    .width(24)
    .height(24)
    .backgroundColor(AppTokens.Colors.primary)
  }
}

@Component
struct NavIconHelp {
  build() {
    Button({ type: ButtonType.Circle }) {
      Text('?')
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
    }
    .width(24)
    .height(24)
    .backgroundColor(AppTokens.Colors.secondary)
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      NavIconBack()
        .margin({ left: AppTokens.Spacing.sm })

      Text('Sleep Cycle')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      NavIconHelp()
        .margin({ right: AppTokens.Spacing.sm })
    }
    .width('100%')
    .height(56)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct SleepIconCircle {
  build() {
    Stack() {
      Circle()
        .width(160)
        .height(160)
        .fill(AppTokens.Colors.surface)
        .stroke(AppTokens.Colors.outline)
        .strokeWidth(2)

      Text('😴')
        .fontSize(48)
    }
    .width(160)
    .height(160)
    .alignContent(Alignment.Center)
  }
}

@Component
struct SignInButton {
  build() {
    Button('Sign In')
      .width('80%')
      .height(52)
      .borderRadius(AppTokens.ShapeRadius.large)
      .backgroundColor(AppTokens.Colors.primary)
      .fontColor(AppTokens.Colors.onPrimary)
      .fontSize(AppTokens.Typography.titleSize)
      .fontWeight(FontWeight.Medium)
  }
}

@Component
struct RootScreen {
  build() {
    Column() {
      TopBar()

      Column({ space: AppTokens.Spacing.xl }) {
        SleepIconCircle()

        Text('Welcome Back')
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        SignInButton()
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2638BDF8', 0.0],
          ['#1A2563EB', 1.0]
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
    RootScreen()
  }
}