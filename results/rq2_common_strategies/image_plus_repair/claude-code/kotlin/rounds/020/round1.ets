@Entry
@Component
struct RemoteControlPage {
  @State knobX: number = 24;
  @State knobY: number = 24;
  @State powerOn: boolean = false;
  private remoteSize: number = 280;
  private knobRadius: number = 24;

  aboutToAppear() {
    this.knobX = this.knobRadius;
    this.knobY = this.knobRadius;
  }

  build() {
    Column() {
      Text('Retro Remote Control')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .margin({ top: 48, bottom: 32 })

      Stack({ alignContent: Alignment.TopStart }) {
        Circle({ width: 200, height: 200 })
          .fill('#FFE6A0')
          .width(200)
          .height(200)

        Circle({ width: this.knobRadius * 2, height: this.knobRadius * 2 })
          .fill('#FF7A00')
          .width(this.knobRadius * 2)
          .height(this.knobRadius * 2)
          .position({ x: this.knobX - this.knobRadius, y: this.knobY - this.knobRadius })
      }
      .width(this.remoteSize)
      .height(this.remoteSize)
      .backgroundColor('#FFEBC8')
      .borderRadius(32)
      .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
      .margin({ top: 32, bottom: 8 })
      .alignContent(Alignment.Center)
      .gesture(
        PanGesture()
          .onActionStart((event: GestureEvent) => {
            this.updateKnobPosition(event);
          })
          .onActionUpdate((event: GestureEvent) => {
            this.updateKnobPosition(event);
          })
      )

      Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
        .fontSize(32)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.powerOn ? '#28A745' : '#DC3545')
        .margin({ top: 32, bottom: 32 })

      Row() {
        Button(this.powerOn ? 'Off' : 'On')
          .width(150)
          .height(150)
          .backgroundColor('#FF7A00')
          .fontColor('#FFFFFF')
          .fontSize(32)
          .borderRadius(75)
          .onClick(() => {
            this.powerOn = !this.powerOn;
          })

        Button('Reset')
          .width(150)
          .height(150)
          .backgroundColor('#FFC300')
          .fontColor('#1E1E1E')
          .fontSize(32)
          .borderRadius(75)
          .onClick(() => {
            this.knobX = this.knobRadius;
            this.knobY = this.knobRadius;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 8, bottom: 40 })

      Progress({
        value: ((this.knobX + this.knobY) % 400) / 400 * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('90%')
        .height(10)
        .color('#FF7A00')
        .backgroundColor('#FFEBC8')
        .borderRadius(5)
        .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E7')
    .alignItems(HorizontalAlign.Center)
  }

  private updateKnobPosition(event: GestureEvent): void {
    const x = event.localX;
    const y = event.localY;
    const minVal = this.knobRadius;
    const maxVal = this.remoteSize - this.knobRadius;
    this.knobX = Math.max(minVal, Math.min(maxVal, x));
    this.knobY = Math.max(minVal, Math.min(maxVal, y));
  }
}
