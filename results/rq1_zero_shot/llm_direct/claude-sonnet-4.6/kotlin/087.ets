import { CommonColors } from '@ohos.arkui.theme';

@Entry
@Component
struct TeaBrewingScreen {
  build() {
    Column({ space: 0 }) {
      Column({ space: 0 }) {
        HeaderSection()

        Spacer({ height: 32 })

        TeaSelectionCard()

        Spacer({ height: 32 })

        TimerDisplay({ time: "02:00" })

        Spacer({ height: 40 })

        ControlButtons()

        Blank()

        PreparationSteps()
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(Color.Gray)

        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(0xFFF5F5F5)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Column() {
      Row({ space: 0 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(60)
            .height(60)
            .fill(0xFFEFEBE9)

          Canvas(new RenderingContextSettings(true))
            .width(30)
            .height(30)
            .onReady((context: CanvasRenderingContext2D) => {
              const cx = 15;
              const cy = 15;
              const r = 13;
              context.strokeStyle = '#6D4C41';
              context.lineWidth = 2;
              context.beginPath();
              context.arc(cx, cy, r, 0, Math.PI * 2);
              context.stroke();

              context.beginPath();
              context.moveTo(cx, cy - r / 2);
              context.lineTo(cx, cy + r / 2);
              context.lineCap = 'round';
              context.stroke();
            })
        }
        .width(60)
        .height(60)

        Blank().width(16)

        Column({ space: 4 }) {
          Text('Earl Grey Reserve')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Text('Black Tea • 95°C')
            .fontSize(12)
            .fontColor(0xFF8D6E63)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_heart_filled'))
          .width(24)
          .height(24)
          .fillColor(0xFFFFCDD2)
      }
      .width('100%')
      .padding(20)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(0xFFFAFAFA)
    .border({ width: 1, color: 0xFFEEEEEE, radius: 24 })
  }
}

@Component
struct TimerDisplay {
  @Prop time: string = '02:00';

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(new RenderingContextSettings(true))
        .width(220)
        .height(220)
        .onReady((context: CanvasRenderingContext2D) => {
          const cx = 110;
          const cy = 110;
          const r = 100;

          context.strokeStyle = '#F5F5F5';
          context.lineWidth = 12;
          context.beginPath();
          context.arc(cx, cy, r, 0, Math.PI * 2);
          context.stroke();

          context.strokeStyle = '#6D4C41';
          context.lineWidth = 12;
          context.lineCap = 'round';
          context.beginPath();
          const startAngle = -Math.PI / 2;
          const sweepAngle = (240 / 360) * Math.PI * 2;
          context.arc(cx, cy, r, startAngle, startAngle + sweepAngle);
          context.stroke();
        })

      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text(this.time)
          .fontSize(48)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }
}

@Component
struct ControlButtons {
  build() {
    Row({ space: 0 }) {
      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_refresh'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: 0xFFE0E0E0, radius: 30 })

      Blank().width(24)

      Button() {
        Row({ space: 8 }) {
          Image($r('sys.media.ohos_ic_public_play'))
            .width(20)
            .height(20)
            .fillColor(Color.White)

          Text('Start')
            .fontColor(Color.White)
            .fontSize(16)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor(0xFF6D4C41)

      Blank().width(24)

      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: 0xFFE0E0E0, radius: 30 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column({ space: 0 }) {
      Text('PREPARATION')
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  @Prop step: string = '';
  @Prop text: string = '';

  build() {
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(24)
            .height(24)
            .fill(0xFFF5F5F5)

          Text(this.step)
            .fontSize(10)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(24)
        .height(24)

        Blank().width(12)

        Text(this.text)
          .fontSize(14)
          .fontColor(0xFF333333)
          .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_ok'))
          .width(16)
          .height(16)
          .fillColor(0xFFEEEEEE)
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .color(0xFFFAFAFA)
        .strokeWidth(1)
    }
    .width('100%')
  }
}

@Component
struct Spacer {
  @Prop height: number = 0;
  @Prop width: number = 0;

  build() {
    Row()
      .height(this.height)
      .width(this.width > 0 ? this.width : '100%')
  }
}