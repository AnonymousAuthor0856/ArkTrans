// 065FlightCheckinen.ets
// Travel - Modern Blue

// --- Design Tokens ---
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
  };
  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static readonly Spacing = {
    xs: 6,
    sm: 10,
    md: 14,
    lg: 18,
    xl: 26,
    xxl: 36,
  };
}

@Entry
@Component
struct FlightCheckin {
  @State name: string = '';
  @State code: string = '';
  @State selectedSeat: number = 0;
  @State showDialog: boolean = false;
  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.tertiary, 0.25],
            [AppTokens.Colors.background, 1.0],
            [AppTokens.Colors.secondary, 0.2],
          ],
        });

      // Main Content
      Column() {
        // Top App Bar
        Row() {
          // Navigation Icon
          Circle({ width: 22, height: 22 })
            .fill(AppTokens.Colors.primary)
            .margin({ left: AppTokens.Spacing.lg });

          // Title
          Text('Flight Check-in')
            .fontSize(AppTokens.TypographyTokens.display.fontSize)
            .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center);

          // Action Icon
          Circle({ width: 22, height: 22 })
            .fill(AppTokens.Colors.secondary)
            .margin({ right: AppTokens.Spacing.lg });
        }
        .width('100%')
        .height(56)
        .padding({ top: 12, bottom: 12 });

        // Scrollable Content Area
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Passenger & Booking Card
            Column() {
              Text('Passenger')
                .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: AppTokens.Spacing.md });

              // Name Input
              TextInput({ placeholder: 'Full name', text: this.name })
                .onChange((value: string) => {
                  this.name = value;
                })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(12)
                .height(48)
                .margin({ bottom: AppTokens.Spacing.md });

              Text('Booking Code')
                .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: AppTokens.Spacing.md });

              // Code Input
              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .onChange((value: string) => {
                  this.code = value;
                })
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(12)
                .height(48)
                .margin({ bottom: AppTokens.Spacing.md });

              Text('Seat Class')
                .fontSize(AppTokens.TypographyTokens.headline.fontSize)
                .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: AppTokens.Spacing.md });

              // Segmented Button Row
              Row() {
                ForEach(this.seatTabs, (label: string, index: number) => {
                  Text(label)
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .fontColor(this.selectedSeat === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .backgroundColor(this.selectedSeat === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                    .padding({ top: 10, bottom: 10, left: 12, right: 12 })
                    .layoutWeight(1)
                    .textAlign(TextAlign.Center)
                    .borderRadius(8)
                    .margin(index === 0 ? { right: 4 } : index === this.seatTabs.length - 1 ? { left: 4 } : { left: 4, right: 4 })
                    .onClick(() => {
                      this.selectedSeat = index;
                    });
                });
              }
              .width('100%');
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(18)
            .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 });

            // Flight Info Card
            Column({ space: AppTokens.Spacing.md }) {
              // Flight Row
              Row() {
                Column() {
                  Text('Flight')
                    .fontSize(AppTokens.TypographyTokens.title.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface);
                  Text('BL 213 • HND → CTS')
                    .fontSize(AppTokens.TypographyTokens.body.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.xs });
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1);

                Circle({ width: 36, height: 36 })
                  .fill(AppTokens.Colors.secondary);
              }
              .width('100%');

              // Details Row
              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface);
                  Text('12:35')
                    .fontSize(AppTokens.TypographyTokens.title.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                    .fontColor(AppTokens.Colors.primary)
                    .margin({ top: AppTokens.Spacing.xs });
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Center);

                Column() {
                  Text('Gate')
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface);
                  Text('A12')
                    .fontSize(AppTokens.TypographyTokens.title.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                    .fontColor(AppTokens.Colors.primary)
                    .margin({ top: AppTokens.Spacing.xs });
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Center);

                Column() {
                  Text('Seat')
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface);
                  Text(this.selectedSeat === 0 ? '23C' : this.selectedSeat === 1 ? '11A' : '2F')
                    .fontSize(AppTokens.TypographyTokens.title.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                    .fontColor(AppTokens.Colors.primary)
                    .margin({ top: AppTokens.Spacing.xs });
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Center);
              }
              .width('100%')
              .margin({ top: AppTokens.Spacing.md });

              // Confirm Button
              Button('Confirm Check-in')
                .width('100%')
                .height(52)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .borderRadius(18)
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                .onClick(() => {
                  this.showDialog = true;
                });
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(18)
            .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 });
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg });
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off);
      }
      .width('100%')
      .height('100%');

      // Alert Dialog
      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          // Scrim
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')
            .onClick(() => {
              this.showDialog = false;
            });

          // Dialog Content
          Column() {
            Text('Check-in Successful')
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md });

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.lg });

            Button('Done')
              .width('100%')
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .borderRadius(12)
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .onClick(() => {
                this.showDialog = false;
              });
          }
          .width('80%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(18);
        }
        .width('100%')
        .height('100%');
      }
    }
    .width('100%')
    .height('100%');
  }
}