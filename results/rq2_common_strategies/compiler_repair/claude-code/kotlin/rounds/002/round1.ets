interface SocialItem {
  label: string
  tint: ResourceColor
}

interface TypographySpec {
  fontSize: number
  fontWeight: FontWeight
  lineHeight: number
}

interface ElevationSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
}

@Entry
@Component
struct AuthLogin {
  @State email: string = ''
  @State password: string = ''

  private readonly socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppTokens.Colors.primary },
    { label: 'Continue with Google', tint: AppTokens.Colors.tertiary },
    { label: 'Continue with GitHub', tint: AppTokens.Colors.secondary }
  ]

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.LoginCard()
          this.OrDivider()
          this.SocialButtons()
          this.TermsText()
          this.SupportSection()
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.xl,
          right: AppTokens.Spacing.xl,
          top: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.lg
        })
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Text('Sign in')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(AppTokens.TypographyTokens.display.lineHeight)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  LoginCard() {
    Column() {
      Text('Welcome back')
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(AppTokens.TypographyTokens.headline.lineHeight)

      Column() {
        Text('Email')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(AppTokens.TypographyTokens.label.lineHeight)

        TextInput({ text: this.email, placeholder: '' })
          .width('100%')
          .height(44)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(Color.Transparent)
          .border({
            width: { left: 1, right: 1, top: 1, bottom: 1 },
            color: AppTokens.Colors.outline,
            radius: AppTokens.Shapes.medium
          })
          .padding({ left: 12, right: 12 })
          .onChange((value: string) => {
            this.email = value
          })

        Text('Password')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
          .margin({ top: AppTokens.Spacing.md })

        TextInput({ text: this.password, placeholder: '' })
          .width('100%')
          .height(44)
          .type(InputType.Password)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(Color.Transparent)
          .border({
            width: { left: 1, right: 1, top: 1, bottom: 1 },
            color: AppTokens.Colors.outline,
            radius: AppTokens.Shapes.medium
          })
          .padding({ left: 12, right: 12 })
          .onChange((value: string) => {
            this.password = value
          })

        Row() {
          Text('Forgot password?')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.tertiary)
            .lineHeight(AppTokens.TypographyTokens.label.lineHeight)

          Text('Create account')
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .fontColor(AppTokens.Colors.tertiary)
            .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: AppTokens.Spacing.sm })
      }
      .width('100%')

      Button('Sign in')
        .width('100%')
        .height(44)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppTokens.Spacing.xl)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }

  @Builder
  OrDivider() {
    Row() {
      Divider()
        .vertical(false)
        .strokeWidth(1)
        .color(AppTokens.Colors.outline)
        .layoutWeight(1)

      Text('Or continue with')
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
        .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

      Divider()
        .vertical(false)
        .strokeWidth(1)
        .color(AppTokens.Colors.outline)
        .layoutWeight(1)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .margin({ top: AppTokens.Spacing.lg })
  }

  @Builder
  SocialButtons() {
    Column() {
      ForEach(this.socials, (item: SocialItem) => {
        Button(item.label)
          .width('100%')
          .height(40)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(item.tint)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {})
      }, (item: SocialItem) => item.label)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .margin({ top: AppTokens.Spacing.lg })
  }

  @Builder
  TermsText() {
    Row() {
      Text('By continuing you agree to the Terms and Privacy Policy')
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .fontColor(AppTokens.Colors.secondary)
        .lineHeight(AppTokens.TypographyTokens.label.lineHeight)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .margin({ top: AppTokens.Spacing.lg })
  }

  @Builder
  SupportSection() {
    Row() {
      Column() {
        Text('Need help?')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(AppTokens.TypographyTokens.title.lineHeight)

        Text('Contact support@example.com')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(AppTokens.TypographyTokens.body.lineHeight)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Support')
        .height(36)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onTertiary)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {})
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.xl,
      right: AppTokens.Spacing.xl,
      top: AppTokens.Spacing.lg,
      bottom: AppTokens.Spacing.lg
    })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
    .margin({ top: AppTokens.Spacing.xxl })
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#FF111827'
    export const onPrimary: ResourceColor = '#FFFFFFFF'
    export const secondary: ResourceColor = '#FF6B7280'
    export const onSecondary: ResourceColor = '#FFFFFFFF'
    export const tertiary: ResourceColor = '#FF2563EB'
    export const onTertiary: ResourceColor = '#FFFFFFFF'
    export const background: ResourceColor = '#FFF9FAFB'
    export const onBackground: ResourceColor = '#FF0B1220'
    export const surface: ResourceColor = '#FFFFFFFF'
    export const onSurface: ResourceColor = '#FF111827'
    export const surfaceVariant: ResourceColor = '#FFF3F4F6'
    export const outline: ResourceColor = '#FFE5E7EB'
    export const success: ResourceColor = '#FF16A34A'
    export const warning: ResourceColor = '#FFF59E0B'
    export const error: ResourceColor = '#FFDC2626'
  }

  export namespace TypographyTokens {
    export const display: TypographySpec = { fontSize: 22, fontWeight: FontWeight.SemiBold, lineHeight: 28 }
    export const headline: TypographySpec = { fontSize: 16, fontWeight: FontWeight.SemiBold, lineHeight: 22 }
    export const title: TypographySpec = { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 }
    export const body: TypographySpec = { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16 }
    export const label: TypographySpec = { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14 }
  }

  export namespace Shapes {
    export const small: Length = 4
    export const medium: Length = 8
    export const large: Length = 12
  }

  export namespace Spacing {
    export const xs: Length = 2
    export const sm: Length = 4
    export const md: Length = 6
    export const lg: Length = 8
    export const xl: Length = 12
    export const xxl: Length = 16
    export const xxxl: Length = 24
  }

  export namespace ElevationMapping {
    export const level1: ElevationSpec = { elevation: 1, radius: 2, dy: 0.5, opacity: 0.10 }
    export const level2: ElevationSpec = { elevation: 2, radius: 4, dy: 1, opacity: 0.14 }
    export const level3: ElevationSpec = { elevation: 3, radius: 6, dy: 1.5, opacity: 0.16 }
    export const level4: ElevationSpec = { elevation: 4, radius: 8, dy: 2, opacity: 0.18 }
    export const level5: ElevationSpec = { elevation: 5, radius: 10, dy: 2.5, opacity: 0.20 }
  }
}
