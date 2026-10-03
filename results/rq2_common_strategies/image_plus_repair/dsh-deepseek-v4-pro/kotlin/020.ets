@Entry
@Component
struct RetroRemoteControl {
  @State knobX: number = 0;
  @State knobY: number = 0;
  @State powerOn: boolean = false;

  private colorPrimary: string = '#FF7A00';
  private colorSecondary: string = '#FFC300';
  private colorTertiary: string = '#FFF3C0';
  private colorBackground: string = '#FFF8E7';
  private colorSurface: string = '#FFFFFF';
  private colorSurfaceVariant: string = '#FFEBC8';
  private colorOutline: string = '#BCA789';
  private colorSuccess: string = '#28A745';
  private colorWarning: string = '#FFC107';
  private colorError: string = '#DC3545';
  private colorOnPrimary: string = '#FFFFFF';
  private colorOnSecondary: string = '#1E1E1E';
  private colorOnTertiary: string = '#1E1E1E';
  private colorOnBackground: string = '#1E1E1E';
  private colorOnSurface: string = '#1E1E1E';

  private progressValue(): number {
    return ((this.knobX + this.knobY) % 400) / 400 * 100;
  }

  build() {
    Column() {
      Row() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorOnSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)

      Column({ space: 24 }) {
        Stack() {
          Circle()
            .width(400)
            .height(400)
            .fill(this.colorSecondary)
            .opacity(0.2)

          Circle()
            .width(48)
            .height(48)
            .fill(this.colorPrimary)
            .position({ x: this.knobX - 24, y: this.knobY - 24 })
        }
        .width(280)
        .height(280)
        .backgroundColor(this.colorSurfaceVariant)
        .borderRadius(24)
        .clip(true)
        .onTouch((event: TouchEvent) => {
          if (event.touches.length > 0 &&
            (event.type === TouchType.Down || event.type === TouchType.Move)) {
            this.knobX = event.touches[0].x;
            this.knobY = event.touches[0].y;
          }
        })

        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? this.colorSuccess : this.colorError)

        Row() {
          Button(this.powerOn ? 'Off' : 'On')
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(this.colorPrimary)
            .fontColor(this.colorOnPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

          Button('Reset')
            .width(80)
            .height(80)
            .borderRadius(40)
            .backgroundColor(this.colorSecondary)
            .fontColor(this.colorOnSecondary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.knobX = 0;
              this.knobY = 0;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Progress({ value: this.progressValue(), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(this.colorPrimary)
          .backgroundColor(this.colorSurfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}
