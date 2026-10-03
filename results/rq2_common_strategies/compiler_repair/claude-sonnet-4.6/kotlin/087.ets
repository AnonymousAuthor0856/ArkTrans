@Entry
@Component
struct TeaBrewingScreen {
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
              .fontSize(20)
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
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Tea Selection Card
        Row() {
          Stack() {
            Circle()
              .width(60)
              .height(60)
              .fill('#EFEBE9')

            Column() {
              Circle()
                .width(30)
                .height(30)
                .fill('transparent')
                .stroke('#6D4C41')
                .strokeWidth(2)
              Line()
                .width(2)
                .height(15)
                .backgroundColor('#6D4C41')
                .margin({ top: -22 })
            }
            .alignItems(HorizontalAlign.Center)
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
          .margin({ left: 16 })
          .layoutWeight(1)

          Text('♥')
            .fontSize(20)
            .fontColor('#FFCDD2')
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FAFAFA')
        .borderRadius(24)
        .border({ width: 1, color: '#EEEEEE' })
        .alignItems(VerticalAlign.Center)
        .margin({ top: 32 })

        // Timer Display
        Stack({ alignContent: Alignment.Center }) {
          // Background circle ring
          Circle()
            .width(220)
            .height(220)
            .fill('transparent')
            .stroke('#F5F5F5')
            .strokeWidth(12)

          // Progress arc using Shape
          Shape() {
            Path()
              .commands('M 110 10 A 100 100 0 1 1 9.9 143.3')
          }
          .width(220)
          .height(220)
          .stroke('#6D4C41')
          .strokeWidth(12)
          .fill('transparent')
          .strokeLineCap(LineCapStyle.Round)

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
              .fontSize(20)
              .fontColor('#999999')
          }
          .width(60)
          .height(60)
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#E0E0E0' })

          Button() {
            Row() {
              Text('▶')
                .fontSize(16)
                .fontColor('#FFFFFF')
                .margin({ right: 8 })
              Text('Start')
                .fontSize(16)
                .fontColor('#FFFFFF')
            }
          }
          .width(120)
          .height(60)
          .backgroundColor('#6D4C41')
          .borderRadius(24)
          .margin({ left: 24, right: 24 })

          Button({ type: ButtonType.Circle }) {
            Text('+')
              .fontSize(24)
              .fontColor('#999999')
          }
          .width(60)
          .height(60)
          .backgroundColor('#FFFFFF')
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

          StepItemComponent({ step: '1', text: 'Boil fresh water to 95°C' })
          StepItemComponent({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
          StepItemComponent({ step: '3', text: 'Pour water and wait for timer' })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 32 })
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct StepItemComponent {
  @Prop step: string
  @Prop text: string

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(24)
            .height(24)
            .fill('#F5F5F5')
          Text(this.step)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .width(24)
        .height(24)

        Text(this.text)
          .fontSize(14)
          .fontColor('#333333')
          .margin({ left: 12 })
          .layoutWeight(1)

        Text('✓')
          .fontSize(14)
          .fontColor('#EEEEEE')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ top: 8, bottom: 8 })

      Divider()
        .color('#FAFAFA')
        .strokeWidth(1)
    }
    .width('100%')
  }
}