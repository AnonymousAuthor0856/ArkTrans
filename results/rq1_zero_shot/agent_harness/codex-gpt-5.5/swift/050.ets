@Entry
@Component
struct RootScreen {
  @State private name: string = '';
  @State private code: string = '';
  @State private selectedSeat: number = 0;
  @State private showDialog: boolean = false;

  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  private seatNumber(index: number): string {
    if (index === 0) {
      return '23C';
    }
    if (index === 1) {
      return '11A';
    }
    return '2F';
  }

  @Builder
  private SegmentButton(label: string, index: number) {
    Row() {
      if (this.selectedSeat === index) {
        Text('✓')
          .fontSize(14)
          .fontColor(Color.White)
          .margin({ right: 6 })
      }
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedSeat === index ? Color.White : '#1E3A8A')
    }
    .justifyContent(FlexAlign.Center)
    .height(40)
    .layoutWeight(1)
    .borderRadius(14)
    .backgroundColor(this.selectedSeat === index ? '#1E3A8A' : Color.Transparent)
    .onClick(() => {
      this.selectedSeat = index;
    })
  }

  @Builder
  private SegmentedControl() {
    Row({ space: 6 }) {
      ForEach(this.seatTabs, (item: string, index: number) => {
        this.SegmentButton(item, index)
      })
    }
    .padding(6)
    .width('100%')
    .backgroundColor('#E8EEFA')
    .borderRadius(18)
  }

  @Builder
  private PassengerCard() {
    Column({ space: 14 }) {
      Text('Passenger')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .width('100%')
      TextInput({ placeholder: 'Full name', text: this.name })
        .height(48)
        .fontSize(15)
        .backgroundColor('#F5F8FF')
        .borderRadius(14)
        .border({ width: 1, color: '#CBD5E1' })
        .onChange((value: string) => {
          this.name = value;
        })

      Text('Booking Code')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .width('100%')
      TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
        .height(48)
        .fontSize(15)
        .backgroundColor('#F5F8FF')
        .borderRadius(14)
        .border({ width: 1, color: '#CBD5E1' })
        .onChange((value: string) => {
          this.code = value;
        })

      Text('Seat Class')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .width('100%')
      this.SegmentedControl()
    }
    .padding(18)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(18)
    .shadow({ radius: 14, color: '#1E3A8A18', offsetX: 0, offsetY: 6 })
  }

  @Builder
  private FlightDetailsCard() {
    Column({ space: 18 }) {
      Row() {
        Column({ space: 4 }) {
          Text('Flight')
            .fontSize(13)
            .fontColor('#64748B')
          Text('BL 213 • HND → CTS')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Circle()
          .width(36)
          .height(36)
          .fill('#2563EB')
      }
      .width('100%')

      Row() {
        this.DetailColumn('Boarding', '12:35')
        this.DetailColumn('Gate', 'A12')
        this.DetailColumn('Seat', this.seatNumber(this.selectedSeat))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Button('Confirm Check-in')
        .width('100%')
        .height(50)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor('#1E3A8A')
        .borderRadius(16)
        .onClick(() => {
          this.showDialog = true;
        })
    }
    .padding(18)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(18)
    .shadow({ radius: 14, color: '#1E3A8A18', offsetX: 0, offsetY: 6 })
  }

  @Builder
  private DetailColumn(label: string, value: string) {
    Column({ space: 6 }) {
      Text(label)
        .fontSize(12)
        .fontColor('#64748B')
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }

  @Builder
  private DialogOverlay() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill('#00000055')
      Column({ space: 14 }) {
        Text('Check-in Successful')
          .fontSize(21)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
        Text('Boarding pass is ready. Have a nice flight.')
          .fontSize(15)
          .fontColor('#475569')
          .textAlign(TextAlign.Center)
        Button('Done')
          .height(44)
          .width('100%')
          .fontColor(Color.White)
          .backgroundColor('#2563EB')
          .borderRadius(14)
          .onClick(() => {
            this.showDialog = false;
          })
      }
      .padding(22)
      .width('82%')
      .backgroundColor('#FFFFFF')
      .borderRadius(20)
    }
    .width('100%')
    .height('100%')
  }

  build() {
    Stack() {
      Column({ space: 16 }) {
        Row() {
          Circle()
            .width(22)
            .height(22)
            .fill('#1E3A8A')
          Text('Flight Check-in')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Circle()
            .width(22)
            .height(22)
            .fill('#2563EB')
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 18 })

        Scroll() {
          Column({ space: 16 }) {
            this.PassengerCard()
            this.FlightDetailsCard()
          }
          .padding({ left: 20, right: 20, bottom: 24 })
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F8FF')

      if (this.showDialog) {
        this.DialogOverlay()
      }
    }
    .width('100%')
    .height('100%')
  }
}
