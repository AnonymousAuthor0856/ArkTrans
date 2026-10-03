// src/main/ets/view/FlightCheckin.ets

@Entry
@Component
struct FlightCheckin {
  @State name: string = ""
  @State code: string = ""
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  // AppTokens Colors
  private readonly primary: ResourceColor = '#1E3A8A'
  private readonly secondary: ResourceColor = '#2563EB'
  private readonly tertiary: ResourceColor = '#60A5FA'
  private readonly background: ResourceColor = '#F5F8FF'
  private readonly surface: ResourceColor = '#FFFFFF'
  private readonly surfaceVariant: ResourceColor = '#E8EEFA'
  private readonly outline: ResourceColor = '#CBD5E1'
  private readonly onSurface: ResourceColor = '#0B1220'
  private readonly onPrimary: ResourceColor = '#FFFFFF'

  // Spacing
  private readonly spacingLg: number = 18
  private readonly spacingMd: number = 14
  private readonly spacingXs: number = 6

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle({ width: 22, height: 22 }).fill(this.primary).margin({ start: this.spacingLg })
        Text('Flight Check-in')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Circle({ width: 22, height: 22 }).fill(this.secondary).margin({ end: this.spacingLg })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)

      // Main Content Area with Gradient Background
      Column() {
        // Card 1: Passenger Details
        Column() {
          Text('Passenger').fontSize(20).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
          TextInput({ placeholder: 'Full name', text: this.name })
            .placeholderColor('#800B1220')
            .backgroundColor(this.surfaceVariant)
            .borderRadius(12)
            .height(48)
            .margin({ top: this.spacingMd })
            .onChange((value: string) => { this.name = value })

          Text('Booking Code').fontSize(20).fontWeight(FontWeight.Medium).fontColor(this.onSurface).margin({ top: this.spacingMd })
          TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
            .placeholderColor('#800B1220')
            .backgroundColor(this.surfaceVariant)
            .borderRadius(12)
            .height(48)
            .margin({ top: this.spacingMd })
            .onChange((value: string) => { this.code = value })

          Text('Seat Class').fontSize(20).fontWeight(FontWeight.Medium).fontColor(this.onSurface).margin({ top: this.spacingMd })
          
          // Segmented Button Row
          Row() {
            this.buildSegmentedButton('Economy', 0)
            this.buildSegmentedButton('Premium', 1)
            this.buildSegmentedButton('Business', 2)
          }
          .width('100%')
          .margin({ top: this.spacingMd })
          .borderRadius(18)
          .borderWidth(1)
          .borderColor(this.outline)
        }
        .width('100%')
        .padding(this.spacingLg)
        .backgroundColor(this.surface)
        .borderRadius(18)
        .shadow({ radius: 8, color: '#29000000', offsetY: 4 })

        // Card 2: Flight Info
        Column() {
          Row() {
            Column() {
              Text('Flight').fontSize(16).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
              Text('BL 213 • HND → CTS').fontSize(14).fontColor(this.onSurface).margin({ top: this.spacingXs })
            }
            .layoutWeight(1)
            
            Circle({ width: 36, height: 36 }).fill(this.secondary)
          }
          .width('100%')

          Row() {
            Column() {
              Text('Boarding').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
              Text('12:35').fontSize(16).fontWeight(FontWeight.Medium).fontColor(this.primary).margin({ top: 2 })
            }.layoutWeight(1)
            
            Column() {
              Text('Gate').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
              Text('A12').fontSize(16).fontWeight(FontWeight.Medium).fontColor(this.primary).margin({ top: 2 })
            }.layoutWeight(1)
            
            Column() {
              Text('Seat').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.onSurface)
              Text(this.getSeatNumber()).fontSize(16).fontWeight(FontWeight.Medium).fontColor(this.primary).margin({ top: 2 })
            }.layoutWeight(1)
          }
          .width('100%')
          .margin({ top: this.spacingMd })

          Button('Confirm Check-in')
            .width('100%')
            .height(52)
            .backgroundColor(this.primary)
            .fontColor(this.onPrimary)
            .borderRadius(18)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ top: this.spacingMd })
            .onClick(() => { this.showDialog = true })
        }
        .width('100%')
        .padding(this.spacingLg)
        .backgroundColor(this.surface)
        .borderRadius(18)
        .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
        .margin({ top: this.spacingLg })

      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: this.spacingLg, right: this.spacingLg, bottom: this.spacingMd })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#4060A5FA', 0], ['#F5F8FF', 0.5], ['#332563EB', 1]]
      })

      // Dialog Overlay
      if (this.showDialog) {
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')
            .onClick(() => { this.showDialog = false })

          Column() {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurface)
              .margin({ bottom: 8 })
            
            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor(this.onSurface)
              .margin({ bottom: 24 })

            Button('Done')
              .width('100%')
              .height(40)
              .backgroundColor(this.secondary)
              .fontColor(this.onPrimary)
              .borderRadius(12)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .onClick(() => { this.showDialog = false })
          }
          .width('80%')
          .padding(24)
          .backgroundColor(this.surface)
          .borderRadius(16)
        }
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }

  @Builder
  buildSegmentedButton(label: string, index: number) {
    Row() {
      if (this.selectedSeat === index && index === 0) {
        Text('✓').fontColor(this.onPrimary).margin({ right: 4 })
      }
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedSeat === index ? this.onPrimary : this.onSurface)
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .height('100%')
    .backgroundColor(this.selectedSeat === index ? this.primary : Color.Transparent)
    .borderRadius(index === 0 ? [18, 0, 0, 18] : (index === 2 ? [0, 18, 18, 0] : 0))
    .onClick(() => { this.selectedSeat = index })
  }

  getSeatNumber(): string {
    switch (this.selectedSeat) {
      case 0: return '23C'
      case 1: return '11A'
      default: return '2F'
    }
  }
}