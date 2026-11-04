class FlightColors {
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#2563EB';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F5F8FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E8EEFA';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onSurface: string = '#0B1220';
}

@Entry
@Component
struct Index {
  @State name: string = '';
  @State code: string = '';
  @State selectedSeat: number = 0;
  @State showDialog: boolean = false;
  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  private currentSeat(): string {
    if (this.selectedSeat === 0) {
      return '23C';
    }
    if (this.selectedSeat === 1) {
      return '11A';
    }
    return '2F';
  }

  @Builder
  TopBar() {
    Row() {
      Circle()
        .width(22)
        .height(22)
        .fill(FlightColors.primary)

      Text('Flight Check-in')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(FlightColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Circle()
        .width(22)
        .height(22)
        .fill(FlightColors.secondary)
    }
    .width('100%')
    .height(64)
    .padding({ left: 18, right: 18 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(FlightColors.surface)
  }

  @Builder
  Field(label: string, placeholder: string, value: string, field: string) {
    Column() {
      Text(label)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(FlightColors.onSurface)
        .width('100%')

      TextInput({ placeholder: placeholder, text: value })
        .width('100%')
        .height(52)
        .fontSize(16)
        .fontColor(FlightColors.onSurface)
        .placeholderColor('#800B1220')
        .backgroundColor(FlightColors.surfaceVariant)
        .borderRadius(12)
        .border({ width: 1, color: FlightColors.outline })
        .margin({ top: 10 })
        .onChange((text: string) => {
          if (field === 'name') {
            this.name = text;
          } else {
            this.code = text;
          }
        })
    }
    .width('100%')
  }

  @Builder
  PassengerCard() {
    Column() {
      this.Field('Passenger', 'Full name', this.name, 'name')
      Column() {
        this.Field('Booking Code', 'e.g. XY7ZK2', this.code, 'code')
      }
      .margin({ top: 14 })

      Text('Seat Class')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(FlightColors.onSurface)
        .width('100%')
        .margin({ top: 14, bottom: 10 })

      Row() {
        ForEach(this.seatTabs, (label: string, index: number) => {
          Button(label)
            .height(42)
            .fontSize(12)
            .fontColor(this.selectedSeat === index ? FlightColors.onPrimary : FlightColors.onSurface)
            .backgroundColor(this.selectedSeat === index ? FlightColors.primary : FlightColors.surfaceVariant)
            .borderRadius(12)
            .layoutWeight(1)
            .margin({ right: index < 2 ? 8 : 0 })
            .onClick(() => {
              this.selectedSeat = index;
            })
        }, (label: string) => label)
      }
      .width('100%')
    }
    .width('100%')
    .padding(18)
    .backgroundColor(FlightColors.surface)
    .borderRadius(18)
    .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  InfoColumn(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(FlightColors.onSurface)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(FlightColors.primary)
        .margin({ top: 4 })
    }
  }

  @Builder
  FlightCard() {
    Column() {
      Row() {
        Column() {
          Text('Flight')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(FlightColors.onSurface)
          Text('BL 213  HND -> CTS')
            .fontSize(14)
            .fontColor(FlightColors.onSurface)
            .margin({ top: 6 })
        }
        .layoutWeight(1)

        Circle()
          .width(36)
          .height(36)
          .fill(FlightColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        this.InfoColumn('Boarding', '12:35')
        this.InfoColumn('Gate', 'A12')
        this.InfoColumn('Seat', this.currentSeat())
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 18 })

      Button('Confirm Check-in')
        .width('100%')
        .height(52)
        .fontSize(16)
        .fontColor(FlightColors.onPrimary)
        .backgroundColor(FlightColors.primary)
        .borderRadius(18)
        .margin({ top: 18 })
        .onClick(() => {
          this.showDialog = true;
        })
    }
    .width('100%')
    .padding(18)
    .backgroundColor(FlightColors.surface)
    .borderRadius(18)
    .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  SuccessDialog() {
    if (this.showDialog) {
      Column() {
        Text('Check-in Successful')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(FlightColors.onSurface)
          .width('100%')
        Text('Boarding pass is ready. Have a nice flight.')
          .fontSize(14)
          .fontColor(FlightColors.onSurface)
          .width('100%')
          .margin({ top: 12 })
        Button('Done')
          .fontSize(12)
          .fontColor(FlightColors.onSecondary)
          .backgroundColor(FlightColors.secondary)
          .borderRadius(12)
          .alignSelf(ItemAlign.End)
          .margin({ top: 18 })
          .onClick(() => {
            this.showDialog = false;
          })
      }
      .width('82%')
      .padding(20)
      .backgroundColor(FlightColors.surface)
      .borderRadius(18)
      .shadow({ radius: 12, color: '#33000000', offsetX: 0, offsetY: 6 })
    }
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()
        Column() {
          this.PassengerCard()
          Column() {
            this.FlightCard()
          }
          .margin({ top: 18 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 18, right: 18, top: 14 })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#4060A5FA', 0.0], [FlightColors.background, 0.5], ['#332563EB', 1.0]]
        })
      }
      .width('100%')
      .height('100%')

      if (this.showDialog) {
        Text('')
          .width('100%')
          .height('100%')
          .backgroundColor('#33000000')
      }

      this.SuccessDialog()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(FlightColors.background)
  }
}
