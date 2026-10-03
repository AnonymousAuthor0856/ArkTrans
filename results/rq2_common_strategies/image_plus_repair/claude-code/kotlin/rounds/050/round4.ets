const PRIMARY: string = '#FF1E3A8A'
const SECONDARY: string = '#FF2563EB'
const TERTIARY: string = '#FF60A5FA'
const BG: string = '#FFF5F8FF'
const SURFACE: string = '#FFFFFFFF'
const SURFACE_VARIANT: string = '#FFE8EEFA'
const BORDER_CLR: string = '#FFCBD5E1'
const ON_SURFACE: string = '#FF0B1220'
const ON_PRIMARY: string = '#FFFFFFFF'

@Entry
@Component
struct FlightCheckIn {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  build() {
    Stack() {
      Column() {
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(PRIMARY)
            .margin({ left: 18 })
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Circle({ width: 22, height: 22 })
            .fill(SECONDARY)
            .margin({ right: 18 })
        }
        .width('100%')
        .height(56)
        .backgroundColor(SURFACE)

        Column() {
          Column() {
            Text('Passenger')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(ON_SURFACE)
              .margin({ bottom: 14 })

            TextInput({ placeholder: 'Full name', text: this.name })
              .width('100%')
              .height(64)
              .backgroundColor(SURFACE_VARIANT)
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
              .fontColor(ON_SURFACE)
              .margin({ top: 14, bottom: 14 })

            TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
              .width('100%')
              .height(64)
              .backgroundColor(SURFACE_VARIANT)
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
              .fontColor(ON_SURFACE)
              .margin({ top: 14, bottom: 14 })

            Row() {
              ForEach(this.seatTabs, (item: string, index: number) => {
                Text(item)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedSeat === index ? ON_PRIMARY : ON_SURFACE)
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
                  .height(48)
                  .backgroundColor(this.selectedSeat === index ? PRIMARY : SURFACE_VARIANT)
                  .borderRadius(this.getSegmentRadius(index))
                  .onClick(() => {
                    this.selectedSeat = index
                  })
              }, (item: string) => item)
            }
            .width('100%')
            .borderRadius(24)
            .backgroundColor(SURFACE_VARIANT)
            .border({ width: 1, color: BORDER_CLR })
          }
          .width('100%')
          .padding(18)
          .backgroundColor(SURFACE)
          .borderRadius(18)
          .shadow({ radius: 8, color: '#29000000', offsetY: 4 })

          Column() {
            Row() {
              Column() {
                Text('Flight')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                Text('BL 213 • HND → CTS')
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(ON_SURFACE)
                  .margin({ top: 6 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Circle({ width: 36, height: 36 })
                .fill(SECONDARY)
            }
            .width('100%')

            Row() {
              Column() {
                Text('Boarding')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                Text('12:35')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PRIMARY)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Gate')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                Text('A12')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PRIMARY)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)

              Column() {
                Text('Seat')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                Text(this.getSeatNumber())
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PRIMARY)
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
              .fontColor(ON_PRIMARY)
              .backgroundColor(PRIMARY)
              .borderRadius(18)
              .margin({ top: 18 })
              .onClick(() => {
                this.showDialog = true
              })
          }
          .width('100%')
          .padding(18)
          .backgroundColor(SURFACE)
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
      .backgroundColor(BG)

      if (this.showDialog) {
        Column() {
          Column() {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE)
              .margin({ bottom: 12 })

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(ON_SURFACE)
              .margin({ bottom: 18 })

            Row() {
              Blank()
              Button('Done')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(ON_PRIMARY)
                .backgroundColor(SECONDARY)
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
          .backgroundColor(SURFACE)
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
