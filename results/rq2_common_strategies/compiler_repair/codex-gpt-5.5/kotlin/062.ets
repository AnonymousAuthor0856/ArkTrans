class ThermoColors {
  static readonly primary: string = '#3B82F6';
  static readonly secondary: string = '#06B6D4';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

@Entry
@Component
struct Index {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  @Builder
  TopBar() {
    Row() {
      Text('T')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ThermoColors.primary)
        .width(36)

      Text('ThermoCurve')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(ThermoColors.onBackground)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Button('Sun')
        .height(36)
        .fontSize(12)
        .fontColor(ThermoColors.secondary)
        .backgroundColor(ThermoColors.surfaceVariant)
        .onClick(() => {
          this.targetTemp += 1;
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: 12, right: 12 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(ThermoColors.surfaceVariant)
  }

  @Builder
  ModeButton(label: string, icon: string) {
    Column() {
      Text(icon)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.mode === label ? ThermoColors.onPrimary : ThermoColors.onSurface)
      Text(label)
        .fontSize(14)
        .fontColor(this.mode === label ? ThermoColors.onPrimary : ThermoColors.onSurface)
        .margin({ top: 6 })
    }
    .width(100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.mode === label ? ThermoColors.primary : ThermoColors.surfaceVariant)
    .borderRadius(50)
    .onClick(() => {
      this.mode = label;
    })
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(ThermoColors.onSurface)

        Text(this.targetTemp.toString() + ' C')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(ThermoColors.primary)
          .margin({ top: 22 })

        Row() {
          Button('-')
            .fontSize(20)
            .fontColor(ThermoColors.onPrimary)
            .backgroundColor(ThermoColors.primary)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1;
              }
            })

          Button('+')
            .fontSize(20)
            .fontColor(ThermoColors.onPrimary)
            .backgroundColor(ThermoColors.primary)
            .margin({ left: 12 })
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1;
              }
            })
        }
        .margin({ top: 22 })

        Divider()
          .width('80%')
          .height(1)
          .color('#80CBD5E1')
          .margin({ top: 26, bottom: 26 })

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(ThermoColors.onSurface)

        Row() {
          this.ModeButton('Cool', 'W')
          Column() {
            this.ModeButton('Heat', 'S')
          }
          .margin({ left: 18 })
        }
        .margin({ top: 18 })

        Text('Current Mode: ' + this.mode)
          .fontSize(12)
          .fontColor(ThermoColors.onSurface)
          .margin({ top: 26 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(18)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#2606B6D4', 0.0], ['#333B82F6', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ThermoColors.background)
  }
}
