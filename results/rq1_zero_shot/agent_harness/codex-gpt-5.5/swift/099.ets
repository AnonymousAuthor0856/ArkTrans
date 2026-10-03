const MATCHA_GREEN: string = '#556B2F';
const MATCHA_BOWL: string = '#333333';
const MATCHA_LIQUID: string = '#8BBD52';
const MATCHA_BORDER: string = '#EEEEEE';

@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Stack() {
      Column() {
        Column() {
          Blank()
            .height(48)

          Text('MATCHA RITUAL')
            .fontSize(14)
            .letterSpacing(4)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)

          Blank()
            .height(8)

          Text('Ceremonial Grade')
            .fontSize(28)
            .fontWeight(FontWeight.Lighter)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Center)

        Column() {
          MatchaBowlCanvas()
            .width(160)
            .height(160)

          Blank()
            .height(40)

          Row() {
            Blank()
            InfoItem({ label: 'TEMP', value: '80°C' })
            Blank()
            InfoItem({ label: 'WATER', value: '70ml' })
            Blank()
            InfoItem({ label: 'BAMBOO', value: 'Whisk' })
            Blank()
          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Column() {
          StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })

          Blank()
            .height(12)

          StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })

          Blank()
            .height(32)

          Button() {
            Row({ space: 8 }) {
              Text('▶')
                .fontSize(20)
                .fontColor(Color.White)
              Text('START TIMER')
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(Color.White)
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
          }
          .height(56)
          .width('100%')
          .backgroundColor(MATCHA_GREEN)
          .borderRadius(28)

          Blank()
            .height(24)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .padding(24)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }
}

@Component
struct MatchaBowlCanvas {
  build() {
    Stack() {
      Column() {
        Row({ space: 18 }) {
          Rect().fill('#D0D0D0').width(4).height(28).borderRadius(2)
          Rect().fill('#D0D0D0').width(4).height(34).borderRadius(2)
          Rect().fill('#D0D0D0').width(4).height(28).borderRadius(2)
        }
        .opacity(0.5)
        .margin({ top: 16 })

        Blank()
          .height(18)

        Stack() {
          Ellipse()
            .fill(MATCHA_BOWL)
            .width(118)
            .height(78)
            .translate({ y: 18 })

          Ellipse()
            .fill(MATCHA_LIQUID)
            .width(96)
            .height(24)
            .translate({ y: -8 })

          Rect()
            .fill(Color.White)
            .width(126)
            .height(38)
            .translate({ y: -36 })
        }
        .width(140)
        .height(96)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(160)
    .height(160)
  }
}

@Component
struct InfoItem {
  @Prop label: string;
  @Prop value: string;

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#B0B0B0')

      Blank()
        .height(4)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  @Prop number: string;
  @Prop text: string;

  build() {
    Row() {
      Stack() {
        Circle()
          .fill('#F5F5F5')
          .width(32)
          .height(32)

        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)

      Blank()
        .width(16)

      Text(this.text)
        .fontSize(14)
        .fontColor('#4D4D4D')
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .border({ width: 1, color: MATCHA_BORDER })
    .borderRadius(12)
  }
}
