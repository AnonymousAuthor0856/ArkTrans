class SleepColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

@Entry
@Component
struct Index {
  @Builder
  TopBar() {
    Row() {
      Text('<')
        .width(24)
        .height(24)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(SleepColors.onPrimary)
        .textAlign(TextAlign.Center)
        .backgroundColor(SleepColors.primary)
        .borderRadius(12)

      Text('Sleep Cycle')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(SleepColors.onBackground)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Text('?')
        .width(24)
        .height(24)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(SleepColors.onSecondary)
        .textAlign(TextAlign.Center)
        .backgroundColor(SleepColors.secondary)
        .borderRadius(12)
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SleepColors.surface)
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(160)
            .height(160)
            .fill(SleepColors.surface)
            .stroke(SleepColors.outline)
            .strokeWidth(2)

          Text('Zzz')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(SleepColors.primary)
        }
        .width(160)
        .height(160)
        .margin({ top: 24, bottom: 24 })

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(SleepColors.onSurface)
          .margin({ bottom: 24 })

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontColor(SleepColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: 24 })

        Button('Sign In')
          .width('80%')
          .height(52)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(SleepColors.onPrimary)
          .backgroundColor(SleepColors.primary)
          .borderRadius(16)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#2638BDF8', 0.0], ['#1A2563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(SleepColors.background)
  }
}
