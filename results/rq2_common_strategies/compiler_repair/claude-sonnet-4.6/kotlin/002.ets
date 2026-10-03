import { router } from '@kit.ArkUI'

class SocialItem {
  label: string = ''
  tint: ResourceColor = 0xFF111827
}

const Colors = {
  primary: 0xFF111827,
  onPrimary: 0xFFFFFFFF,
  secondary: 0xFF6B7280,
  onSecondary: 0xFFFFFFFF,
  tertiary: 0xFF2563EB,
  onTertiary: 0xFFFFFFFF,
  background: 0xFFF9FAFB,
  onBackground: 0xFF0B1220,
  surface: 0xFFFFFFFF,
  onSurface: 0xFF111827,
  surfaceVariant: 0xFFF3F4F6,
  outline: 0xFFE5E7EB,
  success: 0xFF16A34A,
  warning: 0xFFF59E0B,
  error: 0xFFDC2626,
}

const Spacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24,
}

@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: Colors.primary },
    { label: 'Continue with Google', tint: Colors.tertiary },
    { label: 'Continue with GitHub', tint: Colors.secondary },
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.surface)

      Scroll() {
        Column({ space: Spacing.lg }) {
          // Login Card
          Column({ space: Spacing.lg }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            // Email field
            Column({ space: Spacing.md }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ text: this.email, placeholder: '' })
                .width('100%')
                .height(44)
                .fontSize(12)
                .backgroundColor(Colors.surface)
                .borderWidth(1)
                .borderColor(Colors.outline)
                .borderRadius(8)
                .onChange((val: string) => {
                  this.email = val
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Password field
            Column({ space: Spacing.md }) {
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ text: this.password, placeholder: '' })
                .type(InputType.Password)
                .width('100%')
                .height(44)
                .fontSize(12)
                .backgroundColor(Colors.surface)
                .borderWidth(1)
                .borderColor(Colors.outline)
                .borderRadius(8)
                .onChange((val: string) => {
                  this.password = val
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Forgot / Create account
            Row() {
              Text('Forgot password?')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.tertiary)

              Text('Create account')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.tertiary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ top: Spacing.sm })

            // Sign in button
            Button('Sign in')
              .width('100%')
              .height(44)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onPrimary)
              .backgroundColor(Colors.primary)
              .borderRadius(8)
          }
          .width('100%')
          .padding(Spacing.xl)
          .backgroundColor(Colors.surface)
          .borderRadius(12)
          .borderWidth(1)
          .borderColor(Colors.outline)
          .shadow({ radius: 4, color: '#22000000', offsetX: 0, offsetY: 1 })
          .alignItems(HorizontalAlign.Start)

          // Divider row
          Row({ space: Spacing.md }) {
            Divider()
              .layoutWeight(1)
              .color(Colors.outline)
              .strokeWidth(1)

            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)

            Divider()
              .layoutWeight(1)
              .color(Colors.outline)
              .strokeWidth(1)
          }
          .width('100%')
          .padding({ left: Spacing.xl, right: Spacing.xl })
          .alignItems(VerticalAlign.Center)

          // Social buttons
          Column({ space: Spacing.sm }) {
            ForEach(this.socials, (item: SocialItem) => {
              Button(item.label)
                .width('100%')
                .height(40)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
                .backgroundColor(item.tint)
                .borderRadius(8)
            })
          }
          .width('100%')

          // Terms row
          Row() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: Spacing.sm, bottom: Spacing.sm })

          // Help card
          Row() {
            Column({ space: Spacing.xs }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)

              Text('Contact support@example.com')
                .fontSize(12)
                .fontColor(Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('Support')
              .height(36)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onTertiary)
              .backgroundColor(Colors.tertiary)
              .borderRadius(8)
          }
          .width('100%')
          .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.lg, bottom: Spacing.lg })
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 0.5 })

          // Bottom spacer
          Row()
            .height(Spacing.xxl)
        }
        .width('100%')
        .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.lg, bottom: Spacing.lg })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}