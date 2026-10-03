@Entry
@Component
struct FlightCheckin {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private getSeatText(): string {
    if (this.selectedSeat === 0) return '23C'
    if (this.selectedSeat === 1) return '11A'
    return '2F'
  }

  build() {
    Stack() {
      Column() {
        // Top bar
        Row() {
          Circle({ width: 22, height: 22 })
            .fill('#1E3A8A')
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Circle({ width: 22, height: 22 })
            .fill('#2563EB')
        }
        .width('100%')
        .padding({ left: 18, right: 18, top: 12, bottom: 12 })

        // Scrollable content
        Scroll() {
          Column() {
            // Passenger card
            Column() {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(600)
                .fontColor('#0B1220')

              TextInput({ placeholder: 'Full name', text: this.name })
                .width('100%')
                .placeholderColor('#0B122080')
                .backgroundColor('#E8EEFA')
                .borderRadius(12)
                .padding(12)
                .onChange((val: string) => { this.name = val })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(600)
                .fontColor('#0B1220')
                .margin({ top: 14 })

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .width('100%')
                .placeholderColor('#0B122080')
                .backgroundColor('#E8EEFA')
                .borderRadius(12)
                .padding(12)
                .onChange((val: string) => { this.code = val })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(600)
                .fontColor('#0B1220')
                .margin({ top: 14 })

              // Segmented buttons
              Row() {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Text(label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedSeat === index ? '#FFFFFF' : '#0B1220')
                    .textAlign(TextAlign.Center)
                    .width('100%')
                    .height('100%')
                    .backgroundColor(this.selectedSeat === index ? '#1E3A8A' : '#E8EEFA')
                    .onClick(() => { this.selectedSeat = index })
                }, (label: string) => label)
              }
              .width('100%')
              .height(40)
              .borderRadius(12)
              .clip(true)
            }
            .width('100%')
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(18)
            .shadow({ radius: 8, color: '#00000029', offsetY: 4 })

            // Flight card
            Column() {
              Row() {
                Column() {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#0B1220')
                    .margin({ top: 6 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Circle({ width: 36, height: 36 })
                  .fill('#2563EB')
              }
              .width('100%')

              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E3A8A')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column() {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E3A8A')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column() {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                  Text(this.getSeatText())
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E3A8A')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
              .margin({ top: 14 })

              Button('Confirm Check-in')
                .width('100%')
                .height(52)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .backgroundColor('#1E3A8A')
                .borderRadius(18)
                .margin({ top: 14 })
                .onClick(() => { this.showDialog = true })
            }
            .width('100%')
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(18)
            .shadow({ radius: 8, color: '#00000029', offsetY: 4 })
            .margin({ top: 18 })
          }
          .width('100%')
          .padding({ left: 18, right: 18, top: 14, bottom: 14 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .linearGradient(
        {
          angle: 180,
          colors: [['#60A5FA40', 0.0], ['#F5F8FF', 0.5], ['#2563EB33', 1.0]]
        }
      )

      // Dialog
      if (this.showDialog) {
        Column() {
          Column() {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#0B1220')
              .margin({ top: 12 })

            Row() {
              Blank()
              Button('Done')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .backgroundColor('#2563EB')
                .borderRadius(12)
                .height(36)
                .onClick(() => { this.showDialog = false })
            }
            .width('100%')
            .margin({ top: 18 })
          }
          .width('80%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(18)
          .shadow({ radius: 12, color: '#0000002E', offsetY: 6 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#00000055')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => { this.showDialog = false })
      }
    }
    .width('100%')
    .height('100%')
  }
}
