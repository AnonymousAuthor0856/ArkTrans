@Entry
@Component
struct Index {
  @State passengerName: string = ''
  @State bookingCode: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  readonly seatTabs: string[] = ['Economy', 'Premium', 'Business']

  readonly colorPrimary: string = '#1E3A8A'
  readonly colorSecondary: string = '#2563EB'
  readonly colorTertiary: string = '#60A5FA'
  readonly colorBackground: string = '#F5F8FF'
  readonly colorSurface: string = '#FFFFFF'
  readonly colorSurfaceVariant: string = '#E8EEFA'
  readonly colorOutline: string = '#CBD5E1'
  readonly colorOnSurface: string = '#0B1220'
  readonly colorOnPrimary: string = '#FFFFFF'
  readonly colorOnSecondary: string = '#FFFFFF'

  getSeatLabel(): string {
    if (this.selectedSeat === 0) return '23C'
    if (this.selectedSeat === 1) return '11A'
    return '2F'
  }

  build() {
    Stack() {
      Column() {
        // Top App Bar
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(this.colorPrimary)
            .margin({ left: 18 })

          Text('Flight Check-in')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colorOnSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Circle({ width: 22, height: 22 })
            .fill(this.colorSecondary)
            .margin({ right: 18 })
        }
        .width('100%')
        .height(56)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(this.colorSurface)

        // Main Content
        Scroll() {
          Column({ space: 18 }) {
            // Passenger Card
            Column({ space: 14 }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSurface)

              TextInput({ placeholder: 'Full name', text: this.passengerName })
                .width('100%')
                .backgroundColor(this.colorSurfaceVariant)
                .borderRadius(12)
                .fontSize(14)
                .fontColor(this.colorOnSurface)
                .placeholderColor('#800B1220')
                .onChange((val: string) => {
                  this.passengerName = val
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSurface)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.bookingCode })
                .width('100%')
                .backgroundColor(this.colorSurfaceVariant)
                .borderRadius(12)
                .fontSize(14)
                .fontColor(this.colorOnSurface)
                .placeholderColor('#800B1220')
                .onChange((val: string) => {
                  this.bookingCode = val
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSurface)

              Row() {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Text(label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedSeat === index ? this.colorOnPrimary : this.colorOnSurface)
                    .backgroundColor(this.selectedSeat === index ? this.colorPrimary : this.colorSurfaceVariant)
                    .layoutWeight(1)
                    .height(36)
                    .textAlign(TextAlign.Center)
                    .borderRadius(index === 0 ? 8 : index === this.seatTabs.length - 1 ? 8 : 0)
                    .onClick(() => {
                      this.selectedSeat = index
                    })
                })
              }
              .width('100%')
              .borderRadius(8)
              .clip(true)
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.colorSurface)
            .borderRadius(18)
            .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })

            // Flight Info Card
            Column({ space: 14 }) {
              Row() {
                Column({ space: 6 }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorOnSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontColor(this.colorOnSurface)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Circle({ width: 36, height: 36 })
                  .fill(this.colorSecondary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorOnSurface)
                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorPrimary)
                }
                .alignItems(HorizontalAlign.Start)

                Column() {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorOnSurface)
                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorPrimary)
                }
                .alignItems(HorizontalAlign.Start)

                Column() {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorOnSurface)
                  Text(this.getSeatLabel())
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorPrimary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Button('Confirm Check-in')
                .width('100%')
                .height(52)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnPrimary)
                .backgroundColor(this.colorPrimary)
                .borderRadius(18)
                .onClick(() => {
                  this.showDialog = true
                })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.colorSurface)
            .borderRadius(18)
            .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
          }
          .width('100%')
          .padding({ left: 18, right: 18, top: 14, bottom: 14 })
        }
        .layoutWeight(1)
        .width('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#40A5FA', 0.0], ['#F5F8FF', 0.5], ['#332563EB', 1.0]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.colorBackground)

      // Dialog
      if (this.showDialog) {
        Column() {
          Column({ space: 12 }) {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorOnSurface)

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor(this.colorOnSurface)

            Row() {
              Button('Done')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorOnSecondary)
                .backgroundColor(this.colorSecondary)
                .borderRadius(12)
                .onClick(() => {
                  this.showDialog = false
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('80%')
          .padding(24)
          .backgroundColor(this.colorSurface)
          .borderRadius(18)
          .shadow({ radius: 12, color: '#40000000', offsetX: 0, offsetY: 6 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#80000000')
        .onClick(() => {
          this.showDialog = false
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}