@Entry
@Component
struct TeaBrewingScreen {
  private teaIconSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private teaIconContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.teaIconSettings)
  private timerSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private timerContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.timerSettings)

  build() {
    Scroll() {
      Column() {
        // Header Section
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(14)
              .fontColor('#999999')
            Text('Tea Master')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button({ type: ButtonType.Circle }) {
            Text('⚙')
              .fontSize(20)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Tea Selection Card
        Column() {
          Row() {
            Stack() {
              Circle()
                .width(60)
                .height(60)
                .fill('#EFEBE9')

              Canvas(this.teaIconContext)
                .width(30)
                .height(30)
                .onReady(() => {
                  const ctx = this.teaIconContext
                  const w = 30
                  const h = 30
                  ctx.strokeStyle = '#6D4C41'
                  ctx.lineWidth = 2
                  ctx.beginPath()
                  ctx.arc(w / 2, h / 2, w / 2 - 1, 0, Math.PI * 2)
                  ctx.stroke()
                  ctx.beginPath()
                  ctx.moveTo(w / 2, h / 4)
                  ctx.lineTo(w / 2, h * 0.75)
                  ctx.lineCap = 'round'
                  ctx.stroke()
                })
            }
            .width(60)
            .height(60)

            Column() {
              Text('Earl Grey Reserve')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              Text('Black Tea • 95°C')
                .fontSize(12)
                .fontColor('#8D6E63')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .margin({ left: 16 })

            Text('♥')
              .fontSize(22)
              .fontColor('#FFCDD2')
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding(20)
        }
        .width('100%')
        .backgroundColor('#FAFAFA')
        .borderRadius(24)
        .border({ width: 1, color: '#EEEEEE' })
        .margin({ top: 32 })

        // Timer Display
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.timerContext)
            .width(220)
            .height(220)
            .onReady(() => {
              const ctx = this.timerContext
              const cx = 110
              const cy = 110
              const radius = 104
              // Background circle
              ctx.strokeStyle = '#F5F5F5'
              ctx.lineWidth = 12
              ctx.beginPath()
              ctx.arc(cx, cy, radius, 0, Math.PI * 2)
              ctx.stroke()
              // Progress arc
              ctx.strokeStyle = '#6D4C41'
              ctx.lineWidth = 12
              ctx.lineCap = 'round'
              ctx.beginPath()
              const startAngle = -Math.PI / 2
              const sweepAngle = (240 / 360) * Math.PI * 2
              ctx.arc(cx, cy, radius, startAngle, startAngle + sweepAngle)
              ctx.stroke()
            })

          Column() {
            Text('Steeping')
              .fontSize(12)
              .fontColor('#999999')
              .letterSpacing(2)
            Text('02:00')
              .fontSize(48)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(220)
        .height(220)
        .margin({ top: 32 })

        // Control Buttons
        Row() {
          Button({ type: ButtonType.Circle }) {
            Text('↺')
              .fontSize(22)
              .fontColor('#999999')
          }
          .width(60)
          .height(60)
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#E0E0E0' })

          Button() {
            Row() {
              Text('▶')
                .fontSize(16)
                .fontColor(Color.White)
                .margin({ right: 8 })
              Text('Start')
                .fontSize(16)
                .fontColor(Color.White)
            }
          }
          .width(120)
          .height(60)
          .borderRadius(24)
          .backgroundColor('#6D4C41')
          .margin({ left: 24, right: 24 })

          Button({ type: ButtonType.Circle }) {
            Text('+')
              .fontSize(24)
              .fontColor('#999999')
          }
          .width(60)
          .height(60)
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#E0E0E0' })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 40 })

        // Preparation Steps
        Column() {
          Text('PREPARATION')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#CCCCCC')
            .margin({ bottom: 12 })

          // Step 1
          Row() {
            Stack() {
              Circle()
                .width(24)
                .height(24)
                .fill('#F5F5F5')
              Text('1')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .width(24)
            .height(24)

            Text('Boil fresh water to 95°C')
              .fontSize(14)
              .fontColor('#333333')
              .margin({ left: 12 })
              .layoutWeight(1)

            Text('✓')
              .fontSize(12)
              .fontColor('#EEEEEE')
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 8, bottom: 8 })

          Divider().color('#FAFAFA')

          // Step 2
          Row() {
            Stack() {
              Circle()
                .width(24)
                .height(24)
                .fill('#F5F5F5')
              Text('2')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .width(24)
            .height(24)

            Text('Add 1 tsp of loose leaf per cup')
              .fontSize(14)
              .fontColor('#333333')
              .margin({ left: 12 })
              .layoutWeight(1)

            Text('✓')
              .fontSize(12)
              .fontColor('#EEEEEE')
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 8, bottom: 8 })

          Divider().color('#FAFAFA')

          // Step 3
          Row() {
            Stack() {
              Circle()
                .width(24)
                .height(24)
                .fill('#F5F5F5')
              Text('3')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .width(24)
            .height(24)

            Text('Pour water and wait for timer')
              .fontSize(14)
              .fontColor('#333333')
              .margin({ left: 12 })
              .layoutWeight(1)

            Text('✓')
              .fontSize(12)
              .fontColor('#EEEEEE')
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 8, bottom: 8 })

          Divider().color('#FAFAFA')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 24 })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}