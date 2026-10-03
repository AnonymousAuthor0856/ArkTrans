@Entry
@Component
struct TeaBrewingScreen {
  private leafContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  private timerContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Scroll() {
      Column() {
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(14)
              .fontColor('#9E9E9E')
            Text('Tea Master')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor('#000000')
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .borderRadius(24)
            .backgroundColor('#F5F5F5')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Row() {
          Stack() {
            Canvas(this.leafContext)
              .width(30)
              .height(30)
              .onReady(() => {
                this.leafContext.strokeStyle = '#6D4C41'
                this.leafContext.lineWidth = 2
                this.leafContext.beginPath()
                this.leafContext.arc(15, 15, 13, 0, Math.PI * 2)
                this.leafContext.stroke()
                this.leafContext.beginPath()
                this.leafContext.moveTo(15, 7.5)
                this.leafContext.lineTo(15, 22.5)
                this.leafContext.stroke()
              })
          }
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor('#EFEBE9')
          .alignContent(Alignment.Center)

          Column() {
            Text('Earl Grey Reserve')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('Black Tea • 95°C')
              .fontSize(12)
              .fontColor('#8D6E63')
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 16 })

          Text('♥')
            .fontSize(20)
            .fontColor('#FFCDD2')
        }
        .width('100%')
        .padding(20)
        .borderRadius(24)
        .backgroundColor('#FAFAFA')
        .border({ width: 1, color: '#EEEEEE', radius: 24 })
        .alignItems(VerticalAlign.Center)
        .margin({ top: 32 })

        Stack() {
          Canvas(this.timerContext)
            .width(220)
            .height(220)
            .onReady(() => {
              this.timerContext.strokeStyle = '#F5F5F5'
              this.timerContext.lineWidth = 12
              this.timerContext.beginPath()
              this.timerContext.arc(110, 110, 104, 0, Math.PI * 2)
              this.timerContext.stroke()

              this.timerContext.strokeStyle = '#6D4C41'
              this.timerContext.lineWidth = 12
              this.timerContext.lineCap = 'round'
              this.timerContext.beginPath()
              this.timerContext.arc(110, 110, 104, -Math.PI / 2, -Math.PI / 2 + 240 * Math.PI / 180)
              this.timerContext.stroke()
            })

          Column() {
            Text('Steeping')
              .fontSize(12)
              .fontColor('#9E9E9E')
              .letterSpacing(2)
            Text('02:00')
              .fontSize(48)
              .fontWeight(FontWeight.Light)
              .fontColor('#000000')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width(220)
        .height(220)
        .alignContent(Alignment.Center)
        .margin({ top: 32 })

        Row() {
          Text('↻')
            .fontSize(24)
            .fontColor('#9E9E9E')
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(30)
            .border({ width: 1, color: '#E0E0E0', radius: 30 })

          Row() {
            Text('▶')
              .fontSize(20)
              .fontColor('#FFFFFF')
            Text('Start')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .margin({ left: 8 })
          }
          .width(120)
          .height(60)
          .borderRadius(24)
          .backgroundColor('#6D4C41')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .margin({ left: 24 })

          Text('+')
            .fontSize(24)
            .fontColor('#9E9E9E')
            .width(60)
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(30)
            .border({ width: 1, color: '#E0E0E0', radius: 30 })
            .margin({ left: 24 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 40 })

        Column() {
          Text('PREPARATION')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor('#BDBDBD')
            .margin({ bottom: 12 })

          this.StepItem('1', 'Boil fresh water to 95°C')
          this.StepItem('2', 'Add 1 tsp of loose leaf per cup')
          this.StepItem('3', 'Pour water and wait for timer')
        }
        .width('100%')
        .margin({ top: 40 })
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  @Builder
  StepItem(step: string, text: string) {
    Column() {
      Row() {
        Text(step)
          .fontSize(11)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
          .borderRadius(12)
          .backgroundColor('#F5F5F5')

        Text(text)
          .fontSize(14)
          .fontColor('#424242')
          .margin({ left: 12 })
          .layoutWeight(1)

        Text('✓')
          .fontSize(16)
          .fontColor('#EEEEEE')
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .color('#FAFAFA')
        .strokeWidth(1)
    }
  }
}