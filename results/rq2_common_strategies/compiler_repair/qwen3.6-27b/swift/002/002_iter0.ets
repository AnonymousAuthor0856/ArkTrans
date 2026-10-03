// AppEntry.ets or EntryAbility.ets context assumed for entry, but this is the UI component

import { BusinessError } from '@kit.BasicServicesKit';
import { common, window } from '@kit.AbilityKit';
import { router } from '@kit.ArkUI';

// MARK: - Design Tokens
class AppTokens {
  static Colors = {
    primary: '#111827',
    onPrimary: '#FFFFFF',
    secondary: '#6B7280',
    onSecondary: '#FFFFFF',
    tertiary: '#2563EB',
    onTertiary: '#FFFFFF',
    background: '#F9FAFB',
    onBackground: '#0B1220',
    surface: '#FFFFFF',
    onSurface: '#111827',
    surfaceVariant: '#F3F4F6',
    outline: '#E5E7EB'
  };

  static Typography = {
    display: { size: 22, weight: FontWeight.Semibold },
    headline: { size: 16, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };
}

// MARK: - Data Models
interface SocialItem {
  label: string;
  tint: string;
}

@Entry
@Component
struct ContentView {
  @State email: string = '';
  @State password: string = '';

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppTokens.Colors.primary },
    { label: 'Continue with Google', tint: AppTokens.Colors.tertiary },
    { label: 'Continue with GitHub', tint: AppTokens.Colors.secondary }
  ];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column() {
          // Header
          Text('Sign in')
            .font({ size: AppTokens.Typography.display.size, weight: AppTokens.Typography.display.weight })
            .foregroundColor(AppTokens.Colors.onSurface)
            .padding({ top: 36, bottom: 32 })
            .alignSelf(ItemAlign.Start)
            .margin({ left: 16 }) // Align with card padding roughly

          // Login Card
          Column({ space: 12 }) {
            Text('Welcome back')
              .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
              .foregroundColor(AppTokens.Colors.onSurface)

            // Email Field
            Column({ space: 4 }) {
              Text('Email')
                .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
                .foregroundColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: '' })
                .type(InputType.Email)
                .text(this.email)
                .onChange((value: string) => {
                  this.email = value;
                })
                .width('100%')
                .height(40)
                .backgroundColor(Color.Transparent)
                .borderRadius(8)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: 12, right: 12 })
                .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
                .foregroundColor(AppTokens.Colors.onSurface)
            }

            // Password Field
            Column({ space: 4 }) {
              Text('Password')
                .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
                .foregroundColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: '' })
                .type(InputType.Password)
                .text(this.password)
                .onChange((value: string) => {
                  this.password = value;
                })
                .width('100%')
                .height(40)
                .backgroundColor(Color.Transparent)
                .borderRadius(8)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: 12, right: 12 })
                .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
                .foregroundColor(AppTokens.Colors.onSurface)
            }

            // Links
            Row() {
              Button('Forgot password?')
                .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
                .foregroundColor(AppTokens.Colors.tertiary)
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
                .onClick(() => {
                  // Handle forgot password
                })

              Flex().grow(1)

              Button('Create account')
                .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
                .foregroundColor(AppTokens.Colors.tertiary)
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
                .onClick(() => {
                  // Handle create account
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
            .padding({ top: 6 })

            // Sign In Button
            Button('Sign in')
              .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
              .foregroundColor(AppTokens.Colors.onPrimary)
              .width('100%')
              .height(40)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(8)
              .margin({ top: 8 })
              .onClick(() => {
                // Handle sign in
              })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: 4, color: '#00000024', offsetX: 0, offsetY: 1 }) // 0.14 opacity approx #24
          .margin({ left: 16, right: 16 })

          // Divider
          Row() {
            Divider()
              .color(AppTokens.Colors.outline)
              .width('100%')
              .margin({ right: 8 })

            Text('Or continue with')
              .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
              .foregroundColor(AppTokens.Colors.onSurface)
              .margin({ left: 8, right: 8 })

            Divider()
              .color(AppTokens.Colors.outline)
              .width('100%')
              .margin({ left: 8 })
          }
          .width('100%')
          .margin({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social buttons
          Column({ space: 6 }) {
            ForEach(this.socials, (item: SocialItem) => {
              Button(item.label)
                .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
                .foregroundColor(AppTokens.Colors.onPrimary)
                .width('100%')
                .height(36)
                .backgroundColor(item.tint as Color)
                .borderRadius(8)
                .onClick(() => {
                  // Handle social login
                })
            })
          }
          .margin({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
            .foregroundColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .margin({ top: 16, left: 32, right: 32 })

          // Help section
          Column() {
            Row() {
              Column({ space: 2 }) {
                Text('Need help?')
                  .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
                  .foregroundColor(AppTokens.Colors.onSurface)

                Text('Contact support@example.com')
                  .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
                  .foregroundColor(AppTokens.Colors.onSurface)
              }

              Flex().grow(1)

              Button('Support')
                .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
                .foregroundColor(AppTokens.Colors.onTertiary)
                .height(32)
                .padding({ left: 12, right: 12 })
                .backgroundColor(AppTokens.Colors.tertiary)
                .borderRadius(8)
                .onClick(() => {
                  // Handle support
                })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: 2, color: '#0000001A', offsetX: 0, offsetY: 0.5 }) // 0.10 opacity approx #1A
          .margin({ top: 32, left: 16, right: 16 })

          // Bottom spacer
          Flex().height(32)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .systemBarProperties({ statusBarColor: AppTokens.Colors.background })
  }
}