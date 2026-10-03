@Entry
@Component
struct FlightCheckinApp {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private seatNumber(index: number): string {
    if (index === 0) return '23C'
    if (index === 1) return '11A'
    return '2F'
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Main content
      Column({ space: 0 }) {
        // Header
        Row({ space: 0 }) {
          Circle()
            .width(22)
            .height(22)
            .fill('#1E3A8A')
            .margin({ left: 18 })
          Blank()
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#0B1220')
          Blank()
          Circle()
            .width(22)
            .height(22)
            .fill('#2563EB')
            .margin({ right: 18 })
        }
        .width('100%')
        .height(56)
        .padding({ bottom: 14 })

        // Scrollable content using List
        List({ space: 18 }) {
          // Passenger & Booking Card
          ListItem() {
            Column({ space: 18 }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#0B1220')

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(14)
                .padding(14)
                .backgroundColor('#E8EEFA')
                .borderRadius(12)
                .foregroundColor('#0B1220')
                .border({ width: 1, color: '#CBD5E1' })
                .onChange((value: string) => {
                  this.name = value
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#0B1220')

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(14)
                .padding(14)
                .backgroundColor('#E8EEFA')
                .borderRadius(12)
                .foregroundColor('#0B1220')
                .border({ width: 1, color: '#CBD5E1' })
                .onChange((value: string) => {
                  this.code = value
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#0B1220')

              // Segmented control
              Row({ space: 0 }) {
                ForEach(['Economy', 'Premium', 'Business'], (label: string, index: number) => {
                  Button() {
                    Row({ space: 6 }) {
                      if (this.selectedSeat === index) {
                        Text('✓')
                          .fontSize(14)
                          .fontWeight(FontWeight.Medium)
                          .foregroundColor('#FFFFFF')
                      }
                      Text(label)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .foregroundColor(this.selectedSeat === index ? '#FFFFFF' : '#0B1220')
                    }
                    .width('100%')
                    .height(40)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                  }
                  .width('33.33%')
                  .height(40)
                  .backgroundColor(this.selectedSeat === index ? '#1E3A8A' : '#E8EEFA')
                  .border({
                    width: 1,
                    color: '#CBD5E1',
                    radius: {
                      topLeft: index === 0 ? 12 : 0,
                      topRight: index === 2 ? 12 : 0,
                      bottomLeft: index === 0 ? 12 : 0,
                      bottomRight: index === 2 ? 12 : 0
                    }
                  })
                  .onClick(() => {
                    this.selectedSeat = index
                  })
                })
              }
              .width('100%')
              .border({ width: 1, color: '#CBD5E1', radius: 12 })
            }
            .padding(26)
            .backgroundColor('#FFFFFF')
            .borderRadius(18)
            .shadow({ radius: 8, color: '#16000000', offsetX: 0, offsetY: 4 })
          }

          // Flight Details Card
          ListItem() {
            Column({ space: 14 }) {
              // Flight row
              Row({ space: 10 }) {
                Column({ space: 6 }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#0B1220')
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .foregroundColor('#0B1220')
                }
                Blank()
                Circle()
                  .width(36)
                  .height(36)
                  .fill('#2563EB')
              }
              .padding(14)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)

              // Boarding, Gate, Seat
              Row({ space: 0 }) {
                Column({ space: 0 }) {
                  Text('Boarding')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#0B1220')
                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#1E3A8A')
                }
                Blank()
                Column({ space: 0 }) {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#0B1220')
                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#1E3A8A')
                }
                Blank()
                Column({ space: 0 }) {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#0B1220')
                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#1E3A8A')
                }
              }
              .width('100%')
              .padding({ top: 14, bottom: 14 })

              // Confirm button
              Button() {
                Text('Confirm Check-in')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .textAlign(TextAlign.Center)
              }
              .width('100%')
              .height(52)
              .backgroundColor('#1E3A8A')
              .foregroundColor('#FFFFFF')
              .borderRadius(18)
              .onClick(() => {
                this.showDialog = true
              })
            }
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(18)
            .shadow({ radius: 8, color: '#16000000', offsetX: 0, offsetY: 4 })
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 18, right: 18, top: 14, bottom: 14 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F8FF') // Background color for the whole screen

      // Dialog overlay
      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          Column({ space: 14 }) {
            Text('Check-in Successful')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#0B1220')
            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .foregroundColor('#0B1220')
              .textAlign(TextAlign.Center)
            Button() {
              Text('Done')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FFFFFF')
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(44)
            .backgroundColor('#1E3A8A')
            .borderRadius(12)
            .onClick(() => {
              this.showDialog = false
            })
          }
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(18)
          .shadow({ radius: 12, color: '#1F000000', offsetX: 0, offsetY: 6 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
      }
    }
    .width('100%')
    .height('100%')
  }
}