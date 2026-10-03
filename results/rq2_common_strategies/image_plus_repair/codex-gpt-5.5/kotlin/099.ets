const MATCHA_GREEN: string = '#556B2F';
const BOWL_CHARCOAL: string = '#333333';
const MATCHA_LIQUID: string = '#8BBD52';
const PRIMARY_TEXT: string = '#111111';
const SECONDARY_TEXT: string = '#4A4A4A';
const CARD_BORDER: string = '#EEEEEE';

@Entry
@Component
struct MainPage {
  @State private timerStarted: boolean = false;

  build() {
    Column() {
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(4)
          .fontColor('#929292')
          .margin({ top: 46 })

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Normal)
          .fontColor(PRIMARY_TEXT)
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        MatchaBowl()

        Row() {
          this.InfoItem('TEMP', '80°C')
          this.InfoItem('WATER', '70ml')
          this.InfoItem('BAMBOO', 'Whisk')
        }
        .width('100%')
        .margin({ top: 38 })
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        this.StepCard('01', 'Sift 2g of matcha powder.')
        Blank().height(12)
        this.StepCard('02', 'Add hot water. Whisk in \'M\' shape.')

        Button() {
          Row() {
            Polygon()
              .points([[0, 0], [0, 22], [17, 11]])
              .fill('#FFFFFF')
              .width(17)
              .height(22)

            Text(this.timerStarted ? 'TIMER RUNNING' : 'START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .margin({ left: 14 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(56)
        .margin({ top: 32, bottom: 24 })
        .backgroundColor(MATCHA_GREEN)
        .borderRadius(28)
        .stateEffect(true)
        .onClick(() => {
          this.timerStarted = !this.timerStarted;
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 48, right: 48 })
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#C7C7C7')

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(PRIMARY_TEXT)
        .margin({ top: 14 })
    }
    .width(100)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: string, content: string) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(64)
          .height(64)
          .fill('#F5F5F5')

        Text(number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_TEXT)
      }
      .width(64)
      .height(64)

      Text(content)
        .fontSize(14)
        .fontColor(SECONDARY_TEXT)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ left: 16 })
        .layoutWeight(1)
    }
    .width('100%')
    .height(126)
    .padding({ left: 30, right: 20 })
    .alignItems(VerticalAlign.Center)
    .border({
      width: 1,
      color: CARD_BORDER,
      radius: 12
    })
  }
}

@Component
struct MatchaBowl {
  build() {
    Column() {
      Row() {
        Blank()
          .width(4)
          .height(48)
          .backgroundColor('#D9D9D9')
          .borderRadius(2)
          .margin({ right: 28 })

        Blank()
          .width(4)
          .height(48)
          .backgroundColor('#D9D9D9')
          .borderRadius(2)

        Blank()
          .width(4)
          .height(48)
          .backgroundColor('#D9D9D9')
          .borderRadius(2)
          .margin({ left: 28 })
      }
      .height(76)
      .alignItems(VerticalAlign.Bottom)

      Stack() {
        Row()
          .width(160)
          .height(160)
          .backgroundColor(BOWL_CHARCOAL)
          .borderRadius({
            topLeft: 0,
            topRight: 0,
            bottomLeft: 80,
            bottomRight: 80
          })

        Circle()
          .width(128)
          .height(32)
          .fill(MATCHA_LIQUID)
          .position({ x: 16, y: 6 })
      }
      .width(160)
      .height(160)
    }
    .width(220)
    .height(236)
    .margin({ top: 38 })
    .alignItems(HorizontalAlign.Center)
  }
}
