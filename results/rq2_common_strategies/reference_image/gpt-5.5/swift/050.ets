class AppColors {
  static readonly primary: string = '#1E3A8A'
  static readonly secondary: string = '#2563EB'
  static readonly tertiary: string = '#60A5FA'
  static readonly background: string = '#F5F8FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E8EEFA'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#0B1220'
  static readonly onBackground: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'

  static readonly tertiarySoft: string = '#4060A5FA'
  static readonly secondarySoft: string = '#332563EB'
  static readonly placeholder: string = '#AEB4C0'
  static readonly shadowLevel2: string = 'rgba(0, 0, 0, 0.16)'
}

class AppShapes {
  static readonly smallCornerRadius: number = 8
  static readonly mediumCornerRadius: number = 12
  static readonly largeCornerRadius: number = 18
}

class AppSpacing {
  static readonly xs: number = 6
  static readonly sm: number = 10
  static readonly md: number = 14
  static readonly lg: number = 18
  static readonly xl: number = 26
  static readonly xxl: number = 36
}

class AppShadow {
  static readonly level2Radius: number = 8
  static readonly level2Dy: number = 4
}

@Component
struct SegmentedControl {
  @Link selectedIndex: number
  @Prop labels: string[] = []

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Row({ space: AppSpacing.xs }) {
          if (this.selectedIndex === index) {
            Text('✓')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
              .lineHeight(24)
          }

          Text(label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedIndex === index ? AppColors.onPrimary : AppColors.onSurface)
        }
        .height(40)
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(this.selectedIndex === index ? AppColors.primary : AppColors.surfaceVariant)
        .onClick(() => {
          this.selectedIndex = index
        })
      }, (label: string) => label)
    }
    .width('100%')
    .height(40)
    .backgroundColor(AppColors.surfaceVariant)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .borderRadius(AppShapes.mediumCornerRadius)
    .clip(true)
  }
}

@Entry
@Component
struct RootScreen {
  @State private name: string = ''
  @State private code: string = ''
  @State private selectedSeat: number = 0

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  private seatNumber(index: number): string {
    if (index === 0) {
      return '23C'
    } else if (index === 1) {
      return '11A'
    }
    return '2F'
  }

  private showSuccessDialog(): void {
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
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Blank()
            .width(22)
            .height(22)
            .borderRadius(11)
            .backgroundColor(AppColors.primary)
            .margin({ left: AppSpacing.lg })

          Blank()
            .layoutWeight(1)

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)

          Blank()
            .layoutWeight(1)

          Blank()
            .width(22)
            .height(22)
            .borderRadius(11)
            .backgroundColor(AppColors.secondary)
            .margin({ right: AppSpacing.lg })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: AppSpacing.md })
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            Column({ space: AppSpacing.lg }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSurface)

              TextInput({
                placeholder: 'Full name',
                text: this.name
              })
                .width('100%')
                .height(48)
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.placeholder)
                .backgroundColor(AppColors.surfaceVariant)
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .border({
                  width: 1,
                  color: AppColors.outline
                })
                .borderRadius(AppShapes.mediumCornerRadius)
                .onChange((value: string) => {
                  this.name = value
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSurface)

              TextInput({
                placeholder: 'e.g. XY7ZK2',
                text: this.code
              })
                .width('100%')
                .height(48)
                .fontSize(14)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.placeholder)
                .backgroundColor(AppColors.surfaceVariant)
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .border({
                  width: 1,
                  color: AppColors.outline
                })
                .borderRadius(AppShapes.mediumCornerRadius)
                .onChange((value: string) => {
                  this.code = value
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSurface)

              SegmentedControl({
                selectedIndex: $selectedSeat,
                labels: this.seatTabs
              })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppSpacing.xl)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: AppShadow.level2Radius,
              color: AppColors.shadowLevel2,
              offsetX: 0,
              offsetY: AppShadow.level2Dy
            })

            Column({ space: AppSpacing.md }) {
              Row() {
                Column({ space: AppSpacing.xs }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)

                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor(AppColors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .layoutWeight(1)

                Blank()
                  .width(36)
                  .height(36)
                  .borderRadius(18)
                  .backgroundColor(AppColors.secondary)
              }
              .width('100%')
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.mediumCornerRadius)
              .alignItems(VerticalAlign.Center)

              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)

                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .layoutWeight(1)

                Column() {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)

                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .layoutWeight(1)

                Column() {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)

                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
              .alignItems(VerticalAlign.Center)

              Button({ type: ButtonType.Normal }) {
                Text('Confirm Check-in')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onPrimary)
              }
              .width('100%')
              .height(52)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.largeCornerRadius)
              .onClick(() => {
                this.showSuccessDialog()
              })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: AppShadow.level2Radius,
              color: AppColors.shadowLevel2,
              offsetX: 0,
              offsetY: AppShadow.level2Dy
            })
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.tertiarySoft, 0.0],
        [AppColors.background, 0.5],
        [AppColors.secondarySoft, 1.0]
      ]
    })
  }
}