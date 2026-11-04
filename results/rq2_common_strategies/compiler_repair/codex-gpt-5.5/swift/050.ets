@Entry
@Component
struct Index {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private seatNumber(index: number): string {
    if (index === 0) {
      return '23C'
    }
    if (index === 1) {
      return '11A'
    }
    return '2F'
  }

  @Builder
  SegmentButton(label: string, index: number) {
    Button(`${this.selectedSeat === index ? '✓ ' : ''}${label}`)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedSeat === index ? '#FFFFFF' : '#0B1220')
      .height(40)
      .layoutWeight(1)
      .backgroundColor(this.selectedSeat === index ? '#1E3A8A' : '#E8EEFA')
      .borderRadius(12)
      .onClick(() => {
        this.selectedSeat = index
      })
  }

  @Builder
  PassengerCard() {
    Column() {
      Text('Passenger')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .width('100%')

      TextInput({ placeholder: 'Full name', text: this.name })
        .fontSize(14)
        .fontColor('#0B1220')
        .placeholderColor('#800B1220')
        .width('100%')
        .height(48)
        .padding(14)
        .backgroundColor('#E8EEFA')
        .border({ width: 1, color: '#CBD5E1', radius: 12 })
        .margin({ top: 18 })
        .onChange((value: string) => {
          this.name = value
        })

      Text('Booking Code')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .width('100%')
        .margin({ top: 18 })

      TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
        .fontSize(14)
        .fontColor('#0B1220')
        .placeholderColor('#800B1220')
        .width('100%')
        .height(48)
        .padding(14)
        .backgroundColor('#E8EEFA')
        .border({ width: 1, color: '#CBD5E1', radius: 12 })
        .margin({ top: 18 })
        .onChange((value: string) => {
          this.code = value
        })

      Text('Seat Class')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .width('100%')
        .margin({ top: 18 })

      Row() {
        ForEach(this.seatTabs, (label: string, index: number) => {
          this.SegmentButton(label, index)
        }, (label: string) => label)
      }
      .width('100%')
      .border({ width: 1, color: '#CBD5E1', radius: 12 })
      .margin({ top: 18 })
    }
    .width('100%')
    .padding(26)
    .backgroundColor('#FFFFFF')
    .borderRadius(18)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }

  @Builder
  FlightDetailsCard() {
    Column() {
      Row() {
        Column() {
          Text('Flight')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .width('100%')
          Text('BL 213 • HND → CTS')
            .fontSize(14)
            .fontColor('#0B1220')
            .width('100%')
            .margin({ top: 6 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Circle()
          .width(36)
          .height(36)
          .fill('#2563EB')
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .alignItems(VerticalAlign.Center)

      Row() {
        Column() {
          Text('Boarding').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
          Text('12:35').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1E3A8A').margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text('Gate').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
          Text('A12').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1E3A8A').margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text('Seat').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
          Text(this.seatNumber(this.selectedSeat)).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1E3A8A').margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 14, bottom: 14 })

      Button('Confirm Check-in')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width('100%')
        .height(52)
        .backgroundColor('#1E3A8A')
        .borderRadius(18)
        .onClick(() => {
          this.showDialog = true
        })
    }
    .width('100%')
    .padding(18)
    .backgroundColor('#FFFFFF')
    .borderRadius(18)
    .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Circle()
            .width(22)
            .height(22)
            .fill('#1E3A8A')
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
          Circle()
            .width(22)
            .height(22)
            .fill('#2563EB')
        }
        .width('100%')
        .height(56)
        .padding({ left: 18, right: 18 })
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column() {
            this.PassengerCard()
            Column() {
              this.FlightDetailsCard()
            }
            .margin({ top: 18 })
          }
          .width('100%')
          .padding({ left: 18, right: 18, top: 14, bottom: 18 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      if (this.showDialog) {
        Column() {
          Text('Check-in Successful')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
          Text('Boarding pass is ready. Have a nice flight.')
            .fontSize(14)
            .fontColor('#0B1220')
            .textAlign(TextAlign.Center)
            .margin({ top: 12 })
          Button('Done')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .height(44)
            .width('100%')
            .backgroundColor('#1E3A8A')
            .borderRadius(12)
            .margin({ top: 16 })
            .onClick(() => {
              this.showDialog = false
            })
        }
        .width('80%')
        .padding(20)
        .backgroundColor('#FFFFFF')
        .borderRadius(18)
        .shadow({ radius: 12, color: '#33000000', offsetY: 6 })
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#4060A5FA', 0.0], ['#F5F8FF', 0.5], ['#332563EB', 1.0]]
    })
  }
}
