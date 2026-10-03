interface SocialItem {
  label: string;
  bgColor: string;
}

@Entry
@Component
struct ContentView {
  @State email: string = ''
  @State password: string = ''

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', bgColor: '#111827' } as SocialItem,
    { label: 'Continue with Google', bgColor: '#2563EB' } as SocialItem,
    { label: 'Continue with GitHub', bgColor: '#6B7280' } as SocialItem
  ]

  build() {
    Scroll() {
      Column({ space: 0 }) {
        // Header
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .margin({ top: 36, bottom: 32 })

        // Login Card
        Column({ space: 12 }) {
          Text('Welcome back')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
            .alignSelf(ItemAlign.Start)

          // Email Field
          Column({ space: 4 }) {
            Text('Email')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .alignSelf(ItemAlign.Start)

            TextInput({ text: this.email, placeholder: '' })
              .onChange((value: string) => {
                this.email = value
              })
              .height(40)
              .width('100%')
              .fontSize(12)
              .fontColor('#111827')
              .backgroundColor(Color.White)
              .border({ width: 1, color: '#E5E7EB', radius: 8 })
              .padding({ left: 12, right: 12 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // Password Field
          Column({ space: 4 }) {
            Text('Password')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .alignSelf(ItemAlign.Start)

            TextInput({ text: this.password, placeholder: '' })
              .type(InputType.Password)
              .onChange((value: string) => {
                this.password = value
              })
              .height(40)
              .width('100%')
              .fontSize(12)
              .fontColor('#111827')
              .backgroundColor(Color.White)
              .border({ width: 1, color: '#E5E7EB', radius: 8 })
              .padding({ left: 12, right: 12 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // Links Row
          Row() {
            Text('Forgot password?')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2563EB')
              .onClick(() => {})

            Blank()

            Text('Create account')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2563EB')
              .onClick(() => {})
          }
          .width('100%')
          .margin({ top: 6 })

          // Sign In Button
          Button('Sign in')
            .width('100%')
            .height(40)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .backgroundColor('#111827')
            .borderRadius(8)
            .margin({ top: 8 })
            .onClick(() => {})
        }
        .padding(16)
        .width('calc(100% - 32vp)')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .border({ width: 1, color: '#E5E7EB', radius: 12 })
        .shadow({ radius: 4, color: '#00000024', offsetX: 0, offsetY: 1 })
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16, right: 16 })

        // Divider
        Row() {
          Divider()
            .color('#E5E7EB')
            .strokeWidth(1)
            .layoutWeight(1)

          Text('Or continue with')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')
            .margin({ left: 8, right: 8 })

          Divider()
            .color('#E5E7EB')
            .strokeWidth(1)
            .layoutWeight(1)
        }
        .width('calc(100% - 32vp)')
        .margin({ top: 16, bottom: 16, left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)

        // Social Buttons
        Column({ space: 6 }) {
          ForEach(this.socials, (social: SocialItem) => {
            Button(social.label)
              .width('100%')
              .height(36)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .backgroundColor(social.bgColor)
              .borderRadius(8)
              .onClick(() => {})
          })
        }
        .width('calc(100% - 32vp)')
        .margin({ left: 16, right: 16 })

        // Terms Text
        Text('By continuing you agree to the Terms and Privacy Policy')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6B7280')
          .textAlign(TextAlign.Center)
          .margin({ top: 16, left: 32, right: 32 })

        // Help Section
        Row() {
          Column({ space: 2 }) {
            Text('Need help?')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .alignSelf(ItemAlign.Start)

            Row() {
              Text('Contact ')
                .fontSize(12)
                .fontColor('#111827')
              Text('support@example.com')
                .fontSize(12)
                .fontColor('#2563EB')
            }
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button('Support')
            .height(32)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .backgroundColor('#2563EB')
            .borderRadius(8)
            .padding({ left: 12, right: 12 })
            .onClick(() => {})
        }
        .width('calc(100% - 32vp)')
        .padding(16)
        .backgroundColor('#F3F4F6')
        .borderRadius(12)
        .border({ width: 1, color: '#E5E7EB', radius: 12 })
        .shadow({ radius: 2, color: '#0000001A', offsetX: 0, offsetY: 1 })
        .margin({ top: 32, left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)

        // Bottom spacer
        Row()
          .height(32)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
    .scrollBar(BarState.Off)
  }
}