class ChargeColors {
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#22C55E';
  static readonly background: string = '#F5F5F4';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#D4D4D8';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly accent: string = '#F59E0B';
}

@Entry
@Component
struct Index {
  @State progressValue: number = 45;

  @Builder
  TopBar() {
    Row() {
      Text('EV')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ChargeColors.primary)
        .width(48)

      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(ChargeColors.onBackground)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Text('Set')
        .fontSize(14)
        .fontColor(ChargeColors.accent)
        .width(48)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(64)
    .padding({ left: 8, right: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(ChargeColors.surface)
  }

  private statusText(): string {
    if (this.progressValue < 100) {
      return 'Charging...';
    }
    return 'Fully Charged!';
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Text('Battery')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(ChargeColors.primary)
          .margin({ top: 20 })

        Text(this.progressValue.toString() + '%')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(ChargeColors.onBackground)
          .margin({ top: 20 })

        Progress({ value: this.progressValue, total: 100, type: ProgressType.Linear })
          .width('80%')
          .height(14)
          .color(ChargeColors.primary)
          .backgroundColor(ChargeColors.surface)
          .border({ width: 1, color: ChargeColors.outline })
          .margin({ top: 20 })

        Button('Simulate Charge')
          .fontSize(14)
          .fontColor(ChargeColors.onPrimary)
          .backgroundColor(ChargeColors.secondary)
          .borderRadius(20)
          .margin({ top: 20 })
          .onClick(() => {
            this.progressValue += 10;
            if (this.progressValue > 100) {
              this.progressValue = 0;
            }
          })

        Text(this.statusText())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.progressValue < 100 ? ChargeColors.primary : ChargeColors.secondary)
          .margin({ top: 20 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ChargeColors.background)
  }
}
