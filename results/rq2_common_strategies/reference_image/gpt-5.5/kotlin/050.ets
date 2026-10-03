class AppColors {
  static readonly PRIMARY: string = '#1E3A8A'
  static readonly SECONDARY: string = '#2563EB'
  static readonly TERTIARY: string = '#60A5FA'
  static readonly BACKGROUND: string = '#F5F8FF'
  static readonly SURFACE: string = '#FFFFFF'
  static readonly SURFACE_VARIANT: string = '#E8EEFA'
  static readonly OUTLINE: string = '#CBD5E1'
  static readonly ON_PRIMARY: string = '#FFFFFF'
  static readonly ON_SECONDARY: string = '#FFFFFF'
  static readonly ON_SURFACE: string = '#0B1220'
}

class AppSpacing {
  static readonly XS: number = 6
  static readonly SM: number = 10
  static readonly MD: number = 14
  static readonly LG: number = 18
  static readonly XL: number = 26
  static readonly XXL: number = 36
}

@Entry
@Component
struct Index {
  @State private name: string = ''
  @State private code: string = ''
  @State private selectedSeat: number = 0
  @State private showDialog: boolean = false

  private seatLabel(): string {
    if (this.selectedSeat === 0) {
      return '23C'
    }
    if (this.selectedSeat === 1) {
      return '11A'
    }
    return '2F'
  }

  @Builder
  private TopBar() {
    Row() {
      Circle()
        .width(44)
        .height(44)
        .fill(AppColors.PRIMARY)

      Text('Flight Check-in')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.ON_SURFACE)
        .maxLines(1)

      Circle()
        .width(44)
        .height(44)
        .fill(AppColors.SECONDARY)
    }
    .width('100%')
    .height(128)
    .padding({ left: 44, right: 44, top: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.SURFACE)
  }

  @Builder
  private InputBox(valueText: string, hintText: string, inputType: number) {
    TextInput({ text: valueText, placeholder: hintText })
      .width('100%')
      .height(112)
      .fontSize(24)
      .fontColor(AppColors.ON_SURFACE)
      .placeholderColor('#7D8594')
      .caretColor(AppColors.PRIMARY)
      .backgroundColor(AppColors.SURFACE_VARIANT)
      .borderRadius(20)
      .padding({ left: 32, right: 24 })
      .border({ width: { bottom: 1 }, color: AppColors.OUTLINE })
      .onChange((value: string) => {
        if (inputType === 0) {
          this.name = value
        } else {
          this.code = value
        }
      })
  }

  @Builder
  private SegmentEconomy() {
    Row({ space: 12 }) {
      Text('✓')
        .fontSize(24)
        .fontColor(this.selectedSeat === 0 ? AppColors.ON_PRIMARY : AppColors.ON_SURFACE)
        .visibility(this.selectedSeat === 0 ? Visibility.Visible : Visibility.None)

      Text('Economy')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedSeat === 0 ? AppColors.ON_PRIMARY : AppColors.ON_SURFACE)
    }
    .height('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.selectedSeat === 0 ? AppColors.PRIMARY : AppColors.SURFACE_VARIANT)
    .borderRadius({ topLeft: 38, bottomLeft: 38 })
    .onClick(() => {
      this.selectedSeat = 0
    })
  }

  @Builder
  private SegmentPremium() {
    Row() {
      Text('Premium')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedSeat === 1 ? AppColors.ON_PRIMARY : AppColors.ON_SURFACE)
    }
    .height('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.selectedSeat === 1 ? AppColors.PRIMARY : AppColors.SURFACE_VARIANT)
    .border({ width: { left: 1, right: 1 }, color: AppColors.OUTLINE })
    .onClick(() => {
      this.selectedSeat = 1
    })
  }

  @Builder
  private SegmentBusiness() {
    Row() {
      Text('Business')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedSeat === 2 ? AppColors.ON_PRIMARY : AppColors.ON_SURFACE)
    }
    .height('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.selectedSeat === 2 ? AppColors.PRIMARY : AppColors.SURFACE_VARIANT)
    .borderRadius({ topRight: 38, bottomRight: 38 })
    .onClick(() => {
      this.selectedSeat = 2
    })
  }

  @Builder
  private PassengerCard() {
    Column({ space: AppSpacing.MD }) {
      Text('Passenger')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.ON_SURFACE)

      this.InputBox(this.name, 'Full name', 0)

      Text('Booking Code')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.ON_SURFACE)
        .margin({ top: 6 })

      this.InputBox(this.code, 'e.g. XY7ZK2', 1)

      Text('Seat Class')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.ON_SURFACE)
        .margin({ top: 6 })

      Row() {
        this.SegmentEconomy()
        this.SegmentPremium()
        this.SegmentBusiness()
      }
      .width('100%')
      .height(80)
      .clip(true)
      .backgroundColor(AppColors.SURFACE_VARIANT)
      .borderRadius(40)
      .border({ width: 1, color: AppColors.OUTLINE })
    }
    .width('100%')
    .padding(AppSpacing.LG)
    .backgroundColor(AppColors.SURFACE)
    .borderRadius(32)
    .shadow({
      radius: 18,
      color: '#33000000',
      offsetX: 0,
      offsetY: 8
    })
  }

  @Builder
  private InfoColumn(title: string, value: string) {
    Column() {
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.ON_SURFACE)

      Text(value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.PRIMARY)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private FlightCard() {
    Column({ space: AppSpacing.MD }) {
      Row() {
        Column({ space: AppSpacing.XS }) {
          Text('Flight')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.ON_SURFACE)

          Text('BL 213 • HND → CTS')
            .fontSize(18)
            .fontColor(AppColors.ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)

        Circle()
          .width(72)
          .height(72)
          .fill(AppColors.SECONDARY)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        this.InfoColumn('Boarding', '12:35')
        this.InfoColumn('Gate', 'A12')
        this.InfoColumn('Seat', this.seatLabel())
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Button('Confirm Check-in', { type: ButtonType.Capsule, stateEffect: true })
        .width('100%')
        .height(104)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.ON_PRIMARY)
        .backgroundColor(AppColors.PRIMARY)
        .margin({ top: 8 })
        .onClick(() => {
          this.showDialog = true
        })
    }
    .width('100%')
    .padding(AppSpacing.LG)
    .backgroundColor(AppColors.SURFACE)
    .borderRadius(32)
    .shadow({
      radius: 18,
      color: '#33000000',
      offsetX: 0,
      offsetY: 8
    })
  }

  @Builder
  private SuccessDialog() {
    Stack({ alignContent: Alignment.Center }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#66000000')
        .onClick(() => {
          this.showDialog = false
        })

      Column({ space: 16 }) {
        Text('Check-in Successful')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.ON_SURFACE)
          .width('100%')
          .textAlign(TextAlign.Start)

        Text('Boarding pass is ready. Have a nice flight.')
          .fontSize(14)
          .fontColor(AppColors.ON_SURFACE)
          .width('100%')
          .textAlign(TextAlign.Start)

        Row() {
          Blank()

          Button('Done', { type: ButtonType.Capsule, stateEffect: true })
            .height(48)
            .padding({ left: 24, right: 24 })
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.ON_SECONDARY)
            .backgroundColor(AppColors.SECONDARY)
            .onClick(() => {
              this.showDialog = false
            })
        }
        .width('100%')
      }
      .width('82%')
      .padding(24)
      .backgroundColor(AppColors.SURFACE)
      .borderRadius(18)
      .shadow({
        radius: 20,
        color: '#33000000',
        offsetX: 0,
        offsetY: 8
      })
    }
    .width('100%')
    .height('100%')
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: AppSpacing.LG }) {
            this.PassengerCard()
            this.FlightCard()
          }
          .width('100%')
          .padding({
            left: AppSpacing.LG,
            right: AppSpacing.LG,
            top: AppSpacing.MD,
            bottom: AppSpacing.LG
          })
        }
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['rgba(96,165,250,0.25)', 0.0],
            [AppColors.BACKGROUND, 0.52],
            ['rgba(37,99,235,0.20)', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.BACKGROUND)

      if (this.showDialog) {
        this.SuccessDialog()
      }
    }
    .width('100%')
    .height('100%')
  }
}