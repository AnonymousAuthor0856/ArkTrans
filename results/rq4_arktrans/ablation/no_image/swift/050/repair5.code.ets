import { AlertDialog, CustomDialogController, ButtonOptions } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State name: string = ''
  @State code: string = ''
  @State selectedIndex: number = 0
  @State showDialog: boolean = false

  private seatLabels: string[] = ['Economy', 'Business', 'First']
  private dialogController: CustomDialogController | null = null

  aboutToAppear() {
    this.dialogController = new CustomDialogController({
      builder: DialogContent(),
      alignment: DialogAlignment.Center,
      offset: { dx: 0, dy: -50 },
      autoCancel: true
    })
  }

  build() {
    Column() {
      Stack() {
        // Background Gradient
        Column() {
          Blank()
        }
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [
            ['rgba(30, 58, 138, 0.25)', 0],
            ['#FFFFFF', 0.5],
            ['rgba(37, 99, 235, 0.1)', 1]
          ]
        })

        // Main Content Column
        Column() {
          // Header Row
          Row() {
            Circle()
              .width(22)
              .height(22)
              .fill('#1E3A8A')
              .margin({ left: 12 })

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
              .margin({ right: 12 })
          }
          .width('100%')
          .height(56)
          .margin({ bottom: 12 })

          // Scrollable Content
          Scroll() {
            Column() {
              // Passenger Info Card
              Column() {
                Text('Passenger')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .margin({ bottom: 8 })

                TextInput({ placeholder: 'Full name' })
                  .type(InputType.Normal)
                  .text(this.name)
                  .onChange((value: string) => {
                    this.name = value
                  })
                  .backgroundColor('#E8EEFA')
                  .borderRadius(8)
                  .padding(8)
                  .fontSize(14)
                  .fontColor('#0B1220')
                  .overlay(
                    new RectShape()
                      .stroke(Color('#CBD5E1'))
                      .strokeWidth(1)
                      .cornerRadius(8)
                  )
                  .margin({ bottom: 16 })

                Text('Booking Code')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .margin({ bottom: 8 })

                TextInput({ placeholder: 'e.g. XY7ZK2' })
                  .type(InputType.Normal)
                  .text(this.code)
                  .onChange((value: string) => {
                    this.code = value
                  })
                  .backgroundColor('#E8EEFA')
                  .borderRadius(8)
                  .padding(8)
                  .fontSize(14)
                  .fontColor('#0B1220')
                  .overlay(
                    new RectShape()
                      .stroke(Color('#CBD5E1'))
                      .strokeWidth(1)
                      .cornerRadius(8)
                  )
                  .margin({ bottom: 16 })

                Text('Seat Class')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .margin({ bottom: 8 })

                Row() {
                  ForEach(this.seatLabels, (label: string, index: number) => {
                    Button(label)
                      .backgroundColor(this.selectedIndex === index ? '#1E3A8A' : '#E8EEFA')
                      .fontColor(this.selectedIndex === index ? '#FFFFFF' : '#0B1220')
                      .borderRadius(8)
                      .margin({ right: 8 })
                      .onClick(() => {
                        this.selectedIndex = index
                      })
                  }, (item: string) => item)
                }
                .width('100%')
                .justifyContent(FlexAlign.Start)
              }
              .width('100%')
              .padding(24)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.1)' })
              .margin({ bottom: 16 })

              // Flight Details Card
              Column() {
                Row() {
                  Column() {
                    Text('Flight')
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#0B1220')
                    
                    Text('BL 213 • HND → CTS')
                      .fontSize(14)
                      .fontColor('#0B1220')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Circle()
                    .width(36)
                    .height(36)
                    .fill('#2563EB')
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#F8FAFC')
                .borderRadius(12)
                .margin({ bottom: 16 })

                Row() {
                  Column() {
                    Text('Boarding')
                      .fontSize(12)
                      .fontColor('#0B1220')
                    
                    Text('12:35')
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#1E3A8A')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Column() {
                    Text('Gate')
                      .fontSize(12)
                      .fontColor('#0B1220')
                    
                    Text('A12')
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#1E3A8A')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Column() {
                    Text('Seat')
                      .fontSize(12)
                      .fontColor('#0B1220')
                    
                    Text('12A')
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#1E3A8A')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .padding({ top: 12, bottom: 12 })

                Button('Check In Now')
                  .width('100%')
                  .height(48)
                  .backgroundColor('#1E3A8A')
                  .fontColor('#FFFFFF')
                  .borderRadius(8)
                  .onClick(() => {
                    if (this.dialogController) {
                      this.dialogController.open()
                    }
                  })
              }
              .width('100%')
              .padding(24)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.1)' })
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .padding({ top: 56 }) // Offset for header

      }.width('100%').height('100%')
    }
  }
}

@Component
struct DialogContent {
  build() {
    Column() {
      Text('Success')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 10 })
      
      Text('Your check-in was successful.')
        .fontSize(16)
        .margin({ bottom: 20 })

      Button('Done')
        .width('100%')
        .onClick(() => {
          getContext(this).getHostDialogController()?.close()
        })
    }
    .width('80%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}