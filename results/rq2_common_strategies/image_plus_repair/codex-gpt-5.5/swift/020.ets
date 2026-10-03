@Entry
@Component
struct RetroRemoteControl {
  private readonly primaryColor: string = '#FF7A00';
  private readonly secondaryColor: string = '#FFC300';
  private readonly pageBackground: string = '#FFF8E7';
  private readonly surfaceVariantColor: string = '#FFebC8';
  private readonly knobTrackColor: string = '#FFE5A5';
  private readonly textColor: string = '#1E1E1E';
  private readonly errorColor: string = '#DC3545';
  private readonly successColor: string = '#28A745';

  @State private knobX: number = 90;
  @State private knobY: number = 140;
  @State private powerOn: boolean = false;

  private clamp(value: number, minimum: number, maximum: number): number {
    return Math.max(minimum, Math.min(maximum, value));
  }

  build() {
    Column() {
      Blank()
        .height(40)

      Stack() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
      }
      .height(64)
      .width('100%')
      .alignContent(Alignment.Center)

      Scroll() {
        Column() {
          Stack({ alignContent: Alignment.TopStart }) {
            Circle()
              .width(200)
              .height(200)
              .fill(this.knobTrackColor)
              .position({ x: 40, y: 40 })

            Circle()
              .width(32)
              .height(32)
              .fill(this.primaryColor)
              .position({ x: this.knobX - 16, y: this.knobY - 16 })
          }
          .width(280)
          .height(280)
          .backgroundColor(this.surfaceVariantColor)
          .borderRadius(24)
          .clip(true)
          .shadow({
            radius: 4,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 2
          })
          .gesture(
            PanGesture({ distance: 0 })
              .onActionUpdate((event: GestureEvent) => {
                const x: number = event.fingerList[0].localX;
                const y: number = event.fingerList[0].localY;
                this.knobX = this.clamp(x, 16, 264);
                this.knobY = this.clamp(y, 16, 264);
              })
          )
          .margin(16)

          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? this.successColor : this.errorColor)
            .margin({ top: 24, bottom: 28 })

          Row() {
            Button('On')
              .width(80)
              .height(80)
              .fontSize(18)
              .fontColor('#FFFFFF')
              .backgroundColor(this.primaryColor)
              .borderRadius(40)
              .onClick(() => {
                this.powerOn = !this.powerOn;
              })

            Button() {
              Column() {
                Text('Res')
                  .fontSize(18)
                  .fontColor(this.textColor)
                Text('et')
                  .fontSize(18)
                  .fontColor(this.textColor)
              }
              .justifyContent(FlexAlign.Center)
            }
            .width(80)
            .height(80)
            .backgroundColor(this.secondaryColor)
            .borderRadius(40)
            .margin({ left: 60 })
            .onClick(() => {
              this.knobX = 90;
              this.knobY = 140;
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 48 })

          Divider()
            .height(6)
            .width('100%')
            .color(this.primaryColor)
            .borderRadius(3)
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(this.pageBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackground)
    .padding({ top: 0, bottom: 0 })
  }
}
