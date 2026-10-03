import { router } from '@kit.ArkUI'

// App Design Tokens
const AppColors = {
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
  onSurface: '#0B1220',
}

const AppSpacing = {
  xs: 6,
  sm: 10,
  md: 14,
  lg: 18,
  xl: 26,
  xxl: 36,
}

@Entry
@Component
struct RootScreen {
  @State nameValue: string = ''
  @State codeValue: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  seatTabs: string[] = ['Economy', 'Premium', 'Business']

  getSeatLabel(): string {
    if (this.selectedSeat === 0) return '23C'
    if (this.selectedSeat === 1) return '11A'
    return '2F'
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background gradient
      Column() {
        // Top gradient area
        Column()
          .width('100%')
          .height('40%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [0x4060A5FA, 0.0],
              [0xFFF5F8FF, 1.0]
            ]
          })
        Column()
          .width('100%')
          .height('60%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [0xFFF5F8FF, 0.0],
              [0x332563EB, 1.0]
            ]
          })
      }
      .width('100%')
      .height('100%')

      // Main content
      Column() {
        // Top App Bar
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(AppColors.primary)
            .margin({ left: AppSpacing.lg })

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Circle({ width: 22, height: 22 })
            .fill(AppColors.secondary)
            .margin({ right: AppSpacing.lg })
        }
        .width('100%')
        .height(56)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Color.Transparent)

        // Scrollable content
        Scroll() {
          Column({ space: AppSpacing.lg }) {
            // Passenger Card
            Column({ space: AppSpacing.md }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              TextInput({ placeholder: 'Full name', text: this.nameValue })
                .width('100%')
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(12)
                .placeholderColor(AppColors.onSurface + '80')
                .fontColor(AppColors.onSurface)
                .onChange((value: string) => {
                  this.nameValue = value
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.codeValue })
                .width('100%')
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(12)
                .placeholderColor(AppColors.onSurface + '80')
                .fontColor(AppColors.onSurface)
                .onChange((value: string) => {
                  this.codeValue = value
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              // Segmented Button
              Row() {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Text(label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedSeat === index ? AppColors.onPrimary : AppColors.onSurface)
                    .backgroundColor(this.selectedSeat === index ? AppColors.primary : AppColors.surfaceVariant)
                    .layoutWeight(1)
                    .height(40)
                    .textAlign(TextAlign.Center)
                    .borderRadius(index === 0 ? 8 : index === this.seatTabs.length - 1 ? 8 : 0)
                    .border({
                      width: 1,
                      color: AppColors.outline,
                      style: BorderStyle.Solid
                    })
                    .onClick(() => {
                      this.selectedSeat = index
                    })
                })
              }
              .width('100%')
              .borderRadius(8)
              .clip(true)
            }
            .width('100%')
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(18)
            .shadow({
              radius: 8,
              color: '#29000000',
              offsetX: 0,
              offsetY: 4
            })

            // Flight Info Card
            Column({ space: AppSpacing.md }) {
              Row() {
                Column({ space: AppSpacing.xs }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(AppColors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Circle({ width: 36, height: 36 })
                  .fill(AppColors.secondary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
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

                Column() {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                  Text(this.getSeatLabel())
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Button('Confirm Check-in')
                .width('100%')
                .height(52)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
                .backgroundColor(AppColors.primary)
                .borderRadius(18)
                .onClick(() => {
                  this.showDialog = true
                })
            }
            .width('100%')
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(18)
            .shadow({
              radius: 8,
              color: '#29000000',
              offsetX: 0,
              offsetY: 4
            })
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.lg })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Alert Dialog
      if (this.showDialog) {
        Column() {
          Column({ space: AppSpacing.md }) {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)

            Row() {
              Button('Done')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSecondary)
                .backgroundColor(AppColors.secondary)
                .borderRadius(12)
                .onClick(() => {
                  this.showDialog = false
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('85%')
          .padding(AppSpacing.xl)
          .backgroundColor(AppColors.surface)
          .borderRadius(18)
          .shadow({
            radius: 12,
            color: '#33000000',
            offsetX: 0,
            offsetY: 6
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#80000000')
        .onClick(() => {
          this.showDialog = false
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}