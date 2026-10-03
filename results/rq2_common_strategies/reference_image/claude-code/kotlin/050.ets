@Entry
@Component
struct FlightCheckIn {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private readonly primary: string = '#FF1E3A8A'
  private readonly secondary: string = '#FF2563EB'
  private readonly tertiary: string = '#FF60A5FA'
  private readonly background: string = '#FFF5F8FF'
  private readonly surface: string = '#FFFFFFFF'
  private readonly surfaceVariant: string = '#FFE8EEFA'
  private readonly outline: string = '#FFCBD5E1'
  private readonly onSurface: string = '#FF0B1220'
  private readonly onPrimary: string = '#FFFFFFFF'

  build() {
    Stack() {
      Column() {
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(this.primary)
            .margin({ left: 18 })
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Circle({ width: 22, height: 22 })
            .fill(this.secondary)
            .margin({ right: 18 })
        }
        .width('100%')
        .height(56)
        .backgroundColor(this.surface)

        Column() {
          Column() {
            Text('Passenger')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.onSurface)
              .margin({ bottom: 14 })

            TextInput({ placeholder: 'Full name', text: this.name })
              .width('100%')
              .height(64)
              .backgroundColor(this.surfaceVariant)
              .borderRadius(12)
              .type(InputType.Normal)
              .placeholderColor('#800B1220')
              .fontSize(14)
              .onChange((value: string) => {
                this.name = value
              })

            Text('Booking Code')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.onSurface)
              .margin({ top: 14, bottom: 14 })

            TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
              .width('100%')
              .height(64)
              .backgroundColor(this.surfaceVariant)
              .borderRadius(12)
              .type(InputType.Normal)
              .placeholderColor('#800B1220')
              .fontSize(14)
              .onChange((value: string) => {
                this.code = value
              })

            Text('Seat Class')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.onSurface)
              .margin({ top: 14, bottom: 14 })

            Row() {
              ForEach(this.seatTabs, (item: string, index: number) => {
                Text(item)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedSeat === index ? this.onPrimary : this.onSurface)
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
                  .height(48)
                  .backgroundColor(this.selectedSeat === index ? this.primary : this.surfaceVariant)
                  .borderRadius(this.getSegmentRadius(index))
                  .onClick(() => {
                    this.selectedSeat = index
                  })
              }, (item: string) => item)
            }
            .width('100%')
            .borderRadius(24)
            .backgroundColor(this.surfaceVariant)
            .border({ width: 1, color: this.outline })
          }
          .width('100%')
          .padding(18)
          .backgroundColor(this.surface)
          .borderRadius(18)
          .shadow({ radius: 8, color: '#29000000', offsetY: 4 })

          Column() {
            Row() {
              Column() {
                Text('Flight')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSurface)
                Text('BL 213 • HND → CTS')
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(this.onSurface)
                  .margin({ top: 6 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Circle({ width: 36, height: 36 })
                .fill(this.secondary)
            }
            .width('100%')

            Row() {
              Column() {
                Text('Boarding')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSurface)
                Text('12:35')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.primary)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Gate')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSurface)
                Text('A12')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.primary)
                  .margin({ top: 4 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)

              Column() {
                Text('Seat')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.onSurface)
                Text(this.getSeatNumber())
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.primary)
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
              .fontColor(this.onPrimary)
              .backgroundColor(this.primary)
              .borderRadius(18)
              .margin({ top: 18 })
              .onClick(() => {
                this.showDialog = true
              })
          }
          .width('100%')
          .padding(18)
          .backgroundColor(this.surface)
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
      .backgroundColor(this.background)

      if (this.showDialog) {
        Column() {
          Column() {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurface)
              .margin({ bottom: 12 })

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(this.onSurface)
              .margin({ bottom: 18 })

            Row() {
              Blank()
              Button('Done')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.onPrimary)
                .backgroundColor(this.secondary)
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
          .backgroundColor(this.surface)
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
