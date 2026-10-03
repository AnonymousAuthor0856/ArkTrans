import { Component, View, Text, Button, Stack, Flex, Column, Row, Border, Color, Canvas, CanvasRenderingContext2D, CanvasRenderingContext2DSettings, LayoutMode, LayoutAlignment, Space, FontWeight, FontSize, Modifier, Background, BorderRadius, Width, Height, Padding, PointerEvent, TextStyle, TextAlign, GestureEvent, PanGestureEvent, PanGesture } from '@ohos.arkui';

@Component
export struct RootScreen {
  @State knobX: number = 300;
  @State knobY: number = 300;
  private knobRadius: number = 20;
  private trackRadius: number = 120;
  private centerX: number = 140;
  private centerY: number = 140;
  private settings: CanvasRenderingContext2DSettings = new CanvasRenderingContext2DSettings(true);
  private context2D: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      // Top App Bar
      Text('Retro Music Player')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F1F1F')
        .margin({ top: 20, bottom: 20 })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor('#FFFCF2');

      // Canvas Box
      Stack() {
        Canvas(this.context2D)
          .width(280)
          .height(280)
          .onReady(() => {
            this.drawCanvas();
          })
          .gesture(
            PanGesture()
              .onActionStart((event: PanGestureEvent) => {
                this.knobX = event.fingerList[0].localX;
                this.knobY = event.fingerList[0].localY;
                this.drawCanvas();
              })
              .onActionUpdate((event: PanGestureEvent) => {
                this.knobX = event.fingerList[0].localX;
                this.knobY = event.fingerList[0].localY;
                this.drawCanvas();
              })
          )
      }
      .width(280)
      .height(280)
      .backgroundColor('#FFF8E1')
      .border({ width: 3, color: '#BDBDBD', radius: 16 })
      .margin({ bottom: 20 });

      // Track Title
      Text('Track: Summer Nights')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1F1F1F')
        .margin({ bottom: 20 });

      // Buttons Row
      Row() {
        Button('Play')
          .width(120)
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#EF476F')
          .borderRadius(12)
          .margin({ right: 10 });

        Button('Pause')
          .width(120)
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F1F1F')
          .backgroundColor('#FFD166')
          .borderRadius(12)
          .margin({ left: 10 });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 20 });

      // Knob Position Text
      Text(`Knob X:${Math.floor(this.knobX)} Y:${Math.floor(this.knobY)}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#06D6A0')
        .margin({ bottom: 32 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF2')
    .padding({ left: 16, right: 16, bottom: 32 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center);
  }

  private drawCanvas() {
    const ctx = this.context2D;
    ctx.clearRect(0, 0, 280, 280);

    // Draw outer circle (track)
    ctx.beginPath();
    ctx.arc(this.centerX, this.centerY, this.trackRadius - 20, 0, Math.PI * 2);
    ctx.strokeStyle = '#FFD166';
    ctx.lineWidth = 12;
    ctx.stroke();

    // Draw knob
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, this.knobRadius, 0, Math.PI * 2);
    ctx.fillStyle = '#EF476F';
    ctx.fill();
  }
}