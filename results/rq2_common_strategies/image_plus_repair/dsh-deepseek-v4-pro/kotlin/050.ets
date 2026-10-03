const C_PRIMARY: string = '#1E3A8A'
const C_SECONDARY: string = '#2563EB'
const C_TERTIARY: string = '#60A5FA'
const C_BACKGROUND: string = '#F5F8FF'
const C_SURFACE: string = '#FFFFFF'
const C_SURFACE_VARIANT: string = '#E8EEFA'
const C_ON_SURFACE: string = '#0B1220'
const C_ON_PRIMARY: string = '#FFFFFF'

@Entry
@Component
struct FlightCheckIn {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  seatLabel(): string {
    if (this.selectedSeat === 0) {
      return '23C'
    }
    if (this.selectedSeat === 1) {
      return '11A'
    }
    return '2F'
  }

  @Builder
  seatSegment(label: string, index: number) {
    Button() {
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedSeat === index ? C_ON_PRIMARY : C_ON_SURFACE)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.selectedSeat === index ? C_PRIMARY : C_SURFACE_VARIANT)
    .borderRadius(8)
    .height(40)
    .layoutWeight(1)
    .onClick(() => {
      this.selectedSeat = index
    })
  }

  @Builder
  topBar() {
    Row() {
      Column()
        .width(22)
        .height(22)
        .borderRadius(11)
        .backgroundColor(C_PRIMARY)
      Text('Flight Check-in')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_SURFACE)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
      Column()
        .width(22)
        .height(22)
        .borderRadius(11)
        .backgroundColor(C_SECONDARY)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: 18, right: 18, top: 12, bottom: 12 })
  }

  build() {
    Stack() {
      Column() {
        this.topBar()
        Column({ space: 18 }) {
          Column({ space: 14 }) {
            Text('Passenger')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(C_ON_SURFACE)
            TextInput({ placeholder: 'Full name', text: this.name })
              .onChange((value: string) => {
                this.name = value
              })
              .width('100%')
              .backgroundColor(C_SURFACE_VARIANT)
              .borderRadius(12)
              .placeholderColor('#800B1220')
              .fontSize(14)
            Text('Booking Code')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(C_ON_SURFACE)
            TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
              .onChange((value: string) => {
                this.code = value
              })
              .width('100%')
              .backgroundColor(C_SURFACE_VARIANT)
              .borderRadius(12)
              .placeholderColor('#800B1220')
              .fontSize(14)
            Text('Seat Class')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(C_ON_SURFACE)
            Row({ space: 8 }) {
              this.seatSegment('Economy', 0)
              this.seatSegment('Premium', 1)
              this.seatSegment('Business', 2)
            }
            .width('100%')
          }
          .width('100%')
          .padding(18)
          .backgroundColor(C_SURFACE)
          .borderRadius(18)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 4 })

          Column({ space: 14 }) {
            Row() {
              Column({ space: 6 }) {
                Text('Flight')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_ON_SURFACE)
                Text('BL 213 • HND → CTS')
                  .fontSize(14)
                  .fontColor(C_ON_SURFACE)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              Column()
                .width(36)
                .height(36)
                .borderRadius(18)
                .backgroundColor(C_SECONDARY)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Row() {
              Column() {
                Text('Boarding')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_ON_SURFACE)
                Text('12:35')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_PRIMARY)
              }
              .alignItems(HorizontalAlign.Start)
              Column() {
                Text('Gate')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_ON_SURFACE)
                Text('A12')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_PRIMARY)
              }
              .alignItems(HorizontalAlign.Start)
              Column() {
                Text('Seat')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_ON_SURFACE)
                Text(this.seatLabel())
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(C_PRIMARY)
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Button() {
              Text('Confirm Check-in')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(C_ON_PRIMARY)
            }
            .type(ButtonType.Normal)
            .width('100%')
            .height(52)
            .backgroundColor(C_PRIMARY)
            .borderRadius(18)
            .onClick(() => {
              this.showDialog = true
            })
          }
          .width('100%')
          .padding(18)
          .backgroundColor(C_SURFACE)
          .borderRadius(18)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 4 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 18, right: 18, top: 14, bottom: 14 })
        .linearGradient({
          angle: 180,
          colors: [
            ['#4060A5FA', 0.0],
            [C_BACKGROUND, 0.5],
            ['#332563EB', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(C_BACKGROUND)

      if (this.showDialog) {
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')
            .onClick(() => {
              this.showDialog = false
            })
          Column({ space: 10 }) {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_ON_SURFACE)
            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor(C_ON_SURFACE)
            Button() {
              Text('Done')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(C_ON_PRIMARY)
            }
            .type(ButtonType.Normal)
            .width('100%')
            .height(40)
            .backgroundColor(C_SECONDARY)
            .borderRadius(12)
            .onClick(() => {
              this.showDialog = false
            })
          }
          .width('80%')
          .padding(18)
          .backgroundColor(C_SURFACE)
          .borderRadius(12)
          .shadow({ radius: 12, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: 6 })
        }
        .width('100%')
        .height('100%')
        .alignContent(Alignment.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}
