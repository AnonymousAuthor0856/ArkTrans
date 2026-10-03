@Entry
@Component
struct Index {
  @State name: string = ""
  @State code: string = ""
  @State showDialog: boolean = false
  @State selectedSeatIndex: number = 0

  private seatTabs: string[] = ['Economy', 'Business', 'First']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content ===
      Column({ space: 18 }) {
        // === Card 1: Passenger Info ===
        Column() {
          Column({ space: 14 }) {
            Text('Passenger')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')

            TextInput({ placeholder: 'Full name' })
              .width('100%')
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .height(48)
              .onChange((value: string) => {
                this.name = value
              })

            Text('Booking Code')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')

            TextInput({ placeholder: 'e.g. XY7ZK2' })
              .width('100%')
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .height(48)
              .onChange((value: string) => {
                this.code = value
              })

            Text('Seat Class')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')

            // Segmented Button Row Implementation
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(this.seatTabs, (label: string, index: number) => {
                Button(label)
                  .width(`${100 / this.seatTabs.length}%`)
                  .height(40)
                  .margin({ right: index < this.seatTabs.length - 1 ? 8 : 0 })
                  .backgroundColor(this.selectedSeatIndex === index ? '#2563EB' : '#F5F5F5')
                  .fontColor(this.selectedSeatIndex === index ? '#FFFFFF' : '#0B1220')
                  .borderRadius(8)
                  .onClick(() => {
                    this.selectedSeatIndex = index
                  })
              })
            }.width('100%')
          }
          .width('100%')
          .padding(18)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })
        .width('100%')

        // === Card 2: Flight Details ===
        Column() {
          Column({ space: 14 }) {
            // Flight Info Row
            Row() {
              Column({ space: 6 }) {
                Text('Flight')
                  .fontSize(14)
                  .fontColor('#0B1220')
                Text('BL 213 • HND → CTS')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#0B1220')
              }
              Blank()
              // Icon Placeholder
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
              }
              .width(36)
              .height(36)
              .backgroundColor('#2563EB')
              .borderRadius(18)
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')

            // Details Row (Boarding, Gate, Seat)
            Row() {
              Column({ space: 0 }) {
                Text('Boarding')
                  .fontSize(12)
                  .fontColor('#0B1220')
                Text('12:35')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1E3A8A')
              }
              
              Column({ space: 0 }) {
                Text('Gate')
                  .fontSize(12)
                  .fontColor('#0B1220')
                Text('A12')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1E3A8A')
              }
              
              Column({ space: 0 }) {
                Text('Seat')
                  .fontSize(12)
                  .fontColor('#0B1220')
                Text(this.getSeatNumber())
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1E3A8A')
              }
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .width('100%')

            // Confirm Button
            Button('Confirm Check-in')
              .width('100%')
              .height(52)
              .backgroundColor('#2563EB')
              .fontColor('#FFFFFF')
              .borderRadius(12)
              .onClick(() => {
                this.showDialog = true
              })
          }
          .width('100%')
          .padding(18)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({ left: 18, right: 18, top: 14, bottom: 14 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#FFD6CC', 0], ['#FFFFFF', 0.5], ['#E0F2FE', 1]]
      })

      // === Top App Bar Simulation ===
      Row() {
        Blank()
        Text('Flight Check-in')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
        Blank()
        
        // Left Icon Placeholder
        Stack({ alignContent: Alignment.Center }) {
          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
        }
        .width(22)
        .height(22)
        .backgroundColor('#2563EB')
        .borderRadius(11)
        .margin({ left: 18 })

        // Right Icon Placeholder
        Stack({ alignContent: Alignment.Center }) {
          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
        }
        .width(22)
        .height(22)
        .backgroundColor('#FF9800')
        .borderRadius(11)
        .margin({ right: 18 })
      }
      .width('100%')
      .height(60)
      .position({ x: 0, y: 0 })
      .backgroundColor('#FFFFFF')
      .opacity(0.9)

      // === AlertDialog ===
      if (this.showDialog) {
        Stack() {
          // Backdrop
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#000000')
            .opacity(0.5)
            .onClick(() => {
              this.showDialog = false
            })

          // Dialog Content
          Column() {
            Text('Check-in Successful')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
              .margin({ bottom: 8 })
            
            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor('#0B1220')
              .margin({ bottom: 24 })
            
            Button('Done')
              .width('100%')
              .height(44)
              .backgroundColor('#FF9800')
              .fontColor('#FFFFFF')
              .borderRadius(8)
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width('80%')
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height('100%')
        .alignContent(Alignment.Center)
      }
    }
    .width('100%')
    .height('100%')
  }

  getSeatNumber(): string {
    if (this.selectedSeatIndex === 0) return "23C"
    if (this.selectedSeatIndex === 1) return "11A"
    return "2F"
  }
}