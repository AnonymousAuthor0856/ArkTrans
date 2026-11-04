@Entry
@Component
struct Index {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']

  @Builder
  Station(index: number) {
    Column() {
      if (index % 2 === 1) {
        Blank().height(110)
      }
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#00FFFF')
        Circle()
          .width(12)
          .height(12)
          .fill('#0A0A1A')
      }
      if (index % 2 === 0) {
        Blank().height(110)
      }
    }
    .height(230)
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  MetroLine() {
    Stack() {
      Rect()
        .width('100%')
        .height(6)
        .radius(3)
        .linearGradient({ angle: 90, colors: [['#00B4FF', 0.0], ['#00FFFF', 1.0]] })
        .rotate({ angle: -18 })
      Row() {
        ForEach(this.stations, (_station: string, index: number) => {
          this.Station(index)
        }, (station: string) => station)
      }
      .width('100%')
      .height(230)
    }
    .width('100%')
    .height(260)
    .padding(10)
    .backgroundColor('#1E1E4A')
    .borderRadius(22)
  }

  @Builder
  DeparturesCard() {
    Column() {
      Text('Next Departures')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#00B4FF')
        .width('100%')

      ForEach(this.departures, (departure: string) => {
        Row() {
          Text(departure)
            .fontSize(14)
            .fontColor('#FFFFFF')
            .layoutWeight(1)
          Text('On Time')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00FFAA')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 6 })
      }, (departure: string) => departure)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#141436')
    .borderRadius(22)
    .shadow({ radius: 8, color: '#262E2E5C', offsetY: 4 })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Routes').fontSize(14).fontColor('#00B4FF')
      Blank()
      Text('Planner').fontSize(14).fontColor('#FFFFFF')
      Blank()
      Text('Tickets').fontSize(14).fontColor('#FFFFFF')
      Blank()
      Text('Profile').fontSize(14).fontColor('#FFFFFF')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#141436')
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .width('100%')
          .padding({ left: 16, right: 16 })

        Column() {
          this.MetroLine()
        }
        .padding({ left: 16, right: 16 })
        .margin({ top: 16 })

        Column() {
          this.DeparturesCard()
        }
        .padding({ left: 16, right: 16 })
        .margin({ top: 16 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: 16, bottom: 56 })
      .linearGradient({
        angle: 180,
        colors: [['#0A0A1A', 0.0], ['#1E1E4A', 0.5], ['#0A0A1A', 1.0]]
      })

      Column() {
        this.BottomBar()
      }
      .width('100%')
      .alignSelf(ItemAlign.End)

      Button('+')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0A0A1A')
        .width(56)
        .height(56)
        .backgroundColor('#00FFFF')
        .borderRadius(28)
        .margin({ right: 16, bottom: 72 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0A0A1A')
  }
}
