interface ColorPalette {
  primary: string;
  secondary: string;
  backgroundTop: string;
  backgroundBottom: string;
  ink: string;
  bodyInk: string;
  white: string;
  outline: string;
}

const COLORS: ColorPalette = {
  primary: '#2563EB',
  secondary: '#38BDF8',
  backgroundTop: '#E6F7FE',
  backgroundBottom: '#EAF2FF',
  ink: '#0F172A',
  bodyInk: '#1E293B',
  white: '#FFFFFF',
  outline: '#CBD5E1'
};

@Entry
@Component
struct SleepCyclePage {
  @State private signedIn: boolean = false;

  build() {
    Column() {
      Row() {
        Button('<')
          .width(48)
          .height(48)
          .fontSize(26)
          .fontColor(COLORS.white)
          .backgroundColor(COLORS.primary)
          .borderRadius(24)
          .padding(0)
          .onClick(() => {
            this.signedIn = false;
          });

        Text('Sleep Cycle')
          .fontSize(54)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.ink)
          .textAlign(TextAlign.Center)
          .layoutWeight(1);

        Button('?')
          .width(48)
          .height(48)
          .fontSize(24)
          .fontColor(COLORS.ink)
          .backgroundColor(COLORS.secondary)
          .borderRadius(24)
          .padding(0)
          .onClick(() => {
            this.signedIn = false;
          });
      }
      .width('100%')
      .height(96)
      .padding({ left: 32, right: 32 })
      .backgroundColor(COLORS.white)
      .alignItems(VerticalAlign.Center);

      Column() {
        Stack() {
          Circle()
            .width(320)
            .height(320)
            .fill(COLORS.white)
            .stroke(COLORS.outline)
            .strokeWidth(4);

          Text('😴')
            .fontSize(64)
            .textAlign(TextAlign.Center);
        }
        .width(320)
        .height(320)
        .margin({ top: 64 });

        Text('Welcome Back')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.bodyInk)
          .margin({ top: 48 });

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(28)
          .fontColor(COLORS.bodyInk)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 48 });

        Button('Sign In')
          .width('80%')
          .height(104)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.white)
          .backgroundColor(COLORS.primary)
          .borderRadius(32)
          .margin({ top: 48 })
          .onClick(() => {
            this.signedIn = true;
          });

        if (this.signedIn) {
          Text('Ready to rest well.')
            .fontSize(20)
            .fontColor(COLORS.bodyInk)
            .margin({ top: 20 });
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 32, right: 32 })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [COLORS.backgroundTop, 0.0],
          [COLORS.backgroundBottom, 1.0]
        ]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.white);
  }
}
