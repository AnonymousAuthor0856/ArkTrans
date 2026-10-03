// AppTokens Definition
class AppTokens {
  static readonly Colors = {
    primary: '#FF1E3A8A',
    secondary: '#FF2563EB',
    tertiary: '#FF60A5FA',
    background: '#FFF5F8FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE8EEFA',
    outline: '#FFCBD5E1',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0B1220',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220'
  }

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 18
  }

  static readonly Spacing = {
    xs: 6,
    sm: 10,
    md: 14,
    lg: 18,
    xl: 26,
    xxl: 36
  }

  static readonly Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.16 },
    level3: { radius: 12, dy: 6, opacity: 0.18 }
  }
}

// SegmentedControl Component
@Component
struct SegmentedControl {
  @Link selectedIndex: number
  private labels: string[] = []

  build() {
    Row({ space: 0 }) {
      ForEach(this.labels, (label: string, index: number) => {
        Button({ type: ButtonType.Normal, stateEffect: false }) {
          Row({ space: AppTokens.Spacing.xs }) {
            if (this.selectedIndex === index) {
              Image($r('sys.symbol.checkmark'))
                .width(14)
                .height(14)
                .fillColor(AppTokens.Colors.onPrimary)
            }
            Text(label)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(this.selectedIndex === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(40)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(this.selectedIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        }
        .layoutWeight(1)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {
          this.selectedIndex = index
        })
      })
    }
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  @State private name: string = ''
  @State private code: string = ''
  @State private selectedSeat: number = 0
  @State private showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private seatNumber(index: number): string {
    if (index === 0) return '23C'
    if (index === 1) return '11A'
    return '2F'
  }

  build() {
    Stack() {
      // Background gradient
      Column() {
        // Header
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(AppTokens.Colors.primary)

          Blank()

          Text('Flight Check-in')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Circle({ width: 22, height: 22 })
            .fill(AppTokens.Colors.secondary)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .margin({ bottom: AppTokens.Spacing.md })

        // Scrollable content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Passenger & Booking Card
            Column({ space: AppTokens.Spacing.lg }) {
              Text('Passenger')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .padding(AppTokens.Spacing.md)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((value: string) => {
                  this.name = value
                })

              Text('Booking Code')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .padding(AppTokens.Spacing.md)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((value: string) => {
                  this.code = value
                })

              Text('Seat Class')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              SegmentedControl({ selectedIndex: this.selectedSeat, labels: this.seatTabs })
            }
            .width('100%')
            .padding(AppTokens.Spacing.xl)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level2.radius,
              color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
              offsetY: AppTokens.Elevation.level2.dy
            })

            // Flight Details Card
            Column({ space: AppTokens.Spacing.md }) {
              // Flight info row
              Row() {
                Column({ space: AppTokens.Spacing.xs }) {
                  Text('Flight')
                    .fontSize(AppTokens.Typography.title.size)
                    .fontWeight(AppTokens.Typography.title.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(AppTokens.Typography.body.size)
                    .fontWeight(AppTokens.Typography.body.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Circle({ width: 36, height: 36 })
                  .fill(AppTokens.Colors.secondary)
              }
              .width('100%')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)

              // Boarding info
              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(AppTokens.Typography.label.size)
                    .fontWeight(AppTokens.Typography.label.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('12:35')
                    .fontSize(AppTokens.Typography.title.size)
                    .fontWeight(AppTokens.Typography.title.weight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column() {
                  Text('Gate')
                    .fontSize(AppTokens.Typography.label.size)
                    .fontWeight(AppTokens.Typography.label.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('A12')
                    .fontSize(AppTokens.Typography.title.size)
                    .fontWeight(AppTokens.Typography.title.weight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column() {
                  Text('Seat')
                    .fontSize(AppTokens.Typography.label.size)
                    .fontWeight(AppTokens.Typography.label.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(AppTokens.Typography.title.size)
                    .fontWeight(AppTokens.Typography.title.weight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

              // Confirm button
              Button('Confirm Check-in') {
                Text('Confirm Check-in')
                  .fontSize(AppTokens.Typography.title.size)
                  .fontWeight(AppTokens.Typography.title.weight)
                  .fontColor(AppTokens.Colors.onPrimary)
              }
              .width('100%')
              .height(52)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.large)
              .onClick(() => {
                this.showDialog = true
              })
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level2.radius,
              color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
              offsetY: AppTokens.Elevation.level2.dy
            })
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.tertiary, 0.25],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.secondary, 0.2]
        ]
      })

      // Success dialog
      if (this.showDialog) {
        Stack() {
          Column() {
            Text('Check-in Successful')
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.lg })

            Button('Done') {
              Text('Done')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width('100%')
            .height(44)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.showDialog = false
            })
          }
          .padding(AppTokens.Spacing.xl)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .width('80%')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.4)')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}