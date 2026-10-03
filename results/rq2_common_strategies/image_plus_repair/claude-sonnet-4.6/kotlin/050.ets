@Entry
@Component
struct Index {
  @State nameValue: string = ''
  @State codeValue: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  readonly primaryColor: string = '#1E3A8A'
  readonly secondaryColor: string = '#2563EB'
  readonly tertiaryColor: string = '#60A5FA'
  readonly bgColor: string = '#F5F8FF'
  readonly surfaceColor: string = '#FFFFFF'
  readonly surfaceVariantColor: string = '#E8EEFA'
  readonly outlineColorVal: string = '#CBD5E1'
  readonly onSurfaceColor: string = '#0B1220'
  readonly onPrimaryColor: string = '#FFFFFF'
  readonly seatTabs: string[] = ['Economy', 'Premium', 'Business']

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
        .height(60)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(this.surfaceColor)

        // Main Content
        Scroll() {
          Column({ space: 18 }) {
            // Passenger Card
            Column({ space: 14 }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.onSurfaceColor)
                .width('100%')

              TextInput({ placeholder: 'Full name', text: this.nameValue })
                .placeholderColor('#800B1220')
                .backgroundColor(this.surfaceVariantColor)
                .borderRadius(12)
                .width('100%')
                .height(52)
                .fontSize(14)
                .fontColor(this.onSurfaceColor)
                .onChange((val: string) => {
                  this.nameValue = val
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.onSurfaceColor)
                .width('100%')

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.codeValue })
                .placeholderColor('#800B1220')
                .backgroundColor(this.surfaceVariantColor)
                .borderRadius(12)
                .width('100%')
                .height(52)
                .fontSize(14)
                .fontColor(this.onSurfaceColor)
                .onChange((val: string) => {
                  this.codeValue = val
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.onSurfaceColor)
                .width('100%')

              // Segmented Button Row
              Row() {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Button() {
                    Row({ space: 4 }) {
                      if (this.selectedSeat === index) {
                        Text('✓')
                          .fontSize(12)
                          .fontColor(this.onPrimaryColor)
                      }
                      Text(label)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.selectedSeat === index ? this.onPrimaryColor : this.onSurfaceColor)
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .layoutWeight(1)
                  .height(44)
                  .backgroundColor(this.selectedSeat === index ? this.primaryColor : this.surfaceVariantColor)
                  .borderRadius(index === 0 ? 22 : index === this.seatTabs.length - 1 ? 22 : 0)
                  .onClick(() => {
                    this.selectedSeat = index
                  })
                })
              }
              .width('100%')
              .height(44)
              .borderRadius(22)
              .clip(true)
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(18)
            .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })

            // Flight Info Card
            Column({ space: 14 }) {
              Row() {
                Column({ space: 6 }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.onSurfaceColor)

                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontColor(this.onSurfaceColor)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Circle({ width: 36, height: 36 })
                  .fill(this.secondaryColor)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

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
                }
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
                }
                .alignItems(HorizontalAlign.Start)

                Column() {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.onSurfaceColor)

                  Text(this.getSeatLabel())
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.primaryColor)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Button('Confirm Check-in')
                .width('100%')
                .height(52)
                .backgroundColor(this.primaryColor)
                .fontColor(this.onPrimaryColor)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .borderRadius(18)
                .onClick(() => {
                  this.showDialog = true
                })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceColor)
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
          colors: [
            ['#40A5FA', 0.0],
            ['#F5F8FF', 0.5],
            ['#332563EB', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')

      // Dialog
      if (this.showDialog) {
        Column() {
          Column({ space: 16 }) {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurfaceColor)
              .width('100%')

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor(this.onSurfaceColor)
              .width('100%')

            Row() {
              Button('Done')
                .backgroundColor(this.secondaryColor)
                .fontColor(this.onPrimaryColor)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .borderRadius(12)
                .padding({ left: 24, right: 24, top: 10, bottom: 10 })
                .onClick(() => {
                  this.showDialog = false
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('85%')
          .padding(24)
          .backgroundColor(this.surfaceColor)
          .borderRadius(18)
          .shadow({ radius: 12, color: '#40000000', offsetX: 0, offsetY: 6 })
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
}