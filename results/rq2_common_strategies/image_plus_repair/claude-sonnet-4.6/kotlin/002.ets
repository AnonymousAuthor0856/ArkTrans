@Entry
@Component
struct RootScreen {
  @State email: string = ''
  @State password: string = ''

  private colorPrimary: string = '#FF111827'
  private colorOnPrimary: string = '#FFFFFFFF'
  private colorSecondary: string = '#FF6B7280'
  private colorTertiary: string = '#FF2563EB'
  private colorBackground: string = '#FFF9FAFB'
  private colorSurface: string = '#FFFFFFFF'
  private colorOnSurface: string = '#FF111827'
  private colorSurfaceVariant: string = '#FFF3F4F6'
  private colorOutline: string = '#FFE5E7EB'

  @Builder
  SocialButton(label: string, bgColor: string) {
    Button(label)
      .width('100%')
      .height(40)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor('#FFFFFFFF')
      .backgroundColor(bgColor)
      .borderRadius(8)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.colorBackground)

      Scroll() {
        Column({ space: 8 }) {
          // Login Card
          Column({ space: 8 }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.colorOnSurface)
              .alignSelf(ItemAlign.Start)

            // Email field
            Column({ space: 6 }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ text: this.email, placeholder: '' })
                .onChange((val: string) => { this.email = val })
                .width('100%')
                .height(44)
                .fontSize(12)
                .backgroundColor(this.colorSurface)
                .borderWidth(1)
                .borderColor(this.colorOutline)
                .borderRadius(4)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Password field
            Column({ space: 6 }) {
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ text: this.password, placeholder: '' })
                .type(InputType.Password)
                .onChange((val: string) => { this.password = val })
                .width('100%')
                .height(44)
                .fontSize(12)
                .backgroundColor(this.colorSurface)
                .borderWidth(1)
                .borderColor(this.colorOutline)
                .borderRadius(4)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Forgot / Create account row
            Row() {
              Text('Forgot password?')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorTertiary)
              Text('Create account')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorTertiary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ top: 4 })

            // Sign in button
            Button('Sign in')
              .width('100%')
              .height(44)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorOnPrimary)
              .backgroundColor(this.colorPrimary)
              .borderRadius(8)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.colorSurface)
          .borderRadius(12)
          .border({ width: 1, color: this.colorOutline })
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 1 })

          // Divider row
          Row({ space: 6 }) {
            Divider()
              .layoutWeight(1)
              .color(this.colorOutline)
              .strokeWidth(1)
            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorOnSurface)
            Divider()
              .layoutWeight(1)
              .color(this.colorOutline)
              .strokeWidth(1)
          }
          .width('100%')
          .padding({ left: 12, right: 12 })
          .alignItems(VerticalAlign.Center)

          // Social buttons
          Column({ space: 4 }) {
            this.SocialButton('Continue with Apple', this.colorPrimary)
            this.SocialButton('Continue with Google', this.colorTertiary)
            this.SocialButton('Continue with GitHub', this.colorSecondary)
          }
          .width('100%')

          // Terms row
          Row() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorSecondary)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: 4, bottom: 4 })

          // Help card
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSurface)
              Text('Contact support@example.com')
                .fontSize(12)
                .fontColor(this.colorOnSurface)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('Support')
              .height(36)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFFFF')
              .backgroundColor(this.colorTertiary)
              .borderRadius(8)
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor(this.colorSurfaceVariant)
          .borderRadius(12)
          .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 0.5 })
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().height(16)
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}