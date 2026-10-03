@Entry
@Component
struct FlightCheckIn {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private readonly primaryColor: string = '#FF1E3A8A'
  private readonly secondaryColor: string = '#FF2563EB'
  private readonly tertiaryColor: string = '#FF60A5FA'
  private readonly bgColor: string = '#FFF5F8FF'
  private readonly surfaceColor: string = '#FFFFFFFF'
  private readonly surfaceVariantColor: string = '#FFE8EEFA'
  private readonly borderColor: string = '#FFCBD5E1'
  private readonly onSurfaceColor: string = '#FF0B1220'
  private readonly onPrimaryColor: string = '#FFFFFFFF'

  build() {
    Stack() {
      Column() {
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(this.primaryColor)
            .margin({ left: 18 })
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.onSurfaceColor)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Circle({ width: 22, height: 22 })
            .fill(this.secondaryColor)
            .margin({ right: 18 })
        }
        .width('100%')
        .height(56)
        .backgroundColor(this.surfaceColor)

        Column() {
          Column() {
            Text('Passenger')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.onSurfaceColor)
              .margin({ bottom: 14 })

            TextInput({ placeholder: 'Full name', text: this.name })
              .width('100%')
              .height(64)
              .backgroundColor(this.surfaceVariantColor)
              .borderRadius(12)
              .type(InputType.Normal)
              .placeholderColor('#800B1220')
              .fontSize(14)
              .onChange((value: string) => {
                this.name = value
              })

            Text('Booking Code')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.onSurfaceColor)
              .margin({ top: 14, bottom: 14 })

            TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
              .width('100%')
              .height(64)
              .backgroundColor(this.surfaceVariantColor)
              .borderRadius(12)
              .type(InputType.Normal)
              .placeholderColor('#800B1220')
              .fontSize(14)
              .onChange((value: string) => {
                this.code = value
              })

            Text('Seat Class')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.onSurfaceColor)
              .margin({ top: 14, bottom: 14 })

            Row() {
              ForEach(this.seatTabs, (item: string, index: number) => {
                Text(item)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedSeat === index ? this.onPrimaryColor : this.onSurfaceColor)
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
                  .height(48)
                  .backgroundColor(this.selectedSeat === index ? this.primaryColor : this.surfaceVariantColor)
                  .borderRadius(this.getSegmentRadius(index))
                  .onClick(() => {
                    this.selectedSeat = index
                  })
              }, (item: string) => item)
            }
            .width('100%')
            .borderRadius(24)
            .backgroundColor(this.surfaceVariantColor)
            .border({ width: 1, color: this.outlineColor })
          }
          .width('100%')
          .padding(18)
          .backgroundColor(this.surfaceColor)
          .borderRadius(18)
          .shadow({ radius: 8, color: '#29000000', offsetY: 4 })

          Column() {
            Row() {
              Column() {
                Text('Flight')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSurfaceColor)
                Text('BL 213 • HND → CTS')
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(this.onSurfaceColor)
                  .margin({ top: 6 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Circle({ width: 36, height: 36 })
                .fill(this.secondaryColor)
            }
            .width('100%')

            Row() {
              Column() {
                Text('Boarding')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSurfaceColor)
                Text('12:35')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.primaryColor)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Gate')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSurfaceColor)
                Text('A12')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.primaryColor)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)

              Column() {
                Text('Seat')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSurfaceColor)
                Text(this.getSeatNumber())
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.primaryColor)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .margin({ top: 18 })

            Button('Confirm Check-in')
              .width('100%')
              .height(52)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onPrimaryColor)
              .backgroundColor(this.primaryColor)
              .borderRadius(18)
              .margin({ top: 18 })
              .onClick(() => {
                this.showDialog = true
              })
          }
          .width('100%')
          .padding(18)
          .backgroundColor(this.surfaceColor)
          .borderRadius(18)
          .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
          .margin({ top: 18 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 18, right: 18, top: 14, bottom: 14 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.bgColor)

      if (this.showDialog) {
        Column() {
          Column() {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurfaceColor)
              .margin({ bottom: 12 })

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(this.onSurfaceColor)
              .margin({ bottom: 18 })

            Row() {
              Blank()
              Button('Done')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onPrimaryColor)
                .backgroundColor(this.secondaryColor)
                .borderRadius(12)
                .height(36)
                .onClick(() => {
                  this.showDialog = false
                })
            }
            .width('100%')
          }
          .width('80%')
          .padding(18)
          .backgroundColor(this.surfaceColor)
          .borderRadius(12)
          .shadow({ radius: 8, color: '#40000000' })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.showDialog = false
        })
      }
    }
    .width('100%')
    .height('100%')
  }

  private getSegmentRadius(index: number): BorderRadiuses {
    const isFirst = index === 0
    const isLast = index === this.seatTabs.length - 1
    return {
      topLeft: isFirst ? 24 : 0,
      topRight: isLast ? 24 : 0,
      bottomLeft: isFirst ? 24 : 0,
      bottomRight: isLast ? 24 : 0
    }
  }

  private getSeatNumber(): string {
    if (this.selectedSeat === 0) return '23C'
    if (this.selectedSeat === 1) return '11A'
    return '2F'
  }
}
