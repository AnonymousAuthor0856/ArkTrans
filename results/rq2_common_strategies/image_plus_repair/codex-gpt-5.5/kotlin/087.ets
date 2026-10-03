const TEA_BROWN: string = '#6D4C41';
const TEA_MUTED: string = '#8D6E63';
const TEXT_GRAY: string = '#8C8C8C';

@Entry
@Component
struct TeaBrewingScreen {
  @State private isRunning: boolean = false;

  build() {
    Column() {
      this.header()

      Blank()
        .height(32)

      this.teaSelectionCard()

      Blank()
        .height(32)

      this.timerDisplay()

      Blank()
        .height(40)

      this.controlButtons()

      Blank()
        .layoutWeight(1)

      this.preparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 24,
      right: 24,
      top: 24,
      bottom: 18
    })
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  header() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(20)
          .fontColor(TEXT_GRAY)
          .fontWeight(FontWeight.Regular)

        Text('Tea Master')
          .fontSize(30)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack({ alignContent: Alignment.Center }) {
        Text('⚙')
          .fontSize(28)
          .fontColor(Color.Black)
      }
      .width(64)
      .height(64)
      .backgroundColor('#F5F5F5')
      .borderRadius(32)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  teaSelectionCard() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('|')
            .fontSize(34)
            .fontColor(TEA_BROWN)
            .fontWeight(FontWeight.Regular)
        }
        .width(64)
        .height(64)
        .border({
          width: 3,
          color: TEA_BROWN
        })
        .borderRadius(32)
      }
      .width(120)
      .height(120)
      .backgroundColor('#EFEBE9')
      .borderRadius(60)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(20)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .maxLines(1)

        Text('Black Tea • 95°C')
          .fontSize(16)
          .fontColor(TEA_MUTED)
          .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Text('♥')
        .fontSize(32)
        .fontColor('#FFCDD2')
        .margin({ left: 8, right: 4 })
    }
    .width('100%')
    .height(200)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#FAFAFA')
    .border({
      width: 1,
      color: '#EEEEEE'
    })
    .borderRadius(24)
  }

  @Builder
  timerDisplay() {
    Stack({ alignContent: Alignment.Center }) {
      Progress({
        value: 67,
        total: 100,
        type: ProgressType.Ring
      })
        .width(250)
        .height(250)
        .color(TEA_BROWN)
        .backgroundColor('#F5F5F5')
        .style({
          strokeWidth: 12
        })

      Column() {
        Text('Steeping')
          .fontSize(16)
          .fontColor(TEXT_GRAY)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)

        Text('02:00')
          .fontSize(56)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Lighter)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(250)
    .height(250)
  }

  @Builder
  controlButtons() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text('↻')
          .fontSize(36)
          .fontColor('#8C8C8C')
      }
      .width(60)
      .height(60)
      .border({
        width: 1,
        color: '#E0E0E0'
      })
      .borderRadius(30)
      .onClick(() => {
        this.isRunning = false;
      })

      Button(this.isRunning ? '▮▮  Pause' : '▶  Start')
        .width(120)
        .height(60)
        .margin({ left: 24, right: 24 })
        .fontSize(18)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(TEA_BROWN)
        .borderRadius(24)
        .onClick(() => {
          this.isRunning = !this.isRunning;
        })

      Stack({ alignContent: Alignment.Center }) {
        Text('+')
          .fontSize(36)
          .fontColor('#8C8C8C')
      }
      .width(60)
      .height(60)
      .border({
        width: 1,
        color: '#E0E0E0'
      })
      .borderRadius(30)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  preparationSteps() {
    Column() {
      Text('PREPARATION')
        .width('100%')
        .fontSize(14)
        .fontColor('#C8C8C8')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 10 })

      this.stepItem('1', 'Boil fresh water to 95°C')
      this.stepItem('2', 'Add 1 tsp of loose leaf per cup')
      this.stepItem('3', 'Pour water and wait for timer')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  stepItem(step: string, label: string) {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text(step)
            .fontSize(14)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(28)
        .height(28)
        .backgroundColor('#F5F5F5')
        .borderRadius(14)

        Text(label)
          .layoutWeight(1)
          .fontSize(18)
          .fontColor('#4A4A4A')
          .margin({ left: 12 })
          .maxLines(1)

        Text('✓')
          .fontSize(22)
          .fontColor('#EEEEEE')
          .margin({ left: 8 })
      }
      .width('100%')
      .height(42)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .border({
      width: {
        bottom: 1
      },
      color: '#FAFAFA'
    })
  }
}
