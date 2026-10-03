// Index.ets

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

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
struct RootScreen {
  @State email: string = '';
  @State password: string = '';

  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', '#111827'),
    new SocialItem('Continue with Google', '#2563EB'),
    new SocialItem('Continue with GitHub', '#6B7280')
  ];

  build() {
    Column() {
      // TopAppBar
      Text('Sign in')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111827')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 8 });

      // Scrollable Content
      Scroll() {
        Column() {
          // Card
          Column() {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .margin({ bottom: 8 });

            // Email Field
            Text('Email')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .margin({ bottom: 4 });
            TextInput({ text: this.email, placeholder: '' })
              .onChange((value: string) => {
                this.email = value;
              })
              .height(44)
              .borderRadius(8)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#E5E7EB' })
              .margin({ bottom: 6 });

            // Password Field
            Text('Password')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .margin({ bottom: 4 });
            TextInput({ text: this.password, placeholder: '' })
              .onChange((value: string) => {
                this.password = value;
              })
              .height(44)
              .borderRadius(8)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#E5E7EB' })
              .margin({ bottom: 4 });

            // Row for links
            Row() {
              Text('Forgot password?')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#2563EB');
              Text('Create account')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#2563EB');
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 4, bottom: 8 });

            // Sign in Button
            Button('Sign in', { type: ButtonType.Capsule })
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#111827')
              .width('100%')
              .height(44);
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#E5E7EB' })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 })
          .margin({ bottom: 8 });

          // Divider Row
          Row() {
            Divider().color('#E5E7EB').strokeWidth(1).layoutWeight(1);
            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .margin({ left: 6, right: 6 });
            Divider().color('#E5E7EB').strokeWidth(1).layoutWeight(1);
          }
          .width('100%')
          .margin({ top: 8, bottom: 8 });

          // Socials Column
          Column({ space: 4 }) {
            ForEach(this.socials, (item: SocialItem) => {
              Button(item.label, { type: ButtonType.Capsule })
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .backgroundColor(item.tint)
                .width('100%')
                .height(40);
            })
          }
          .width('100%')
          .margin({ bottom: 8 });

          // Terms Text
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#6B7280')
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ top: 4, bottom: 16 });

          // Support Surface
          Row() {
            Column() {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111827');
              Text('Contact support@example.com')
                .fontSize(12)
                .fontColor('#111827')
                .margin({ top: 2 });
            }
            .alignItems(HorizontalAlign.Start);

            Button('Support', { type: ButtonType.Capsule })
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#2563EB')
              .height(36);
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .backgroundColor('#F3F4F6')
          .borderRadius(12)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: 0.5 });
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB');
  }
}