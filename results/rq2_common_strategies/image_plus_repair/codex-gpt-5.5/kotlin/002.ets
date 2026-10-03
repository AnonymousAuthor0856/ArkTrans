interface ColorTokens {
  background: string
  surface: string
  text: string
  muted: string
  border: string
  primary: string
  blue: string
  github: string
}

const COLORS: ColorTokens = {
  background: '#F9FAFB',
  surface: '#FFFFFF',
  text: '#111827',
  muted: '#6B7280',
  border: '#E5E7EB',
  primary: '#111827',
  blue: '#2563EB',
  github: '#6B7280'
}

@Entry
@Component
struct MainPage {
  @State email: string = ''
  @State password: string = ''

  build() {
    Column() {
      Text('Sign in')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(88)
        .lineHeight(28)
        .padding({ top: 26 })

      Scroll() {
        Column({ space: 8 }) {
          Column({ space: 8 }) {
            Text('Welcome back')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.text)
              .width('100%')
              .lineHeight(28)

            Text('Email')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.text)
              .width('100%')
              .margin({ top: 4 })

            TextInput({ text: this.email })
              .type(InputType.Normal)
              .onChange((value: string) => {
                this.email = value
              })
              .height(112)
              .width('100%')
              .border({ width: 1, color: COLORS.border })
              .borderRadius(7)
              .backgroundColor(COLORS.surface)
              .padding({ left: 12, right: 12 })

            Text('Password')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.text)
              .width('100%')
              .margin({ top: 2 })

            TextInput({ text: this.password })
              .type(InputType.Password)
              .onChange((value: string) => {
                this.password = value
              })
              .height(112)
              .width('100%')
              .border({ width: 1, color: COLORS.border })
              .borderRadius(7)
              .backgroundColor(COLORS.surface)
              .padding({ left: 12, right: 12 })

            Row() {
              Text('Forgot password?')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLORS.blue)

              Blank()

              Text('Create account')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLORS.blue)
            }
            .width('100%')
            .margin({ top: 8 })

            Button('Sign in')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .backgroundColor(COLORS.primary)
              .borderRadius(16)
              .height(88)
              .width('100%')
              .margin({ top: 8 })
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })
          .backgroundColor(COLORS.surface)
          .border({ width: 1, color: COLORS.border })
          .borderRadius(22)
          .shadow({
            radius: 4,
            color: '#22000000',
            offsetX: 0,
            offsetY: 1
          })

          Row() {
            Divider()
              .color(COLORS.border)
              .strokeWidth(1)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.text)
              .margin({ left: 12, right: 12 })

            Divider()
              .color(COLORS.border)
              .strokeWidth(1)
              .layoutWeight(1)
          }
          .width('100%')
          .height(24)
          .margin({ top: 8 })

          Button('Continue with Apple')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor(COLORS.primary)
            .borderRadius(15)
            .height(80)
            .width('100%')

          Button('Continue with Google')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor(COLORS.blue)
            .borderRadius(15)
            .height(80)
            .width('100%')

          Button('Continue with GitHub')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor(COLORS.github)
            .borderRadius(15)
            .height(80)
            .width('100%')

          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.muted)
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ top: 12, bottom: 56 })

          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLORS.text)
                .width('100%')

              Text('Contact support@example.com')
                .fontSize(16)
                .fontColor(COLORS.text)
                .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('Support')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .backgroundColor(COLORS.blue)
              .borderRadius(15)
              .height(68)
              .width(144)
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
          .backgroundColor('#F3F4F6')
          .borderRadius(22)
          .shadow({
            radius: 3,
            color: '#18000000',
            offsetX: 0,
            offsetY: 1
          })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}
