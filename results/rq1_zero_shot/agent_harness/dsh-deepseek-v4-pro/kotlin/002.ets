interface SocialItem {
  label: string
  tint: string
}

const Colors = {
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
  outline: '#E5E7EB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626'
}

const Spacing = {
  xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
}

@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''
  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: Colors.primary },
    { label: 'Continue with Google', tint: Colors.tertiary },
    { label: 'Continue with GitHub', tint: Colors.secondary }
  ]

  build() {
    Column() {
      Row() {
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Column({ space: Spacing.lg }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            Column({ space: Spacing.md }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              TextInput({ placeholder: 'Email', text: this.email })
                .fontSize(12)
                .width('100%')
                .height(44)
                .onChange((value: string) => { this.email = value })
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              TextInput({ placeholder: 'Password', text: this.password })
                .type(InputType.Password)
                .fontSize(12)
                .width('100%')
                .height(44)
                .onChange((value: string) => { this.password = value })
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
              .padding({ top: Spacing.sm })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Button('Sign in')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onPrimary)
              .backgroundColor(Colors.primary)
              .borderRadius(8)
              .width('100%')
              .height(44)
          }
          .width('100%')
          .backgroundColor(Colors.surface)
          .borderRadius(12)
          .border({ width: 1, color: Colors.outline })
          .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.xl, bottom: Spacing.xl })
          .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
          .alignItems(HorizontalAlign.Start)

          Row() {
            Divider()
              .color(Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1)
            Blank().width(Spacing.md)
            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Blank().width(Spacing.md)
            Divider()
              .color(Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: Spacing.xl, right: Spacing.xl })
          .alignItems(VerticalAlign.Center)

          Column({ space: Spacing.sm }) {
            ForEach(this.socials, (item: SocialItem) => {
              Button(item.label)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onPrimary)
                .backgroundColor(item.tint)
                .borderRadius(8)
                .width('100%')
                .height(40)
            }, (item: SocialItem) => item.label)
          }
          .width('100%')

          Row() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)
          }
          .width('100%')
          .padding({ top: Spacing.sm, bottom: Spacing.sm })
          .justifyContent(FlexAlign.Center)

          Blank().height(Spacing.xxl)

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

            Button('Support')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onTertiary)
              .backgroundColor(Colors.tertiary)
              .borderRadius(8)
              .height(36)
          }
          .width('100%')
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
          .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.lg, bottom: Spacing.lg })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.lg, bottom: Spacing.lg })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
