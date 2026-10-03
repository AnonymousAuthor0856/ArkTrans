const Colors = {
  primary: '#1E3A8A',
  secondary: '#2563EB',
  tertiary: '#60A5FA',
  background: '#F5F8FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E8EEFA',
  outline: '#CBD5E1',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#0B1220',
  onBackground: '#0B1220',
  onSurface: '#0B1220'
}

const Shapes = {
  small: 8,
  medium: 12,
  large: 18
}

const Spacing = {
  xs: 6,
  sm: 10,
  md: 14,
  lg: 18,
  xl: 26,
  xxl: 36
}

@Entry
@Component
struct Index {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false
  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Row() {
          Row()
            .width(22)
            .height(22)
            .borderRadius(11)
            .backgroundColor(Colors.primary)
            .margin({ left: Spacing.lg })
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Row()
            .width(22)
            .height(22)
            .borderRadius(11)
            .backgroundColor(Colors.secondary)
            .margin({ right: Spacing.lg })
        }
        .width('100%')
        .height(56)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Colors.surface)

        Scroll() {
          Column({ space: Spacing.lg }) {
            Column({ space: Spacing.md }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)
              TextInput({ placeholder: 'Full name', text: this.name })
                .width('100%')
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.medium)
                .placeholderColor('#800B1220')
                .onChange((value: string) => {
                  this.name = value
                })
              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)
              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .width('100%')
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(Shapes.medium)
                .placeholderColor('#800B1220')
                .onChange((value: string) => {
                  this.code = value
                })
              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)
              Row({ space: Spacing.xs }) {
                ForEach(this.seatTabs, (label: string) => {
                  Button(label, { type: ButtonType.Normal })
                    .layoutWeight(1)
                    .height(36)
                    .borderRadius(Shapes.medium)
                    .backgroundColor(this.selectedSeat === this.seatTabs.indexOf(label) ? Colors.primary : Colors.surfaceVariant)
                    .fontColor(this.selectedSeat === this.seatTabs.indexOf(label) ? Colors.onPrimary : Colors.onSurface)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .onClick(() => {
                      this.selectedSeat = this.seatTabs.indexOf(label)
                    })
                }, (label: string) => label)
              }
              .width('100%')
            }
            .width('100%')
            .padding(Spacing.lg)
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.large)
            .shadow({ radius: 8, color: '#29000000', offsetY: 4 })

            Column({ space: Spacing.md }) {
              Row() {
                Column({ space: Spacing.xs }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                }
                Row()
                  .width(36)
                  .height(36)
                  .borderRadius(18)
                  .backgroundColor(Colors.secondary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.primary)
                }
                Column() {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.primary)
                }
                Column() {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(this.selectedSeat === 0 ? '23C' : (this.selectedSeat === 1 ? '11A' : '2F'))
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.primary)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Button('Confirm Check-in', { type: ButtonType.Normal })
                .width('100%')
                .height(52)
                .borderRadius(Shapes.large)
                .backgroundColor(Colors.primary)
                .fontColor(Colors.onPrimary)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .onClick(() => {
                  this.showDialog = true
                })
            }
            .width('100%')
            .padding(Spacing.lg)
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.large)
            .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
          }
          .width('100%')
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        }
        .layoutWeight(1)
        .width('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#4060A5FA', 0.0], ['#F5F8FF', 0.5], ['#332563EB', 1.0]]
        })
      }
      .width('100%')
      .height('100%')

      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          Column({ space: Spacing.md }) {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor(Colors.onSurface)
            Button('Done', { type: ButtonType.Normal })
              .borderRadius(Shapes.medium)
              .backgroundColor(Colors.secondary)
              .fontColor(Colors.onSecondary)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width('85%')
          .padding(Spacing.lg)
          .backgroundColor(Colors.surface)
          .borderRadius(Shapes.medium)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#66000000')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
