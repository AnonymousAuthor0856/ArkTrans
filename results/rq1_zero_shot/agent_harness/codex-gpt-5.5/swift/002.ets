class SocialItem {
  label: string;
  tint: string;

  constructor(label: string, tint: string) {
    this.label = label;
    this.tint = tint;
  }
}

@Entry
@Component
struct ContentView {
  @State private email: string = '';
  @State private password: string = '';

  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', '#111827'),
    new SocialItem('Continue with Google', '#2563EB'),
    new SocialItem('Continue with GitHub', '#6B7280')
  ];

  @Builder
  FieldBlock(label: string, value: string, isPassword: boolean) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111827')
      TextInput({ text: value })
        .type(isPassword ? InputType.Password : InputType.Normal)
        .fontSize(12)
        .fontColor('#111827')
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#E5E7EB', radius: 8 })
        .borderRadius(8)
        .height(40)
        .padding({ left: 12, right: 12 })
        .margin({ top: 4 })
        .onChange((text: string) => {
          if (isPassword) {
            this.password = text;
          } else {
            this.email = text;
          }
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  LoginCard() {
    Column() {
      Text('Welcome back')
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#111827')
        .width('100%')

      this.FieldBlock('Email', this.email, false)
        .margin({ top: 12 })
      this.FieldBlock('Password', this.password, true)
        .margin({ top: 12 })

      Row() {
        Button('Forgot password?')
          .fontSize(10)
          .fontColor('#2563EB')
          .backgroundColor(Color.Transparent)
          .padding(0)
        Blank()
        Button('Create account')
          .fontSize(10)
          .fontColor('#2563EB')
          .backgroundColor(Color.Transparent)
          .padding(0)
      }
      .width('100%')
      .margin({ top: 18 })

      Button('Sign in')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#111827')
        .width('100%')
        .height(40)
        .borderRadius(8)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E5E7EB', radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#22000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  DividerWithText() {
    Row() {
      Divider()
        .color('#E5E7EB')
        .height(1)
        .layoutWeight(1)
      Text('Or continue with')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111827')
        .padding({ left: 8, right: 8 })
      Divider()
        .color('#E5E7EB')
        .height(1)
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ top: 16, bottom: 16 })
  }

  @Builder
  SupportCard() {
    Row() {
      Column() {
        Text('Need help?')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
        Text('Contact support@example.com')
          .fontSize(12)
          .fontColor('#111827')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Support')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#2563EB')
        .height(32)
        .padding({ left: 12, right: 12 })
        .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F3F4F6')
    .border({ width: 1, color: '#E5E7EB', radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 2, color: '#19000000', offsetX: 0, offsetY: 0.5 })
  }

  build() {
    Scroll() {
      Column() {
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#111827')
          .padding({ top: 36, bottom: 32 })

        this.LoginCard()
          .margin({ left: 16, right: 16 })

        this.DividerWithText()
          .padding({ left: 16, right: 16 })

        Column() {
          ForEach(this.socials, (social: SocialItem) => {
            Button(social.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor(social.tint)
              .width('100%')
              .height(36)
              .borderRadius(8)
              .margin({ bottom: 6 })
          }, (social: SocialItem) => social.label)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })

        Text('By continuing you agree to the Terms and Privacy Policy')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6B7280')
          .textAlign(TextAlign.Center)
          .padding({ left: 32, right: 32, top: 16 })

        this.SupportCard()
          .margin({ left: 16, right: 16, top: 32 })

        Blank()
          .height(32)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}
