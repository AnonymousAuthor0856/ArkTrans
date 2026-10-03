// Design Tokens
const primaryColor: string = '#111827';
const onPrimaryColor: string = '#FFFFFF';
const secondaryColor: string = '#6B7280';
const tertiaryColor: string = '#2563EB';
const onTertiaryColor: string = '#FFFFFF';
const backgroundColor: string = '#F9FAFB';
const onSurfaceColor: string = '#111827';
const surfaceColor: string = '#FFFFFF';
const surfaceVariantColor: string = '#F3F4F6';
const outlineColor: string = '#E5E7EB';

interface SocialItem {
  label: string;
  tint: string;
}

@Entry
@Component
struct ContentView {
  @State email: string = '';
  @State password: string = '';

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: primaryColor },
    { label: 'Continue with Google', tint: tertiaryColor },
    { label: 'Continue with GitHub', tint: secondaryColor },
  ];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(backgroundColor)

      Scroll() {
        Column() {
          // Header
          Text('Sign in')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(onSurfaceColor)
            .margin({ top: 36, bottom: 32 })

          // Login Card
          Column() {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(onSurfaceColor)
              .width('100%')
              .textAlign(TextAlign.Start)
              .margin({ bottom: 12 })

            // Email Field
            Column() {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ bottom: 4 })

              TextInput({ text: this.email, placeholder: '' })
                .onChange((value: string) => {
                  this.email = value;
                })
                .width('100%')
                .height(40)
                .fontSize(12)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceColor)
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(outlineColor)
                .padding({ left: 12, right: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 12 })

            // Password Field
            Column() {
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ bottom: 4 })

              TextInput({ text: this.password, placeholder: '' })
                .type(InputType.Password)
                .onChange((value: string) => {
                  this.password = value;
                })
                .width('100%')
                .height(40)
                .fontSize(12)
                .fontColor(onSurfaceColor)
                .backgroundColor(surfaceColor)
                .borderRadius(8)
                .borderWidth(1)
                .borderColor(outlineColor)
                .padding({ left: 12, right: 12 })
                .showPasswordIcon(false)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 12 })

            // Links Row
            Row() {
              Text('Forgot password?')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(tertiaryColor)
                .onClick(() => {})

              Blank()

              Text('Create account')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(tertiaryColor)
                .onClick(() => {})
            }
            .width('100%')
            .margin({ top: 6, bottom: 12 })

            // Sign In Button
            Button('Sign in')
              .width('100%')
              .height(40)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(onPrimaryColor)
              .backgroundColor(primaryColor)
              .borderRadius(8)
              .margin({ top: 8 })
              .onClick(() => {})
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceColor)
          .borderRadius(12)
          .border({ width: 1, color: outlineColor, radius: 12 })
          .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 16, right: 16 })

          // Divider with text
          Row() {
            Divider()
              .vertical(false)
              .strokeWidth(1)
              .color(outlineColor)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(onSurfaceColor)
              .margin({ left: 8, right: 8 })

            Divider()
              .vertical(false)
              .strokeWidth(1)
              .color(outlineColor)
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social Buttons
          Column() {
            ForEach(this.socials, (social: SocialItem) => {
              Button(social.label)
                .width('100%')
                .height(36)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(onPrimaryColor)
                .backgroundColor(social.tint)
                .borderRadius(8)
                .margin({ bottom: 6 })
                .onClick(() => {})
            }, (social: SocialItem) => social.label)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          // Terms Text
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(secondaryColor)
            .textAlign(TextAlign.Center)
            .margin({ top: 16, left: 32, right: 32 })

          // Help Section
          Row() {
            Column() {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(onSurfaceColor)
                .textAlign(TextAlign.Start)
                .margin({ bottom: 2 })

              Text('Contact support@example.com')
                .fontSize(12)
                .fontColor(onSurfaceColor)
                .textAlign(TextAlign.Start)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('Support')
              .height(32)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(onTertiaryColor)
              .backgroundColor(tertiaryColor)
              .borderRadius(8)
              .padding({ left: 12, right: 12 })
              .onClick(() => {})
          }
          .width('100%')
          .padding(16)
          .backgroundColor(surfaceVariantColor)
          .borderRadius(12)
          .border({ width: 1, color: outlineColor, radius: 12 })
          .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
          .margin({ top: 32, left: 16, right: 16 })
          .alignItems(VerticalAlign.Center)

          // Bottom spacer
          Column()
            .height(32)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}