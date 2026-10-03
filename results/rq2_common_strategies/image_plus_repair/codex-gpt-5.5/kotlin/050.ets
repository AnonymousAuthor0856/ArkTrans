@Entry
@Component
struct FlightCheckInPage {
  @State passengerName: string = ''
  @State bookingCode: string = ''
  @State selectedSeat: number = 0

  private readonly primary: string = '#1E3A8A'
  private readonly secondary: string = '#2563EB'
  private readonly tertiary: string = '#60A5FA'
  private readonly pageBackground: string = '#F5F8FF'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#E8EEFA'
  private readonly borderLineColor: string = '#CBD5E1'
  private readonly onSurface: string = '#0B1220'
  private readonly mutedText: string = '#7D8594'
  private readonly seatTabs: string[] = ['Economy', 'Premium', 'Business']

  @Builder
  Header() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Flight Check-in')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .textAlign(TextAlign.Center)

      Row() {
        Circle()
          .width(22)
          .height(22)
          .fill(this.primary)

        Blank()

        Circle()
          .width(22)
          .height(22)
          .fill(this.secondary)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 22, right: 22 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(78)
    .backgroundColor(this.surface)
  }

  @Builder
  LabeledInput(label: string, placeholder: string, fieldKind: number) {
    Column({ space: 14 }) {
      Text(label)
        .fontSize(20)
        .fontWeight(600)
        .fontColor(this.onSurface)
        .width('100%')

      Column() {
        TextInput({ placeholder: placeholder, text: fieldKind === 0 ? this.passengerName : this.bookingCode })
          .height(56)
          .width('100%')
          .fontSize(16)
          .fontColor(this.onSurface)
          .placeholderColor(this.mutedText)
          .backgroundColor(this.surfaceVariant)
          .borderRadius(12)
          .padding({ left: 16, right: 16 })
          .caretColor(this.primary)
          .onChange((value: string) => {
            if (fieldKind === 0) {
              this.passengerName = value
            } else {
              this.bookingCode = value
            }
          })

        Divider()
          .color(this.borderLineColor)
          .strokeWidth(1)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  SeatSegment(label: string, index: number) {
    Row() {
      if (this.selectedSeat === index) {
        Text('✓')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .margin({ right: 8 })
      }

      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedSeat === index ? '#FFFFFF' : this.onSurface)
        .maxLines(1)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .layoutWeight(1)
    .height(40)
    .backgroundColor(this.selectedSeat === index ? this.primary : this.surfaceVariant)
    .border({
      width: { left: index === 0 ? 0 : 1, right: index === 2 ? 0 : 1 },
      color: this.borderLineColor
    })
    .onClick(() => {
      this.selectedSeat = index
    })
  }

  @Builder
  SeatClassPicker() {
    Column({ space: 14 }) {
      Text('Seat Class')
        .fontSize(20)
        .fontWeight(600)
        .fontColor(this.onSurface)
        .width('100%')

      Row() {
        ForEach(this.seatTabs, (label: string, index: number) => {
          this.SeatSegment(label, index)
        })
      }
      .width('100%')
      .height(40)
      .clip(true)
      .borderRadius(20)
      .border({ width: 1, color: this.borderLineColor })
      .backgroundColor(this.surfaceVariant)
    }
    .width('100%')
  }

  @Builder
  PassengerCard() {
    Column({ space: 18 }) {
      this.LabeledInput('Passenger', 'Full name', 0)

      this.LabeledInput('Booking Code', 'e.g. XY7ZK2', 1)

      this.SeatClassPicker()
    }
    .width('100%')
    .padding(18)
    .backgroundColor(this.surface)
    .borderRadius(18)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  private seatNumber(): string {
    if (this.selectedSeat === 0) {
      return '23C'
    }
    if (this.selectedSeat === 1) {
      return '11A'
    }
    return '2F'
  }

  @Builder
  DetailItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurface)

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.primary)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  FlightCard() {
    Column({ space: 14 }) {
      Row() {
        Column({ space: 6 }) {
          Text('Flight')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)

          Text('BL 213 • HND → CTS')
            .fontSize(14)
            .fontColor(this.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Circle()
          .width(36)
          .height(36)
          .fill(this.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        this.DetailItem('Boarding', '12:35')
        this.DetailItem('Gate', 'A12')
        this.DetailItem('Seat', this.seatNumber())
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Button() {
        Text('Confirm Check-in')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }
        .width('100%')
        .height(52)
        .backgroundColor(this.primary)
        .borderRadius(18)
        .margin({ top: 4 })
        .onClick(() => {
          AlertDialog.show({
            title: 'Check-in Successful',
            message: 'Boarding pass is ready. Have a nice flight.',
            autoCancel: true,
            alignment: DialogAlignment.Center,
            primaryButton: {
              value: 'Done',
              action: () => {
              }
            }
          })
        })
    }
    .width('100%')
    .padding(18)
    .backgroundColor(this.surface)
    .borderRadius(18)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  build() {
    Column() {
      this.Header()

      Column({ space: 18 }) {
        this.PassengerCard()
        this.FlightCard()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 18, right: 18, top: 14, bottom: 14 })
      .linearGradient({
        angle: 180,
        colors: [
          ['#4060A5FA', 0.0],
          [this.pageBackground, 0.5],
          ['#332563EB', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackground)
  }
}
