// MARK: - 1. AppTokens Definition
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }
interface ShadowSpec { elevation: number; radius: number; dy: number; opacity: number }
interface ElevationTokens { [key: string]: ShadowSpec }

class AppTokens {
  static readonly Colors: ColorTokens = {
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

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 18
  }

  static readonly Spacing: NumberTokens = {
    xs: 6, sm: 10, md: 14, lg: 18, xl: 26, xxl: 36
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.16 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  }
}

// MARK: - 3. Custom Segmented Control with Checkmarks
@Component
struct SegmentedControl {
  @Link selectedIndex: number
  labels: string[] = []

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Button() {
          Row({ space: AppTokens.Spacing.xs }) {
            if (this.selectedIndex === index) {
              Text('✓')
                .fontSize(14)
                .fontWeight(FontWeight.Semibold)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            Text(label)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(this.selectedIndex === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(40)
          .backgroundColor(this.selectedIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedIndex = index
        })
      }, (label: string, index: number) => index.toString())
    }
    .width('100%')
    .borderRadius(AppTokens.Shapes.mediumCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - 4. RootScreen
@Entry
@Component
struct Index {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  seatTabs: string[] = ['Economy', 'Premium', 'Business']

  seatNumber(index: number): string {
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
      // 背景渐变。
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            ['rgba(96, 165, 250, 0.25)', 0.0],
            ['#F5F8FF', 0.5],
            ['rgba(37, 99, 235, 0.2)', 1.0]
          ]
        })

      Column() {
        // 顶部标题栏。
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
        .padding({ bottom: AppTokens.Spacing.md })

        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Passenger & Booking Card
            Column({ space: AppTokens.Spacing.lg }) {
              Text('Passenger')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                .fontColor(AppTokens.Colors.onSurface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((v: string) => {
                  this.name = v
                })

              Text('Booking Code')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                .fontColor(AppTokens.Colors.onSurface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onChange((v: string) => {
                  this.code = v
                })

              Text('Seat Class')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              SegmentedControl({ selectedIndex: $this.selectedSeat, labels: this.seatTabs })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(AppTokens.Spacing.xl)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: 'rgba(0, 0, 0, 0.16)',
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })

            // Flight Details Card
            Column({ space: AppTokens.Spacing.md }) {
              // Flight 信息行
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
              .borderRadius(AppTokens.Shapes.mediumCornerRadius)

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

                Blank()

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

                Blank()

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
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

              Button('Confirm Check-in')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
                .width('100%')
                .height(52)
                .backgroundColor(AppTokens.Colors.primary)
                .borderRadius(AppTokens.Shapes.largeCornerRadius)
                .onClick(() => {
                  this.showDialog = true
                  AlertDialog.show({
                    title: 'Check-in Successful',
                    message: 'Boarding pass is ready. Have a nice flight.',
                    primaryButton: {
                      value: 'Done',
                      action: () => {
                        this.showDialog = false
                      }
                    }
                  })
                })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: 'rgba(0, 0, 0, 0.16)',
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .scrollable(ScrollDirection.Vertical)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
