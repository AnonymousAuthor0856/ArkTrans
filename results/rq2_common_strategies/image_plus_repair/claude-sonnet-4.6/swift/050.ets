@Entry
@Component
struct FlightCheckinApp {
  @State private name: string = ''
  @State private code: string = ''
  @State private selectedSeat: number = 0
  @State private showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private seatNumber(index: number): string {
    if (index === 0) return '23C'
    else if (index === 1) return '11A'
    else return '2F'
  }

  build() {
    Stack() {
      // Background gradient simulation
      Column() {
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          ['#3F60A5FA', 0.0],
          ['#FFF5F8FF', 0.5],
          ['#332563EB', 1.0]
        ]
      })

      Column({ space: 0 }) {
        // Header
        Row() {
          Circle()
            .width(22)
            .height(22)
            .fill('#1E3A8A')
            .margin({ left: 18 })

          Blank()

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')

          Blank()

          Circle()
            .width(22)
            .height(22)
            .fill('#2563EB')
            .margin({ right: 18 })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: 14 })

        // Scrollable content
        Scroll() {
          Column({ space: 18 }) {
            // Passenger & Booking Card
            Column({ space: 18 }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(14)
                .fontColor('#0B1220')
                .placeholderColor('#94A3B8')
                .backgroundColor('#E8EEFA')
                .borderRadius(12)
                .border({ width: 1, color: '#CBD5E1', radius: 12 })
                .padding(14)
                .width('100%')
                .onChange((value: string) => {
                  this.name = value
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(14)
                .fontColor('#0B1220')
                .placeholderColor('#94A3B8')
                .backgroundColor('#E8EEFA')
                .borderRadius(12)
                .border({ width: 1, color: '#CBD5E1', radius: 12 })
                .padding(14)
                .width('100%')
                .onChange((value: string) => {
                  this.code = value
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .alignSelf(ItemAlign.Start)

              // Segmented Control
              Row({ space: 0 }) {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Button() {
                    Row({ space: 6 }) {
                      if (this.selectedSeat === index) {
                        Text('✓')
                          .fontSize(14)
                          .fontWeight(FontWeight.Bold)
                          .fontColor('#FFFFFF')
                      }
                      Text(label)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.selectedSeat === index ? '#FFFFFF' : '#0B1220')
                    }
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                  }
                  .width('33.33%')
                  .height(40)
                  .backgroundColor(this.selectedSeat === index ? '#1E3A8A' : '#E8EEFA')
                  .borderRadius(this.getSegmentRadius(index))
                  .onClick(() => {
                    this.selectedSeat = index
                  })
                  .type(ButtonType.Normal)
                })
              }
              .width('100%')
              .border({ width: 1, color: '#CBD5E1', radius: 12 })
              .borderRadius(12)
              .clip(true)
            }
            .padding(26)
            .backgroundColor('#FFFFFF')
            .borderRadius(18)
            .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            // Flight Details Card
            Column({ space: 14 }) {
              // Flight info row
              Row() {
                Column({ space: 6 }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontColor('#0B1220')
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

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

              // Boarding, Gate, Seat row
              Row() {
                Column({ space: 4 }) {
                  Text('Boarding')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E3A8A')
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column({ space: 4 }) {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E3A8A')
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column({ space: 4 }) {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E3A8A')
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding({ top: 14, bottom: 14 })

              // Confirm Button
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
                .type(ButtonType.Normal)
            }
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(18)
            .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .padding({ left: 18, right: 18, top: 14, bottom: 14 })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Dialog overlay
      if (this.showDialog) {
        Column() {
          Column({ space: 16 }) {
            Text('Check-in Successful')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor('#0B1220')
              .textAlign(TextAlign.Center)

            Button('Done')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .width('100%')
              .height(44)
              .backgroundColor('#1E3A8A')
              .borderRadius(12)
              .onClick(() => {
                this.showDialog = false
              })
              .type(ButtonType.Normal)
          }
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(18)
          .width('80%')
          .shadow({ radius: 12, color: '#33000000', offsetX: 0, offsetY: 6 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#66000000')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }

  private getSegmentRadius(index: number): BorderRadiuses {
    if (index === 0) {
      return { topLeft: 12, bottomLeft: 12, topRight: 0, bottomRight: 0 }
    } else if (index === this.seatTabs.length - 1) {
      return { topLeft: 0, bottomLeft: 0, topRight: 12, bottomRight: 12 }
    } else {
      return { topLeft: 0, bottomLeft: 0, topRight: 0, bottomRight: 0 }
    }
  }
}