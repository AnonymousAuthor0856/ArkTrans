@Entry
@Component
struct FlightCheckinApp {
  @State private var name: string = ''
  @State private var code: string = ''
  @State private var selectedSeat: number = 0
  @State private var showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  // AppTokens Colors
  private primary: string = '#FF1E3A8A'
  private secondary: string = '#FF2563EB'
  private tertiary: string = '#FF60A5FA'
  private background: string = '#FFF5F8FF'
  private surface: string = '#FFFFFFFF'
  private surfaceVariant: string = '#FFE8EEFA'
  private outline: string = '#FFCBD5E1'
  private onPrimary: string = '#FFFFFFFF'
  private onSurface: string = '#FF0B1220'

  // Spacing
  private spacingXs: number = 6
  private spacingSm: number = 10
  private spacingMd: number = 14
  private spacingLg: number = 18
  private spacingXl: number = 26
  private spacingXxl: number = 36

  // Corner Radius
  private smallCornerRadius: number = 8
  private mediumCornerRadius: number = 12
  private largeCornerRadius: number = 18

  private seatNumberFor(index: number): string {
    if (index === 0) {
      return '23C'
    } else if (index === 1) {
      return '11A'
    } else {
      return '2F'
    }
  }

  @Builder
  SegmentedControlBuilder() {
    Row({ space: 0 }) {
      ForEach(this.seatTabs, (label: string, index: number) => {
        Button() {
          this.selectedSeat = index
        }
        .width('33.33%')
        .height(40)
        .backgroundColor(this.selectedSeat === index ? this.primary : this.surfaceVariant)
        .borderRadius(0)
        .border({
          width: 1,
          color: this.outline
        })
        .layoutWeight(1)
        .type(ButtonType.Normal)
        .borderRadius(this.getSegmentRadius(index))
        .stateEffect(false)
        .focusable(false)
        .defaultFocus(false)
        .enabled(true)
        .hitTestBehavior(HitTestMode.Block)
        .onClick(() => {
          this.selectedSeat = index
        })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 0, right: 0, top: 0, bottom: 0 })
        .margin({ left: 0, right: 0, top: 0, bottom: 0 })
        .clip(false)
        .constraintSize({ minHeight: 40 })
        .responseRegion({
          x: 0,
          y: 0,
          width: '100%',
          height: '100%'
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
        })
        .background(
          Row({ space: this.spacingXs }) {
            if (this.selectedSeat === index) {
              Text('✓')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.onPrimary)
            }
            Text(label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedSeat === index ? this.onPrimary : this.onSurface)
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height('100%')
          .backgroundColor(this.selectedSeat === index ? this.primary : this.surfaceVariant)
          .borderRadius(this.getSegmentRadius(index))
        )
      }, (label: string, index: number) => `${label}_${index}`)
    }
    .width('100%')
    .height(40)
    .borderRadius(this.mediumCornerRadius)
    .border({
      width: 1,
      color: this.outline
    })
    .clip(true)
  }

  private getSegmentRadius(index: number): number {
    if (this.seatTabs.length === 1) {
      return this.mediumCornerRadius
    } else if (index === 0) {
      return this.mediumCornerRadius
    } else if (index === this.seatTabs.length - 1) {
      return this.mediumCornerRadius
    } else {
      return 0
    }
  }

  @Builder
  PassengerCardBuilder() {
    Column({ space: this.spacingLg }) {
      Text('Passenger')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      TextInput({ placeholder: 'Full name', text: this.name })
        .fontSize(14)
        .fontColor(this.onSurface)
        .placeholderColor('#99' + this.onSurface.substring(3))
        .placeholderFont({ size: 14 })
        .padding(this.spacingMd)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(this.mediumCornerRadius)
        .border({
          width: 1,
          color: this.outline
        })
        .width('100%')
        .height(48)
        .onChange((value: string) => {
          this.name = value
        })

      Text('Booking Code')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
        .fontSize(14)
        .fontColor(this.onSurface)
        .placeholderColor('#99' + this.onSurface.substring(3))
        .placeholderFont({ size: 14 })
        .padding(this.spacingMd)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(this.mediumCornerRadius)
        .border({
          width: 1,
          color: this.outline
        })
        .width('100%')
        .height(48)
        .onChange((value: string) => {
          this.code = value
        })

      Text('Seat Class')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      this.SegmentedControlBuilder()
    }
    .width('100%')
    .padding(this.spacingXl)
    .backgroundColor(this.surface)
    .borderRadius(this.largeCornerRadius)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  FlightDetailsCardBuilder() {
    Column({ space: this.spacingMd }) {
      // Flight info row
      Row() {
        Column({ space: this.spacingXs }) {
          Text('Flight')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
          Text('BL 213 • HND → CTS')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(this.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Circle()
          .fill(this.secondary)
          .width(36)
          .height(36)
      }
      .width('100%')
      .padding(this.spacingMd)
      .backgroundColor(this.surface)
      .borderRadius(this.mediumCornerRadius)
      .alignItems(VerticalAlign.Center)

      // Boarding, Gate, Seat info
      Row() {
        Column({ space: 4 }) {
          Text('Boarding')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
          Text('12:35')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primary)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column({ space: 4 }) {
          Text('Gate')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
          Text('A12')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primary)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column({ space: 4 }) {
          Text('Seat')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)
          Text(this.seatNumberFor(this.selectedSeat))
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primary)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .padding({
        top: this.spacingMd,
        bottom: this.spacingMd,
        left: 0,
        right: 0
      })

      Button('Confirm Check-in')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onPrimary)
        .backgroundColor(this.primary)
        .borderRadius(this.largeCornerRadius)
        .width('100%')
        .height(52)
        .type(ButtonType.Normal)
        .stateEffect(false)
        .focusable(false)
        .defaultFocus(false)
        .enabled(true)
        .hitTestBehavior(HitTestMode.Block)
        .onClick(() => {
          this.showDialog = true
        })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 0, right: 0, top: 0, bottom: 0 })
        .margin({ left: 0, right: 0, top: 0, bottom: 0 })
        .clip(false)
        .constraintSize({ minHeight: 52 })
        .responseRegion({
          x: 0,
          y: 0,
          width: '100%',
          height: '100%'
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
        })
        .background(
          Text('Confirm Check-in')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimary)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
            .backgroundColor(this.primary)
            .borderRadius(this.largeCornerRadius)
        )
    }
    .width('100%')
    .padding(this.spacingLg)
    .backgroundColor(this.surface)
    .borderRadius(this.largeCornerRadius)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            ['#4060A5FA', 0],
            ['#FFF5F8FF', 0.5],
            ['#332563EB', 1]
          ]
        })

      Column({ space: 0 }) {
        // Header
        Row() {
          Circle()
            .fill(this.primary)
            .width(22)
            .height(22)
            .margin({ left: this.spacingLg })

          Blank()
            .layoutWeight(1)

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.onSurface)

          Blank()
            .layoutWeight(1)

          Circle()
            .fill(this.secondary)
            .width(22)
            .height(22)
            .margin({ right: this.spacingLg })
        }
        .width('100%')
        .height(56)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: this.spacingMd })

        // Scrollable content
        Scroll() {
          Column({ space: this.spacingLg }) {
            this.PassengerCardBuilder()
            this.FlightDetailsCardBuilder()
          }
          .width('100%')
          .padding({
            left: this.spacingLg,
            right: this.spacingLg,
            top: this.spacingMd,
            bottom: this.spacingMd
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .bindPopup(this.showDialog, {
      Column({ space: 16 }) {
        Text('Check-in Successful')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
          .textAlign(TextAlign.Center)

        Text('Boarding pass is ready. Have a nice flight.')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.onSurface)
          .textAlign(TextAlign.Center)

        Button('Done')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onPrimary)
          .backgroundColor(this.primary)
          .borderRadius(this.mediumCornerRadius)
          .width('100%')
          .height(44)
          .type(ButtonType.Normal)
          .stateEffect(false)
          .focusable(false)
          .defaultFocus(false)
          .enabled(true)
          .hitTestBehavior(HitTestMode.Block)
          .onClick(() => {
            this.showDialog = false
          })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .padding({ left: 0, right: 0, top: 0, bottom: 0 })
          .margin({ left: 0, right: 0, top: 0, bottom: 0 })
          .clip(false)
          .constraintSize({ minHeight: 44 })
          .responseRegion({
            x: 0,
            y: 0,
            width: '100%',
            height: '100%'
          })
          .onAreaChange((oldValue: Area, newValue: Area) => {
          })
          .background(
            Text('Done')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onPrimary)
              .width('100%')
              .height('100%')
              .textAlign(TextAlign.Center)
              .backgroundColor(this.primary)
              .borderRadius(this.mediumCornerRadius)
          )
      }
      .width('80%')
      .padding(24)
      .backgroundColor(this.surface)
      .borderRadius(this.largeCornerRadius)
      .shadow({
        radius: 12,
        color: '#2E000000',
        offsetX: 0,
        offsetY: 6
      })
      .alignItems(HorizontalAlign.Center)
    })
  }
}