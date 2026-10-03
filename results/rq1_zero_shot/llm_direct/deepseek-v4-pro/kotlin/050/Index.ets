import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State name: string = '';
  @State code: string = '';
  @State selectedSeat: number = 0;
  @State showDialog: boolean = false;
  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  // AppTokens
  private readonly colors = {
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
  };

  private readonly spacing = {
    xs: 6,
    sm: 10,
    md: 14,
    lg: 18,
    xl: 26,
    xxl: 36
  };

  private readonly radius = {
    small: 8,
    medium: 12,
    large: 18
  };

  private getSeatLabel(): string {
    if (this.selectedSeat === 0) return '23C';
    if (this.selectedSeat === 1) return '11A';
    return '2F';
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [[this.colors.tertiary + '40', 0], [this.colors.background, 0.5], [this.colors.secondary + '33', 1]]
        })

      Column() {
        // Top App Bar
        Row() {
          // Navigation icon
          Row()
            .width(22)
            .height(22)
            .margin({ left: this.spacing.lg })
            .borderRadius(11)
            .backgroundColor(this.colors.primary)

          Blank()
            .layoutWeight(1)

          // Title
          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colors.onSurface)

          Blank()
            .layoutWeight(1)

          // Action icon
          Row()
            .width(22)
            .height(22)
            .margin({ right: this.spacing.lg })
            .borderRadius(11)
            .backgroundColor(this.colors.secondary)
        }
        .width('100%')
        .height(56)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column({ space: this.spacing.lg }) {
            // Passenger Card
            Column({ space: this.spacing.md }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)

              TextInput({ placeholder: 'Full name', text: this.name })
                .width('100%')
                .height(48)
                .backgroundColor(this.colors.surfaceVariant)
                .borderRadius(this.radius.medium)
                .fontSize(14)
                .fontColor(this.colors.onSurface)
                .placeholderColor(this.colors.onSurface + '80')
                .onChange((value: string) => {
                  this.name = value;
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .width('100%')
                .height(48)
                .backgroundColor(this.colors.surfaceVariant)
                .borderRadius(this.radius.medium)
                .fontSize(14)
                .fontColor(this.colors.onSurface)
                .placeholderColor(this.colors.onSurface + '80')
                .onChange((value: string) => {
                  this.code = value;
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)

              // Segmented buttons
              Row({ space: 4 }) {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Text(label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedSeat === index ? this.colors.onPrimary : this.colors.onSurface)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                    .height(40)
                    .backgroundColor(this.selectedSeat === index ? this.colors.primary : this.colors.surfaceVariant)
                    .borderRadius(index === 0 ? this.radius.medium : index === this.seatTabs.length - 1 ? this.radius.medium : 0)
                    .onClick(() => {
                      this.selectedSeat = index;
                    })
                })
              }
              .width('100%')
            }
            .width('100%')
            .padding(this.spacing.lg)
            .backgroundColor(this.colors.surface)
            .borderRadius(this.radius.large)
            .shadow({
              radius: 8,
              color: '#00000029',
              offsetX: 0,
              offsetY: 4
            })

            // Flight Details Card
            Column({ space: this.spacing.md }) {
              // Flight row
              Row() {
                Column({ space: this.spacing.xs }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.onSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
                    .fontColor(this.colors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .layoutWeight(1)

                Row()
                  .width(36)
                  .height(36)
                  .borderRadius(18)
                  .backgroundColor(this.colors.secondary)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Boarding, Gate, Seat row
              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.onSurface)
                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .layoutWeight(1)

                Column() {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.onSurface)
                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.primary)
                }

                Blank()
                  .layoutWeight(1)

                Column() {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.onSurface)
                  Text(this.getSeatLabel())
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colors.primary)
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Confirm Button
              Button('Confirm Check-in')
                .width('100%')
                .height(52)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onPrimary)
                .backgroundColor(this.colors.primary)
                .borderRadius(this.radius.large)
                .onClick(() => {
                  this.showDialog = true;
                })
            }
            .width('100%')
            .padding(this.spacing.lg)
            .backgroundColor(this.colors.surface)
            .borderRadius(this.radius.large)
            .shadow({
              radius: 8,
              color: '#00000029',
              offsetX: 0,
              offsetY: 4
            })
          }
          .width('100%')
          .padding({
            left: this.spacing.lg,
            right: this.spacing.lg,
            top: this.spacing.md,
            bottom: this.spacing.md
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')

      // Alert Dialog
      if (this.showDialog) {
        Column() {
          Column({ space: this.spacing.md }) {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor(this.colors.onSurface)

            Button('Done')
              .width('100%')
              .height(40)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSecondary)
              .backgroundColor(this.colors.secondary)
              .borderRadius(this.radius.medium)
              .onClick(() => {
                this.showDialog = false;
              })
          }
          .width('80%')
          .padding(this.spacing.lg)
          .backgroundColor(this.colors.surface)
          .borderRadius(this.radius.large)
          .shadow({
            radius: 12,
            color: '#0000002E',
            offsetX: 0,
            offsetY: 6
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#00000080')
        .onClick(() => {
          this.showDialog = false;
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}