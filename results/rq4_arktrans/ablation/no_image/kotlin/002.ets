@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''

  // Mock data for socials to satisfy the forEach requirement without 'any'
  private socials: Array<{ label: string }> = [
    { label: 'Google' },
    { label: 'Apple' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 8 }) {
        // Card Container
        Column() {
          Column({ space: 8 }) {
            Text('Welcome back')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')

            Column({ space: 6 }) {
              Text('Email')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')

              TextInput({ placeholder: 'Enter your email' })
                .width('100%')
                .height(44)
                .backgroundColor(Color.White)
                .borderRadius(4)
                .borderWidth(1)
                .borderColor('#D1D5DB')
                .onChange((value: string) => {
                  this.email = value
                })

              Text('Password')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827')

              TextInput({ placeholder: 'Enter your password' })
                .type(InputType.Password)
                .width('100%')
                .height(44)
                .backgroundColor(Color.White)
                .borderRadius(4)
                .borderWidth(1)
                .borderColor('#D1D5DB')
                .onChange((value: string) => {
                  this.password = value
                })

              Row() {
                Text('Forgot password?')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
                
                Blank()

                Text('Create account')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .padding({ top: 4 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Button('Sign in')
              .width('100%')
              .height(44)
              .backgroundColor('#2563EB')
              .fontColor(Color.White)
              .borderRadius(8)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

        // Divider Section
        Row() {
          Divider()
            .vertical(false)
            .color('#E5E7EB')
            .strokeWidth(1)
            .layoutWeight(1)

          Blank().width(8)

          Text('Or continue with')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')

          Blank().width(8)

          Divider()
            .vertical(false)
            .color('#E5E7EB')
            .strokeWidth(1)
            .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({ left: 12, right: 12 })

        // Social Buttons
        Column({ space: 4 }) {
          ForEach(this.socials, (item: { label: string }) => {
            Button(item.label)
              .width('100%')
              .height(40)
              .backgroundColor(Color.White)
              .fontColor('#111827')
              .borderRadius(8)
              .border({ width: 1, color: '#D1D5DB' })
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // Terms Text
        Row() {
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#6B7280')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({ top: 4, bottom: 4 })

        Blank().height(16)

        // Support Surface
        Column() {
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#111827')
              
              Text('Contact support@example.com')
                .fontSize(14)
                .fontColor('#111827')
            }
            .alignItems(HorizontalAlign.Start)

            Button('Support')
              .height(36)
              .backgroundColor('#F9FAFB')
              .fontColor('#111827')
              .borderRadius(8)
              .border({ width: 1, color: '#D1D5DB' })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        }
        .width('100%')
        .backgroundColor('#F3F4F6')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 1 })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      
      // Top App Bar Simulation (Overlay at top)
      Row() {
        Text('Sign in')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}