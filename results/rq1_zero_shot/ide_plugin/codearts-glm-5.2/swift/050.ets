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
    onSurface: '#FF0B1220',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 18,
  }
  static readonly Spacing = {
    xs: 6,
    sm: 10,
    md: 14,
    lg: 18,
    xl: 26,
    xxl: 36,
  }
}

@Component
struct SegmentedControl {
  @Prop selectedIndex: number
  @State labels: string[] = ['Economy', 'Premium', 'Business']
  @Link selectedIndexLink: number

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Stack() {
          Row({ space: AppTokens.Spacing.xs }) {
            if (this.selectedIndexLink === index) {
              Text('✓')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            Text(label)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(this.selectedIndexLink === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(40)
          .justifyContent(FlexAlign.Center)
        }
        .layoutWeight(1)
        .height(40)
        .backgroundColor(this.selectedIndexLink === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .borderRadius(this.selectedIndexLink === index ? AppTokens.Shapes.medium : 0)
        .onClick(() => {
          this.selectedIndexLink = index
        })
      })
    }
    .width('100%')
    .height(40)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .borderRadius(AppTokens.Shapes.medium)
  }
}

@Entry
@Component
struct RootScreen {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false
  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private seatNumber(index: number): string {
    if (index === 0) {
      return '23C'
    } else if (index === 1) {
      return '11A'
    } else {
      return '2F'
    }
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [['#4060A5FA', 0.0], [AppTokens.Colors.background, 0.5], ['#332563EB', 1.0]]
        })

      Column() {
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(AppTokens.Colors.primary)
            .margin({ left: AppTokens.Spacing.lg })

          Blank()

          Text('Flight Check-in')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Circle({ width: 22, height: 22 })
            .fill(AppTokens.Colors.secondary)
            .margin({ right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: AppTokens.Spacing.md })

        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            Column({ space: AppTokens.Spacing.lg }) {
              Text('Passenger')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((value: string) => {
                  this.name = value
                })

              Text('Booking Code')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((value: string) => {
                  this.code = value
                })

              Text('Seat Class')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Row() {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Stack() {
                    Row({ space: AppTokens.Spacing.xs }) {
                      if (this.selectedSeat === index) {
                        Text('✓')
                          .fontSize(14)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(AppTokens.Colors.onPrimary)
                      }
                      Text(label)
                        .fontSize(AppTokens.Typography.label.size)
                        .fontWeight(AppTokens.Typography.label.weight)
                        .fontColor(this.selectedSeat === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    }
                  }
                  .layoutWeight(1)
                  .height(40)
                  .backgroundColor(this.selectedSeat === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                  .onClick(() => {
                    this.selectedSeat = index
                  })
                })
              }
              .width('100%')
              .height(40)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .borderRadius(AppTokens.Shapes.medium)
            }
            .width('100%')
            .padding(AppTokens.Spacing.xl)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
            .alignItems(HorizontalAlign.Start)

            Column({ space: AppTokens.Spacing.md }) {
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
                .layoutWeight(1)

                Circle({ width: 36, height: 36 })
                  .fill(AppTokens.Colors.secondary)
              }
              .width('100%')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)

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

              Button('Confirm Check-in')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
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
            .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      if (this.showDialog) {
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')

          Column({ space: AppTokens.Spacing.md }) {
            Text('Check-in Successful')
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Button('Done')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width('100%')
              .height(48)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width('80%')
          .padding(AppTokens.Spacing.xl)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
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