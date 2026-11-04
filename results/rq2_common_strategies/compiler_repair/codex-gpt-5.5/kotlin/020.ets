class RemoteColors {
  static primary: string = '#FF7A00';
  static secondary: string = '#FFC300';
  static tertiary: string = '#FFF3C0';
  static background: string = '#FFF8E7';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFEBC8';
  static outline: string = '#BCA789';
  static success: string = '#28A745';
  static error: string = '#DC3545';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State knobX: number = 0;
  @State knobY: number = 0;
  @State powerOn: boolean = false;

  private progressValue(): number {
    return ((this.knobX + this.knobY) % 400) / 4;
  }

  @Builder
  JoystickPanel() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(240)
        .height(240)
        .fill('#33FFC300')
      Circle()
        .width(48)
        .height(48)
        .fill(RemoteColors.primary)
        .translate({ x: this.knobX - 100, y: this.knobY - 100 })
    }
    .width(280)
    .height(280)
    .padding(16)
    .backgroundColor(RemoteColors.surfaceVariant)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          let nextX: number = this.knobX + event.offsetX;
          let nextY: number = this.knobY + event.offsetY;
          if (nextX < 0) {
            nextX = 0;
          }
          if (nextX > 200) {
            nextX = 200;
          }
          if (nextY < 0) {
            nextY = 0;
          }
          if (nextY > 200) {
            nextY = 200;
          }
          this.knobX = nextX;
          this.knobY = nextY;
        })
    )
  }

  build() {
    Column() {
      Text('Retro Remote Control')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(RemoteColors.onSurface)
        .textAlign(TextAlign.Center)
        .lineHeight(34)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        this.JoystickPanel()

        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? RemoteColors.success : RemoteColors.error)
          .lineHeight(24)
          .margin({ top: 24 })

        Row() {
          Button(this.powerOn ? 'Off' : 'On')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(RemoteColors.onPrimary)
            .width(80)
            .height(80)
            .backgroundColor(RemoteColors.primary)
            .borderRadius(40)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(RemoteColors.onSecondary)
            .width(80)
            .height(80)
            .backgroundColor(RemoteColors.secondary)
            .borderRadius(40)
            .onClick(() => {
              this.knobX = 0;
              this.knobY = 0;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })

        Progress({ value: this.progressValue(), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(RemoteColors.primary)
          .backgroundColor(RemoteColors.surfaceVariant)
          .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RemoteColors.background)
  }
}
