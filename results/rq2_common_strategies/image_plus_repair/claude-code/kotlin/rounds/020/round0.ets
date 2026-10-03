import promptAction from '@ohos.promptAction';

@Entry
@Component
struct RemoteControlPage {
  @State knobPosition: { x: number; y: number } = { x: 0, y: 0 };
  @State powerOn: boolean = false;
  private canvasSize: number = 232;

  build() {
    Column() {
      Text('Retro Remote Control')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .margin({ top: 48, bottom: 24 })

      Stack() {
        Stack() {
          Canvas(this.canvasDraw.bind(this))
            .width('100%')
            .height('100%')
            .onReady(() => {})
        }
        .width(280)
        .height(280)
        .backgroundColor('#FFEBC8')
        .borderRadius(32)
        .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              const rect = event.target?.getArea()?.globalPosition;
              const targetRect = event.target?.getArea()?.position;
              const x = event.offsetX + this.canvasSize / 2;
              const y = event.offsetY + this.canvasSize / 2;
              const clampedX = Math.max(0, Math.min(this.canvasSize, x));
              const clampedY = Math.max(0, Math.min(this.canvasSize, y));
              this.knobPosition = { x: clampedX, y: clampedY };
            })
        )
      }
      .width(280)
      .height(280)
      .margin({ top: 32, bottom: 16 })

      Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.powerOn ? '#28A745' : '#DC3545')
        .margin({ top: 24, bottom: 24 })

      Row() {
        Button(this.powerOn ? 'Off' : 'On')
          .width(140)
          .height(140)
          .backgroundColor('#FF7A00')
          .fontColor('#FFFFFF')
          .fontSize(24)
          .borderRadius(70)
          .onClick(() => {
            this.powerOn = !this.powerOn;
          })

        Button('Reset')
          .width(140)
          .height(140)
          .backgroundColor('#FFC300')
          .fontColor('#1E1E1E')
          .fontSize(24)
          .borderRadius(70)
          .onClick(() => {
            this.knobPosition = { x: 0, y: 0 };
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 16, bottom: 32 })

      Progress({
        value: ((this.knobPosition.x + this.knobPosition.y) % 400) / 400 * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('90%')
        .height(8)
        .color('#FF7A00')
        .backgroundColor('#FFEBC8')
        .borderRadius(4)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E7')
    .alignItems(HorizontalAlign.Center)
  }

  canvasDraw(canvasCtx: CanvasRenderingContext2D) {
    const width = this.canvasSize;
    const height = this.canvasSize;
    const centerX = width / 2;
    const centerY = height / 2;

    canvasCtx.clearRect(0, 0, width, height);

    canvasCtx.fillStyle = 'rgba(255, 195, 0, 0.3)';
    canvasCtx.beginPath();
    canvasCtx.arc(centerX, centerY, 100, 0, Math.PI * 2);
    canvasCtx.fill();

    canvasCtx.fillStyle = '#FF7A00';
    canvasCtx.beginPath();
    canvasCtx.arc(this.knobPosition.x, this.knobPosition.y, 24, 0, Math.PI * 2);
    canvasCtx.fill();
  }
}
