// AppTokens - Color, Typography, Shape, Spacing, Elevation tokens
class AppColors {
  static readonly primary: string = '#FF1E3A8A'
  static readonly secondary: string = '#FF2563EB'
  static readonly tertiary: string = '#FF60A5FA'
  static readonly background: string = '#FFF5F8FF'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFE8EEFA'
  static readonly outline: string = '#FFCBD5E1'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FFFFFFFF'
  static readonly onSurface: string = '#FF0B1220'
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

// Segmented control component
@Component
struct SegmentedControl {
  @Link selectedIndex: number
  labels: string[] = []

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Button() {
          Row({ space: AppSpacing.xs }) {
            if (this.selectedIndex === index) {
              Text('✓')
                .fontSize(14)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onPrimary)
            }
            Text(label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedIndex === index ? AppColors.onPrimary : AppColors.onSurface)
          }
          .width('100%')
          .height(40)
          .justifyContent(FlexAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor(this.selectedIndex === index ? AppColors.primary : AppColors.surfaceVariant)
        .borderRadius(this.getSegmentRadius(index))
        .onClick(() => {
          this.selectedIndex = index
        })
        .layoutWeight(1)
      })
    }
    .width('100%')
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.mediumCornerRadius })
    .clip(true)
  }

  private getSegmentRadius(index: number): BorderRadiuses {
    const r = AppShapes.mediumCornerRadius
    if (this.labels.length === 1) {
      return { topLeft: r, topRight: r, bottomLeft: r, bottomRight: r }
    } else if (index === 0) {
      return { topLeft: r, topRight: 0, bottomLeft: r, bottomRight: 0 }
    } else if (index === this.labels.length - 1) {
      return { topLeft: 0, topRight: r, bottomLeft: 0, bottomRight: r }
    } else {
      return { topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0 }
    }
  }
}

// Main screen
@Entry
@Component
struct RootScreen {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private readonly seatTabs: string[] = ['Economy', 'Premium', 'Business']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Gradient background
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [
            [AppColors.tertiary + '40', 0.0],
            [AppColors.background, 0.5],
            [AppColors.secondary + '33', 1.0]
          ],
          direction: GradientDirection.Bottom
        })

      Column({ space: 0 }) {
        // Header
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(AppColors.primary)
            .margin({ left: AppSpacing.lg })

          Blank()

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)

          Blank()

          Circle({ width: 22, height: 22 })
            .fill(AppColors.secondary)
            .margin({ right: AppSpacing.lg })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: AppSpacing.md })

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            // Passenger & Booking Card
            Column({ space: AppSpacing.lg }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onSurface)
                .width('100%')

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(14)
                .fontColor(AppColors.onSurface)
                .placeholderColor('#FF9CA3AF')
                .padding(AppSpacing.md)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.mediumCornerRadius)
                .border({ width: 1, color: AppColors.outline })
                .onChange((value: string) => {
                  this.name = value
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onSurface)
                .width('100%')

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(14)
                .fontColor(AppColors.onSurface)
                .placeholderColor('#FF9CA3AF')
                .padding(AppSpacing.md)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.mediumCornerRadius)
                .border({ width: 1, color: AppColors.outline })
                .onChange((value: string) => {
                  this.code = value
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onSurface)
                .width('100%')

              SegmentedControl({ selectedIndex: $selectedSeat, labels: this.seatTabs })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppSpacing.xl)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: 8,
              color: '#29000000',
              offsetY: 4
            })

            // Flight Details Card
            Column({ space: AppSpacing.md }) {
              // Flight info row
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

                Circle({ width: 36, height: 36 })
                  .fill(AppColors.secondary)
              }
              .width('100%')
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.mediumCornerRadius)

              // Boarding / Gate / Seat row
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

              // Confirm button
              Button('Confirm Check-in')
                .width('100%')
                .height(52)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppShapes.largeCornerRadius)
                .onClick(() => {
                  this.showDialog = true
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: 8,
              color: '#29000000',
              offsetY: 4
            })
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .width('100%')
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .bindSheet($showDialog, this.buildDialogSheet(), {
      height: 240,
      dragBar: true,
      showClose: false,
      backgroundColor: AppColors.surface,
      borderRadius: [AppShapes.largeCornerRadius, AppShapes.largeCornerRadius, 0, 0]
    })
  }

  @Builder
  buildDialogSheet() {
    Column({ space: AppSpacing.md }) {
      Text('Check-in Successful')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Text('Boarding pass is ready. Have a nice flight.')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)

      Blank()

      Button('Done')
        .width('100%')
        .height(48)
        .fontSize(16)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.mediumCornerRadius)
        .onClick(() => {
          this.showDialog = false
        })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }

  private seatNumber(index: number): string {
    if (index === 0) {
      return '23C'
    } else if (index === 1) {
      return '11A'
    } else {
      return '2F'
    }
  }
}
