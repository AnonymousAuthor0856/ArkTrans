@Entry
@Component
struct RootScreen {
  @State email: string = ''
  @State password: string = ''
  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', '#111827'),
    new SocialItem('Continue with Google', '#2563EB'),
    new SocialItem('Continue with GitHub', '#6B7280')
  ]

  @Builder
  TopBar() {
    Row() {
      Text('Sign in')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111827')
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SocialButton(item: SocialItem) {
    Button({}) {
      Text(item.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
    }
    .width('100%')
    .height(40)
    .backgroundColor(item.tint)
    .borderRadius(8)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 8 }) {
          // Login Card
          Column({ space: 8 }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')

            Column({ space: 6 }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')

              TextInput({ text: this.email })
                .onChange((value: string) => {
                  this.email = value
                })
                .height(44)
                .width('100%')
                .fontSize(12)
                .fontColor('#111827')
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#E5E7EB' })
                .padding({ left: 12, right: 12 })

              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')

              TextInput({ text: this.password })
                .onChange((value: string) => {
                  this.password = value
                })
                .height(44)
                .width('100%')
                .fontSize(12)
                .fontColor('#111827')
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#E5E7EB' })
                .padding({ left: 12, right: 12 })
                .type(InputType.Password)

              Row() {
                Text('Forgot password?')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
                Blank()
                Text('Create account')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 4 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Button('Sign in', {})
              .width('100%')
              .height(44)
              .backgroundColor('#111827')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .borderRadius(8)
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#E5E7EB' })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })

          // Divider Row
          Row({ space: 6 }) {
            Divider()
              .strokeWidth(1)
              .color('#E5E7EB')
              .layoutWeight(1)
            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
            Divider()
              .strokeWidth(1)
              .color('#E5E7EB')
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 12, right: 12 })
          .alignItems(VerticalAlign.Center)

          // Social Buttons
          Column({ space: 4 }) {
            ForEach(this.socials, (item: SocialItem) => {
              this.SocialButton(item)
            }, (item: SocialItem) => item.label)
          }
          .width('100%')

          // Terms Text
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#6B7280')
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({ top: 4, bottom: 4 })

          Blank()
            .height(16)

          // Support Card
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')
              Text('Contact support@example.com')
                .fontSize(12)
                .fontColor('#111827')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Support', {})
              .height(36)
              .backgroundColor('#2563EB')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .borderRadius(8)
              .padding({ left: 16, right: 16 })
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor('#F3F4F6')
          .borderRadius(12)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}

class SocialItem {
  label: string
  tint: string

  constructor(label: string, tint: string) {
    this.label = label
    this.tint = tint
  }
}