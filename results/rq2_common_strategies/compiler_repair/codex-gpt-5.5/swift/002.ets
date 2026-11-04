class SocialItem {
  label: string
  tint: string

  constructor(label: string, tint: string) {
    this.label = label
    this.tint = tint
  }
}

@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''

  private primaryTextColor: string = '#111827'
  private secondaryTextColor: string = '#6B7280'
  private linkColor: string = '#2563EB'
  private pageBgColor: string = '#F9FAFB'
  private inputBgColor: string = '#F3F4F6'
  private borderLineColor: string = '#E5E7EB'
  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', '#111827'),
    new SocialItem('Continue with Google', '#2563EB'),
    new SocialItem('Continue with GitHub', '#6B7280')
  ]

  @Builder
  FieldLabel(label: string) {
    Text(label)
      .fontSize(13)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.primaryTextColor)
      .margin({ bottom: 8 })
  }

  @Builder
  TextField(value: string, placeholder: string, isPassword: boolean) {
    TextInput({ text: value, placeholder: placeholder })
      .height(46)
      .fontSize(15)
      .fontColor(this.primaryTextColor)
      .placeholderColor('#9CA3AF')
      .backgroundColor(this.inputBgColor)
      .border({ width: 1, color: this.borderLineColor, radius: 10 })
      .padding({ left: 12, right: 12 })
      .type(isPassword ? InputType.Password : InputType.Email)
      .onChange((text: string) => {
        if (isPassword) {
          this.password = text
        } else {
          this.email = text
        }
      })
  }

  @Builder
  SocialButton(item: SocialItem) {
    Button() {
      Row() {
        Circle()
          .width(10)
          .height(10)
          .fill(item.tint)
          .margin({ right: 10 })
        Text(item.label)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primaryTextColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .height(46)
    .width('100%')
    .backgroundColor(Color.White)
    .border({ width: 1, color: this.borderLineColor, radius: 10 })
    .margin({ bottom: 10 })
  }

  build() {
    Scroll() {
      Column() {
        Text('Sign in')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryTextColor)
          .width('100%')
          .margin({ top: 42, bottom: 22 })

        Column() {
          Text('Welcome back')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.primaryTextColor)
            .width('100%')
            .margin({ bottom: 20 })

          this.FieldLabel('Email')
          this.TextField(this.email, 'name@example.com', false)

          Column() {
            this.FieldLabel('Password')
            this.TextField(this.password, 'Password', true)
          }
          .margin({ top: 16 })

          Row() {
            Text('Forgot password?')
              .fontSize(14)
              .fontColor(this.linkColor)
            Blank()
            Text('Create account')
              .fontSize(14)
              .fontColor(this.linkColor)
          }
          .width('100%')
          .margin({ top: 14, bottom: 22 })

          Button('Sign in')
            .height(48)
            .width('100%')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .backgroundColor(this.primaryTextColor)
            .borderRadius(10)
        }
        .width('100%')
        .padding(18)
        .backgroundColor(Color.White)
        .border({ width: 1, color: this.borderLineColor, radius: 12 })
        .shadow({ radius: 12, color: '#12000000', offsetY: 4 })

        Row() {
          Divider().layoutWeight(1).color(this.borderLineColor)
          Text('Or continue with')
            .fontSize(13)
            .fontColor(this.secondaryTextColor)
            .margin({ left: 12, right: 12 })
          Divider().layoutWeight(1).color(this.borderLineColor)
        }
        .width('100%')
        .margin({ top: 24, bottom: 18 })

        Column() {
          ForEach(this.socials, (item: SocialItem) => {
            this.SocialButton(item)
          }, (item: SocialItem) => item.label)
        }
        .width('100%')

        Text('By continuing you agree to the Terms and Privacy Policy')
          .fontSize(12)
          .fontColor(this.secondaryTextColor)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 8, bottom: 22 })

        Row() {
          Column() {
            Text('Need help?')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.primaryTextColor)
              .width('100%')
            Text('Contact support@example.com')
              .fontSize(13)
              .fontColor(this.secondaryTextColor)
              .width('100%')
              .margin({ top: 6 })
          }
          .layoutWeight(1)

          Button('Support')
            .height(36)
            .fontSize(14)
            .fontColor(this.linkColor)
            .backgroundColor('#EFF6FF')
            .borderRadius(9)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Color.White)
        .border({ width: 1, color: this.borderLineColor, radius: 12 })
        .margin({ bottom: 34 })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBgColor)
  }
}
