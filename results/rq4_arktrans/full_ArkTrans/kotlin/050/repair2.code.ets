@Entry
@Component
struct Index {
  @State name: string = ""
  @State code: string = ""
  @State showDialog: boolean = false
  @State selectedSeatIndex: number = 0

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Background Column ===
      Column({ space: 18 }) {
        // === Card 1: Passenger Info ===
        Column() {
          Column({ space: 14 }) {
            Text('Passenger').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#0B1220')
            
            TextInput({ placeholder: 'Full name' })
              .placeholderColor('#9CA3AF')
              .backgroundColor('#E5E7EB')
              .borderRadius(16)
              .height(56)
              .padding({ left: 16, right: 16 })
              .onChange((value: string) => { this.name = value })

            Text('Booking Code').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#0B1220')
            
            TextInput({ placeholder: 'e.g. XY7ZK2' })
              .placeholderColor('#9CA3AF')
              .backgroundColor('#E5E7EB')
              .borderRadius(16)
              .height(56)
              .padding({ left: 16, right: 16 })
              .onChange((value: string) => { this.code = value })

            Text('Seat Class').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#0B1220')
            
            // Segmented Button Row
            Row({ space: 1 }) {
              ForEach(this.seatTabs, (label: string, index: number) => {
                Button(label)
                  .width('33%')
                  .height(48)
                  .backgroundColor(index === this.selectedSeatIndex ? '#1E3A8A' : '#E5E7EB')
                  .fontColor(index === this.selectedSeatIndex ? '#FFFFFF' : '#0B1220')
                  .borderRadius(index === 0 ? [24, 0, 0, 24] as BorderRadiuses : (index === 2 ? [0, 24, 24, 0] as BorderRadiuses : 0))
                  .onClick(() => { this.selectedSeatIndex = index })
              })
            }.width('100%')
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1A000000' })

        // === Card 2: Flight Details ===
        Column() {
          Column({ space: 14 }) {
            Row({ space: 0 }) {
              Column({ space: 6 }) {
                Text('Flight').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                Text('BL 213 • HND → CTS').fontSize(16).fontColor('#0B1220')
              }
              Blank()
              Circle({ width: 36, height: 36 }).fill('#2563EB')
            }.width('100%')

            Divider().color('#E5E7EB').margin({ bottom: 10 })

            Row({ space: 0 }) {
              Column({ space: 4 }) {
                Text('Boarding').fontSize(14).fontColor('#6B7280')
                Text('12:35').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#1E3A8A')
              }
              Blank()
              Column({ space: 4 }) {
                Text('Gate').fontSize(14).fontColor('#6B7280')
                Text('A12').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#1E3A8A')
              }
              Blank()
              Column({ space: 4 }) {
                Text('Seat').fontSize(14).fontColor('#6B7280')
                Text('23C').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#1E3A8A')
              }
            }.width('100%')

            Button('Confirm Check-in')
              .width('100%')
              .height(52)
              .backgroundColor('#1E3A8A')
              .fontColor('#FFFFFF')
              .borderRadius(24)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .onClick(() => { this.showDialog = true })
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1A000000' })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 18, right: 18, top: 14, bottom: 14 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#BFDBFE', 0], ['#F3F4F6', 0.5], ['#DBEAFE', 1]]
      })

      // === Top App Bar ===
      Row({ space: 0 }) {
        Circle({ width: 22, height: 22 }).fill('#1E3A8A')
        Blank()
        Text('Flight Check-in')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
        Blank()
        Circle({ width: 22, height: 22 }).fill('#2563EB')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 18, right: 18 })

      // === Dialog Overlay ===
      if (this.showDialog) {
        Column() {
          Column() {
            Text('Check-in Successful')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
              .margin({ bottom: 8 })
            
            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor('#6B7280')
              .textAlign(TextAlign.Center)
              .margin({ bottom: 24 })

            Button('Done')
              .width('100%')
              .height(44)
              .backgroundColor('#2563EB')
              .fontColor('#FFFFFF')
              .borderRadius(12)
              .onClick(() => { this.showDialog = false })
          }
          .width('80%')
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .padding(24)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.5)')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}