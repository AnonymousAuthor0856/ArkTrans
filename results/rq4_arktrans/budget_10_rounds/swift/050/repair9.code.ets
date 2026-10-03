@Entry
@Component
struct Index {
  @State name: string = ''
  @State code: string = ''
  @State selectedIndex: number = 0
  @State showDialog: boolean = false

  private seatLabels: string[] = ['Economy', 'Premium', 'Business']

  build() {
    Stack() {
      // === ZStack (Background) ===
      Stack() {
        // Background Gradient
        Column() {
          Text('')
        }
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [
            ['#2563EB', 0.2],
            ['#FFFFFF', 0.4],
            ['#1E3A8A', 0.2]
          ]
        })

        // === VStack (Main Content) ===
        Column() {
          // === HStack (Header) ===
          Row() {
            Circle().width(22).height(22).fill('#1E3A8A').margin({ left: 12 })
            Blank()
            Text('Flight Check-in')
              .fontColor('#0B1220')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
            Blank()
            Circle().width(22).height(22).fill('#2563EB').margin({ right: 12 })
          }
          .width('100%')
          .height(56)
          .margin({ bottom: 12 })

          // === ScrollView ===
          Scroll() {
            Column() {
              // === Card 1: Passenger Details ===
              Column() {
                // Section: Name
                Text('Passenger')
                  .fontColor('#0B1220')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .alignSelf(ItemAlign.Start)
                  .margin({ top: 24, bottom: 12 })

                TextInput({ placeholder: 'Full name' })
                  .type(InputType.Normal)
                  .backgroundColor('#E8EEFA')
                  .borderRadius(12)
                  .padding({ left: 16, right: 16, top: 12, bottom: 12 })
                  .width('100%')
                  .height(48)
                  .onChange((value: string) => { this.name = value })

                // Section: Booking Code
                Text('Booking Code')
                  .fontColor('#0B1220')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .alignSelf(ItemAlign.Start)
                  .margin({ top: 24, bottom: 12 })

                TextInput({ placeholder: 'e.g. XY7ZK2' })
                  .type(InputType.Normal)
                  .backgroundColor('#E8EEFA')
                  .borderRadius(12)
                  .padding({ left: 16, right: 16, top: 12, bottom: 12 })
                  .width('100%')
                  .height(48)
                  .onChange((value: string) => { this.code = value })

                // Section: Seat Class
                Text('Seat Class')
                  .fontColor('#0B1220')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .alignSelf(ItemAlign.Start)
                  .margin({ top: 24, bottom: 12 })

                // Segmented Control
                Row() {
                  ForEach(this.seatLabels, (label: string, index: number) => {
                    Button() {
                      Row() {
                        if (this.selectedIndex === index) {
                          Text('✓').fontColor('#FFFFFF').margin({ right: 4 }).fontSize(16)
                        }
                        Text(label).fontColor(this.selectedIndex === index ? '#FFFFFF' : '#0B1220').fontSize(16)
                      }
                      .justifyContent(FlexAlign.Center)
                      .alignItems(VerticalAlign.Center)
                    }
                    .width(`${100 / this.seatLabels.length}%`)
                    .height(48)
                    .backgroundColor(this.selectedIndex === index ? '#1E3A8A' : '#E8EEFA')
                    .borderWidth(0)
                    .onClick(() => { this.selectedIndex = index })
                  }, (item: string) => item)
                }
                .width('100%')
                .borderRadius(12)
                .margin({ bottom: 24 })
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
              .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
              .padding({ left: 24, right: 24 })

              // === Card 2: Flight Info ===
              Column() {
                // Header Row
                Row() {
                  Column() {
                    Text('Flight')
                      .fontColor('#0B1220')
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                    Text('BL 213 • HND → CTS')
                      .fontColor('#0B1220')
                      .fontSize(14)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .justifyContent(FlexAlign.Start)

                  Blank()

                  Circle()
                    .width(36)
                    .height(36)
                    .fill('#2563EB')
                }
                .width('100%')
                .margin({ top: 24, bottom: 12 })

                // Details Grid
                Row() {
                  Column() {
                    Text('Boarding')
                      .fontColor('#0B1220')
                      .fontSize(12)
                    Text('12:35')
                      .fontColor('#1E3A8A')
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Column() {
                    Text('Gate')
                      .fontColor('#0B1220')
                      .fontSize(12)
                    Text('A12')
                      .fontColor('#1E3A8A')
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Column() {
                    Text('Seat')
                      .fontColor('#0B1220')
                      .fontSize(12)
                    Text('23C')
                      .fontColor('#1E3A8A')
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .margin({ bottom: 24 })

                // Action Button
                Button('Confirm Check-in')
                  .width('100%')
                  .height(56)
                  .backgroundColor('#1E3A8A')
                  .borderRadius(16)
                  .margin({ bottom: 24 })
                  .onClick(() => { this.showDialog = true })
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
              .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
              .padding({ left: 24, right: 24 })
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })
            .gap(24)
          }
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
      }
      
      // Dialog Overlay
      if (this.showDialog) {
        Column() {
          Column() {
            Text("Success")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 })
            Text("Your check-in is confirmed.")
              .fontSize(16)
              .margin({ bottom: 20 })
            Button("Done")
              .width('100%')
              .onClick(() => { this.showDialog = false })
          }
          .width('80%')
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(16)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#80000000')
        .onClick(() => { this.showDialog = false })
      }
    }
    .width('100%')
    .height('100%')
  }
}