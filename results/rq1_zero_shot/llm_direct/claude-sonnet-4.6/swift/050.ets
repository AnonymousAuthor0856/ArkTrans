import { router } from '@kit.ArkUI';

// MARK: - 1. AppTokens Definition

class AppColors {
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#2563EB';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F5F8FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E8EEFA';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
}

class AppSpacing {
  static readonly xs: number = 6;
  static readonly sm: number = 10;
  static readonly md: number = 14;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
  static readonly xxl: number = 36;
}

class AppShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 12;
  static readonly largeCornerRadius: number = 18;
}

class AppElevation {
  static readonly level1Radius: number = 4;
  static readonly level1Opacity: number = 0.12;
  static readonly level2Radius: number = 8;
  static readonly level2Opacity: number = 0.16;
  static readonly level2Dy: number = 4;
  static readonly level3Radius: number = 12;
  static readonly level3Opacity: number = 0.18;
}

// MARK: - 3. Custom Segmented Control

@Component
struct SegmentedControlView {
  @Link selectedIndex: number;
  labels: string[] = [];

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Button() {
          Row({ space: AppSpacing.xs }) {
            if (this.selectedIndex === index) {
              Text('✓')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
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
        .backgroundColor(this.selectedIndex === index ? AppColors.primary : AppColors.surfaceVariant)
        .borderRadius(this.getBorderRadius(index))
        .height(40)
        .layoutWeight(1)
        .onClick(() => {
          this.selectedIndex = index;
        })
        .type(ButtonType.Normal)
      }, (label: string, index: number) => index.toString())
    }
    .width('100%')
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.mediumCornerRadius })
    .clip(true)
    .borderRadius(AppShapes.mediumCornerRadius)
  }

  private getBorderRadius(index: number): BorderRadiuses {
    const r = AppShapes.mediumCornerRadius;
    if (this.labels.length === 1) {
      return { topLeft: r, topRight: r, bottomLeft: r, bottomRight: r };
    } else if (index === 0) {
      return { topLeft: r, topRight: 0, bottomLeft: r, bottomRight: 0 };
    } else if (index === this.labels.length - 1) {
      return { topLeft: 0, topRight: r, bottomLeft: 0, bottomRight: r };
    } else {
      return { topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0 };
    }
  }
}

// MARK: - 4. RootScreen

@Entry
@Component
struct RootScreen {
  @State private name: string = '';
  @State private code: string = '';
  @State private selectedSeat: number = 0;
  @State private showDialog: boolean = false;

  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  private seatNumber(index: number): string {
    if (index === 0) return '23C';
    else if (index === 1) return '11A';
    else return '2F';
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            ['#3F60A5FA', 0.0],
            [AppColors.background, 0.5],
            ['#332563EB', 1.0]
          ]
        })

      Column({ space: 0 }) {
        // Header
        Row() {
          Circle()
            .fill(AppColors.primary)
            .width(22)
            .height(22)
            .margin({ left: AppSpacing.lg })

          Blank()

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)

          Blank()

          Circle()
            .fill(AppColors.secondary)
            .width(22)
            .height(22)
            .margin({ right: AppSpacing.lg })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: AppSpacing.md })

        // Scrollable content
        Scroll() {
          Column({ space: AppSpacing.lg }) {

            // Passenger & Booking Card
            Column({ space: AppSpacing.lg }) {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(14)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.outline)
                .padding(AppSpacing.md)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.mediumCornerRadius)
                .border({ width: 1, color: AppColors.outline, radius: AppShapes.mediumCornerRadius })
                .width('100%')
                .onChange((value: string) => {
                  this.name = value;
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(14)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.outline)
                .padding(AppSpacing.md)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.mediumCornerRadius)
                .border({ width: 1, color: AppColors.outline, radius: AppShapes.mediumCornerRadius })
                .width('100%')
                .onChange((value: string) => {
                  this.code = value;
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              SegmentedControlView({
                selectedIndex: $selectedSeat,
                labels: this.seatTabs
              })
            }
            .alignItems(HorizontalAlign.Start)
            .padding(AppSpacing.xl)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: AppElevation.level2Radius,
              color: `rgba(0,0,0,${AppElevation.level2Opacity})`,
              offsetX: 0,
              offsetY: AppElevation.level2Dy
            })
            .width('100%')

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
                    .fontColor(AppColors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Circle()
                  .fill(AppColors.secondary)
                  .width(36)
                  .height(36)
              }
              .width('100%')
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.mediumCornerRadius)

              // Boarding / Gate / Seat row
              Row() {
                Column({ space: 2 }) {
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

                Column({ space: 2 }) {
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

                Column({ space: 2 }) {
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
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppShapes.largeCornerRadius)
                .width('100%')
                .height(52)
                .onClick(() => {
                  this.showDialog = true;
                })
            }
            .alignItems(HorizontalAlign.Start)
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: AppElevation.level2Radius,
              color: `rgba(0,0,0,${AppElevation.level2Opacity})`,
              offsetX: 0,
              offsetY: AppElevation.level2Dy
            })
            .width('100%')
          }
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Dialog overlay
      if (this.showDialog) {
        Column() {
          Column({ space: AppSpacing.lg }) {
            Text('Check-in Successful')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)
              .textAlign(TextAlign.Center)

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor(AppColors.onSurface)
              .textAlign(TextAlign.Center)

            Button('Done')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.largeCornerRadius)
              .width('100%')
              .height(48)
              .onClick(() => {
                this.showDialog = false;
              })
          }
          .padding(AppSpacing.xl)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.largeCornerRadius)
          .shadow({
            radius: 20,
            color: 'rgba(0,0,0,0.2)',
            offsetX: 0,
            offsetY: 8
          })
          .width('80%')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.4)')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {})
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}