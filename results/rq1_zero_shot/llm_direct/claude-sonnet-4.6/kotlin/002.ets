import { router } from '@kit.ArkUI';

// Design Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF111827';
    export const onPrimary: string = '#FFFFFFFF';
    export const secondary: string = '#FF6B7280';
    export const onSecondary: string = '#FFFFFFFF';
    export const tertiary: string = '#FF2563EB';
    export const onTertiary: string = '#FFFFFFFF';
    export const background: string = '#FFF9FAFB';
    export const onBackground: string = '#FF0B1220';
    export const surface: string = '#FFFFFFFF';
    export const onSurface: string = '#FF111827';
    export const surfaceVariant: string = '#FFF3F4F6';
    export const outline: string = '#FFE5E7EB';
    export const success: string = '#FF16A34A';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFDC2626';
  }

  export namespace Typography {
    export const displayFontSize: number = 22;
    export const displayFontWeight: FontWeight = FontWeight.Medium;
    export const headlineFontSize: number = 16;
    export const headlineFontWeight: FontWeight = FontWeight.Medium;
    export const titleFontSize: number = 14;
    export const titleFontWeight: FontWeight = FontWeight.Medium;
    export const bodyFontSize: number = 12;
    export const bodyFontWeight: FontWeight = FontWeight.Normal;
    export const labelFontSize: number = 10;
    export const labelFontWeight: FontWeight = FontWeight.Medium;
  }

  export namespace Spacing {
    export const xs: number = 2;
    export const sm: number = 4;
    export const md: number = 6;
    export const lg: number = 8;
    export const xl: number = 12;
    export const xxl: number = 16;
    export const xxxl: number = 24;
  }

  export namespace Radius {
    export const small: number = 4;
    export const medium: number = 8;
    export const large: number = 12;
  }
}

interface SocialItem {
  label: string;
  tint: string;
}

@Entry
@Component
struct RootScreen {
  @State email: string = '';
  @State password: string = '';

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppTokens.Colors.primary },
    { label: 'Continue with Google', tint: AppTokens.Colors.tertiary },
    { label: 'Continue with GitHub', tint: AppTokens.Colors.secondary },
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Sign in')
          .fontSize(AppTokens.Typography.displayFontSize)
          .fontWeight(AppTokens.Typography.displayFontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {

          // Login Card
          Column({ space: AppTokens.Spacing.lg }) {
            Text('Welcome back')
              .fontSize(AppTokens.Typography.headlineFontSize)
              .fontWeight(AppTokens.Typography.headlineFontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            // Email Field
            Column({ space: AppTokens.Spacing.md }) {
              Text('Email')
                .fontSize(AppTokens.Typography.labelFontSize)
                .fontWeight(AppTokens.Typography.labelFontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ text: this.email, placeholder: '' })
                .onChange((value: string) => {
                  this.email = value;
                })
                .fontSize(AppTokens.Typography.bodyFontSize)
                .fontWeight(AppTokens.Typography.bodyFontWeight)
                .width('100%')
                .height(44)
                .borderRadius(AppTokens.Radius.small)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .backgroundColor(AppTokens.Colors.surface)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

              // Password Field
              Text('Password')
                .fontSize(AppTokens.Typography.labelFontSize)
                .fontWeight(AppTokens.Typography.labelFontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ text: this.password, placeholder: '' })
                .type(InputType.Password)
                .onChange((value: string) => {
                  this.password = value;
                })
                .fontSize(AppTokens.Typography.bodyFontSize)
                .fontWeight(AppTokens.Typography.bodyFontWeight)
                .width('100%')
                .height(44)
                .borderRadius(AppTokens.Radius.small)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .backgroundColor(AppTokens.Colors.surface)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

              // Forgot / Create account row
              Row() {
                Text('Forgot password?')
                  .fontSize(AppTokens.Typography.labelFontSize)
                  .fontWeight(AppTokens.Typography.labelFontWeight)
                  .fontColor(AppTokens.Colors.tertiary)

                Text('Create account')
                  .fontSize(AppTokens.Typography.labelFontSize)
                  .fontWeight(AppTokens.Typography.labelFontWeight)
                  .fontColor(AppTokens.Colors.tertiary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .padding({ top: AppTokens.Spacing.sm })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Sign In Button
            Button('Sign in')
              .onClick(() => {})
              .width('100%')
              .height(44)
              .borderRadius(AppTokens.Radius.medium)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(AppTokens.Typography.titleFontSize)
              .fontWeight(AppTokens.Typography.titleFontWeight)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.xl,
            right: AppTokens.Spacing.xl,
            top: AppTokens.Spacing.xl,
            bottom: AppTokens.Spacing.xl
          })
          .borderRadius(AppTokens.Radius.large)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: 4,
            color: '#29000000',
            offsetX: 0,
            offsetY: 1
          })
          .alignItems(HorizontalAlign.Start)

          // Divider Row
          Row() {
            Divider()
              .color(AppTokens.Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1)

            Blank().width(AppTokens.Spacing.md)

            Text('Or continue with')
              .fontSize(AppTokens.Typography.labelFontSize)
              .fontWeight(AppTokens.Typography.labelFontWeight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank().width(AppTokens.Spacing.md)

            Divider()
              .color(AppTokens.Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl })
          .alignItems(VerticalAlign.Center)

          // Social Buttons
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.socials, (item: SocialItem) => {
              Button(item.label)
                .onClick(() => {})
                .width('100%')
                .height(40)
                .borderRadius(AppTokens.Radius.medium)
                .backgroundColor(item.tint)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(AppTokens.Typography.titleFontSize)
                .fontWeight(AppTokens.Typography.titleFontWeight)
            }, (item: SocialItem) => item.label)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          // Terms Row
          Row() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(AppTokens.Typography.labelFontSize)
              .fontWeight(AppTokens.Typography.labelFontWeight)
              .fontColor(AppTokens.Colors.secondary)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

          // Spacer
          Column()
            .height(AppTokens.Spacing.xxl)

          // Help Card
          Row() {
            Column({ space: AppTokens.Spacing.xs }) {
              Text('Need help?')
                .fontSize(AppTokens.Typography.titleFontSize)
                .fontWeight(AppTokens.Typography.titleFontWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Text('Contact support@example.com')
                .fontSize(AppTokens.Typography.bodyFontSize)
                .fontWeight(AppTokens.Typography.bodyFontWeight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('Support')
              .onClick(() => {})
              .height(36)
              .borderRadius(AppTokens.Radius.medium)
              .backgroundColor(AppTokens.Colors.tertiary)
              .fontColor(AppTokens.Colors.onTertiary)
              .fontSize(AppTokens.Typography.titleFontSize)
              .fontWeight(AppTokens.Typography.titleFontWeight)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.xl,
            right: AppTokens.Spacing.xl,
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg
          })
          .borderRadius(AppTokens.Radius.large)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .shadow({
            radius: 2,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 0.5
          })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.xl,
          right: AppTokens.Spacing.xl,
          top: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.lg
        })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}