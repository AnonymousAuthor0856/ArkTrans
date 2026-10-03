interface FlightCheckinColors {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  ink: string
  muted: string
}

@Entry
@Component
struct FlightCheckin {
  private readonly colors: FlightCheckinColors = {
    primary: '#1E3A8A',
    secondary: '#2563EB',
    tertiary: '#60A5FA',
    background: '#F5F8FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E8EEFA',
    outline: '#CBD5E1',
    ink: '#0B1220',
    muted: '#B6BFCE'
  }

  @State passenger: string = ''
  @State bookingCode: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private seatNumber(): string {
    if (this.selectedSeat === 1) {
      return '11A'
    }
    if (this.selectedSeat === 2) {
      return '2F'
    }
    return '23C'
  }

  @Builder
  private field(placeholder: string, value: string, onChange: (value: string) => void) {
    TextInput({ placeholder: placeholder, text: value })
      .width('100%')
      .height(64)
      .fontSize(14)
      .fontColor(this.colors.ink)
      .placeholderColor(this.colors.muted)
      .padding({ left: 14, right: 14 })
      .backgroundColor(this.colors.surfaceVariant)
      .borderRadius(13)
      .border({ width: 1, color: this.colors.outline })
      .onChange(onChange)
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Circle().width(22).height(22).fill(this.colors.primary)
          Blank().layoutWeight(1)
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colors.ink)
          Blank().layoutWeight(1)
          Circle().width(22).height(22).fill(this.colors.secondary)
        }
        .width('100%')
        .height(70)
        .padding({ left: 18, right: 18 })

        Scroll() {
          Column({ space: 18 }) {
            Column({ space: 18 }) {
              Text('Passenger')
                .width('100%')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.ink)

              this.field('Full name', this.passenger, (value: string) => { this.passenger = value })

              Text('Booking Code')
                .width('100%')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.ink)

              this.field('e.g. XY7ZK2', this.bookingCode, (value: string) => { this.bookingCode = value })

              Text('Seat Class')
                .width('100%')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.ink)

              Row({ space: 0 }) {
                ForEach(['Economy', 'Premium', 'Business'], (label: string, index: number) => {
                  Button() {
                    Row({ space: 6 }) {
                      if (this.selectedSeat === index) {
                        Text('✓').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
                      }
                      Text(label)
                        .fontSize(12)
                        .fontColor(this.selectedSeat === index ? '#FFFFFF' : this.colors.ink)
                    }
                    .justifyContent(FlexAlign.Center)
                    .width('100%')
                    .height(40)
                  }
                  .layoutWeight(1)
                  .height(40)
                  .padding(0)
                  .backgroundColor(this.selectedSeat === index ? this.colors.primary : this.colors.surfaceVariant)
                  .borderRadius(index === 0 || index === 2 ? 12 : 0)
                  .onClick(() => { this.selectedSeat = index })
                })
              }
              .width('100%')
              .height(42)
              .border({ width: 1, color: this.colors.outline })
              .borderRadius(13)
              .clip(true)
            }
            .width('100%')
            .padding(26)
            .backgroundColor(this.colors.surface)
            .borderRadius(18)
            .shadow({ radius: 8, color: '#00000029', offsetX: 0, offsetY: 4 })

            Column({ space: 14 }) {
              Row() {
                Column({ space: 6 }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontColor(this.colors.ink)
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontColor(this.colors.ink)
                }
                Blank().layoutWeight(1)
                Circle().width(36).height(36).fill(this.colors.secondary)
              }
              .width('100%')
              .padding(14)
              .backgroundColor(this.colors.surface)
              .borderRadius(12)

              Row() {
                Column({ space: 2 }) {
                  Text('Boarding').fontSize(12).fontColor(this.colors.ink)
                  Text('12:35').fontSize(16).fontColor(this.colors.primary)
                }
                Blank().layoutWeight(1)
                Column({ space: 2 }) {
                  Text('Gate').fontSize(12).fontColor(this.colors.ink)
                  Text('A12').fontSize(16).fontColor(this.colors.primary)
                }
                Blank().layoutWeight(1)
                Column({ space: 2 }) {
                  Text('Seat').fontSize(12).fontColor(this.colors.ink)
                  Text(this.seatNumber()).fontSize(16).fontColor(this.colors.primary)
                }
              }
              .width('100%')
              .padding({ top: 14, bottom: 14 })

              Button() {
                Text('Confirm Check-in')
                  .fontSize(16)
                  .fontColor('#FFFFFF')
                  .width('100%')
                  .textAlign(TextAlign.Center)
              }
              .width('100%')
              .height(52)
              .backgroundColor(this.colors.primary)
              .borderRadius(18)
              .onClick(() => { this.showDialog = true })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.colors.surface)
            .borderRadius(18)
            .shadow({ radius: 8, color: '#00000029', offsetX: 0, offsetY: 4 })
          }
          .width('100%')
          .padding({ left: 18, right: 18, top: 14, bottom: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .linearGradient({
      angle: 180,
      colors: [['#A9D1FA40', 0], [this.colors.background, 0.52], ['#2563EB33', 1]]
    })
    .bindContentCover(this.showDialog, this.dialogBuilder)
  }

  @Builder
  private dialogBuilder() {
    Column({ space: 14 }) {
      Text('Check-in Successful')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.ink)
      Text('Boarding pass is ready. Have a nice flight.')
        .fontSize(14)
        .fontColor(this.colors.ink)
      Button('Done')
        .width('100%')
        .height(44)
        .backgroundColor(this.colors.primary)
        .fontColor('#FFFFFF')
        .onClick(() => { this.showDialog = false })
    }
    .width('82%')
    .padding(22)
    .backgroundColor(this.colors.surface)
    .borderRadius(16)
    .justifyContent(FlexAlign.Center)
  }
}
