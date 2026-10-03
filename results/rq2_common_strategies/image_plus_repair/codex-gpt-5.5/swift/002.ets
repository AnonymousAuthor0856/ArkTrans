const PRIMARY: string = '#111827'
const SECONDARY: string = '#6B7280'
const BLUE: string = '#2563EB'
const BACKGROUND: string = '#F9FAFB'
const SURFACE: string = '#FFFFFF'
const SURFACE_VARIANT: string = '#F3F4F6'
const OUTLINE: string = '#E5E7EB'
const TEXT: string = '#111827'

@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''

  @Builder
  private textField(label: string, value: string, isPassword: boolean) {
    Column({ space: 4 }) {
      Text(label)
        .fontSize(16)
        .fontColor(TEXT)
        .fontWeight(FontWeight.Medium)
        .width('100%')

      TextInput({ text: value })
        .type(isPassword ? InputType.Password : InputType.Normal)
        .fontSize(16)
        .fontColor(TEXT)
        .backgroundColor(SURFACE)
        .border({
          width: 1,
          color: OUTLINE,
          radius: 8
        })
        .borderRadius(16)
        .height(82)
        .width('100%')
        .padding({ left: 12, right: 12 })
        .onChange((changed: string) => {
          if (isPassword) {
            this.password = changed
          } else {
            this.email = changed
          }
        })
    }
    .width('100%')
  }

  @Builder
  private socialButton(label: string, color: string) {
    Button(label)
      .fontSize(18)
      .fontColor('#FFFFFF')
      .fontWeight(FontWeight.Medium)
      .backgroundColor(color)
      .borderRadius(16)
      .height(72)
      .width('100%')
  }

  build() {
    Scroll() {
      Column({ space: 0 }) {
        Text('Sign in')
          .fontSize(44)
          .fontColor(TEXT)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 36, bottom: 64 })

        Column({ space: 18 }) {
          Text('Welcome back')
            .fontSize(32)
            .fontColor(TEXT)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          this.textField('Email', this.email, false)
          this.textField('Password', this.password, true)

          Row() {
            Button('Forgot password?')
              .fontSize(18)
              .fontColor(BLUE)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(Color.Transparent)
              .padding(0)
              .onClick(() => {})

            Blank()
              .layoutWeight(1)

            Button('Create account')
              .fontSize(18)
              .fontColor(BLUE)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(Color.Transparent)
              .padding(0)
              .onClick(() => {})
          }
          .width('100%')
          .margin({ top: 4 })

          Button('Sign in')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
            .backgroundColor(PRIMARY)
            .borderRadius(16)
            .height(80)
            .width('100%')
            .margin({ top: 10 })
            .onClick(() => {})
        }
        .padding(32)
        .width('100%')
        .backgroundColor(SURFACE)
        .border({
          width: 1,
          color: OUTLINE,
          radius: 24
        })
        .borderRadius(24)
        .shadow({
          radius: 12,
          color: '#24000000',
          offsetX: 0,
          offsetY: 2
        })

        Row({ space: 16 }) {
          Divider()
            .layoutWeight(1)
            .strokeWidth(1)
            .color(OUTLINE)

          Text('Or continue with')
            .fontSize(18)
            .fontColor(TEXT)
            .fontWeight(FontWeight.Medium)

          Divider()
            .layoutWeight(1)
            .strokeWidth(1)
            .color(OUTLINE)
        }
        .width('100%')
        .padding({ left: 0, right: 0 })
        .margin({ top: 32, bottom: 24 })

        Column({ space: 12 }) {
          this.socialButton('Continue with Apple', PRIMARY)
          this.socialButton('Continue with Google', BLUE)
          this.socialButton('Continue with GitHub', SECONDARY)
        }
        .width('100%')

        Text('By continuing you agree to the Terms and Privacy Policy')
          .fontSize(16)
          .fontColor(SECONDARY)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 32, left: 32, right: 32 })

        Row() {
          Column({ space: 2 }) {
            Text('Need help?')
              .fontSize(26)
              .fontColor(TEXT)
              .fontWeight(FontWeight.Medium)
              .width('100%')

            Row({ space: 4 }) {
              Text('Contact')
                .fontSize(20)
                .fontColor(TEXT)

              Text('support@example.com')
                .fontSize(20)
                .fontColor(BLUE)
            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button('Support')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
            .backgroundColor(BLUE)
            .borderRadius(16)
            .height(64)
            .padding({ left: 24, right: 24 })
            .onClick(() => {})
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding(32)
        .margin({ top: 64, bottom: 32 })
        .backgroundColor(SURFACE_VARIANT)
        .border({
          width: 1,
          color: OUTLINE,
          radius: 24
        })
        .borderRadius(24)
        .shadow({
          radius: 8,
          color: '#1A000000',
          offsetX: 0,
          offsetY: 1
        })
      }
      .width('100%')
      .padding({ left: 32, right: 32 })
    }
    .scrollBar(BarState.Off)
    .backgroundColor(BACKGROUND)
    .width('100%')
    .height('100%')
    .padding({ top: 0, bottom: 0 })
  }
}
