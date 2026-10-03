// AppTokens Definition
class AppColors {
  primary: string = '#FF1E3A8A';
  secondary: string = '#FF2563EB';
  tertiary: string = '#FF60A5FA';
  background: string = '#FFF5F8FF';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFE8EEFA';
  outline: string = '#FFCBD5E1';
  success: string = '#FF16A34A';
  warning: string = '#FFF59E0B';
  error: string = '#FFEF4444';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FFFFFFFF';
  onTertiary: string = '#FF0B1220';
  onBackground: string = '#FF0B1220';
  onSurface: string = '#FF0B1220';
}

class AppTypography {
  display: FontConfig = { size: 28, weight: FontWeight.Bold };
  headline: FontConfig = { size: 20, weight: FontWeight.Medium };
  title: FontConfig = { size: 16, weight: FontWeight.Medium };
  body: FontConfig = { size: 14, weight: FontWeight.Normal };
  label: FontConfig = { size: 12, weight: FontWeight.Medium };
}

class AppShapes {
  small: number = 8;
  medium: number = 12;
  large: number = 18;
}

class AppSpacing {
  xs: number = 6;
  sm: number = 10;
  md: number = 14;
  lg: number = 18;
  xl: number = 26;
  xxl: number = 36;
}

class AppElevation {
  level1: ShadowConfig = { radius: 4, dy: 2, opacity: 0.12 };
  level2: ShadowConfig = { radius: 8, dy: 4, opacity: 0.16 };
  level3: ShadowConfig = { radius: 12, dy: 6, opacity: 0.18 };
}

interface FontConfig {
  size: number;
  weight: FontWeight;
}

interface ShadowConfig {
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Typography: AppTypography = new AppTypography();
  static Shapes: AppShapes = new AppShapes();
  static Spacing: AppSpacing = new AppSpacing();
  static Elevation: AppElevation = new AppElevation();
}

// Custom Segmented Control Component
@Component
export struct SegmentedControl {
  @Link selectedIndex: number;
  private labels: string[] = [];

  build() {
    Row({ space: 0 }) {
      ForEach(this.labels, (label: string, index?: number) => {
        Button({ type: ButtonType.Normal }) {
          Row({ space: AppTokens.Spacing.xs }) {
            if (index === this.selectedIndex) {
              Image($r('sys.symbol.checkmark'))
                .width(14)
                .height(14)
                .fillColor(AppTokens.Colors.onPrimary)
            }
            
            Text(label)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(index === this.selectedIndex ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(40)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(index === this.selectedIndex ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .borderRadius(this.getSegmentRadius(index || 0))
        }
        .onClick(() => {
          if (index !== undefined) {
            this.selectedIndex = index;
          }
        })
        .layoutWeight(1)
        .padding(0)
        .margin(0)
      })
    }
    .width('100%')
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .clip(true)
  }

  private getSegmentRadius(index: number): number {
    const radius = AppTokens.Shapes.medium;
    if (this.labels.length === 1) {
      return radius;
    } else if (index === 0) {
      return radius;
    } else if (index === this.labels.length - 1) {
      return radius;
    } else {
      return 0;
    }
  }
}

// Root Screen
@Entry
@Component
struct RootScreen {
  @State private name: string = '';
  @State private code: string = '';
  @State private selectedSeat: number = 0;
  @State private showDialog: boolean = false;

  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Gradient
      Column() {
        // Gradient Layer
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [AppTokens.Colors.tertiary, 0.25],
              [AppTokens.Colors.background, 1.0],
              [AppTokens.Colors.secondary, 0.2]
            ]
          })
      }
      .width('100%')
      .height('100%')

      // Main Content
      Column({ space: 0 }) {
        // Header
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

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Passenger & Booking Card
            Column({ space: AppTokens.Spacing.lg }) {
              Text('Passenger')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: 'Full name', text: this.name })
                .onChange((value: string) => {
                  this.name = value;
                })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .border({ width: 1, color: AppTokens.Colors.outline })

              Text('Booking Code')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .onChange((value: string) => {
                  this.code = value;
                })
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
                .border({ width: 1, color: AppTokens.Colors.outline })

              Text('Seat Class')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              SegmentedControl({ selectedIndex: $selectedSeat, labels: this.seatTabs })
            }
            .width('100%')
            .padding(AppTokens.Spacing.xl)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level2.radius,
              color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.Elevation.level2.dy
            })

            // Flight Details Card
            Column({ space: AppTokens.Spacing.md }) {
              // Flight Info Row
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

              // Boarding Details Row
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
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

              // Confirm Button
              Button() {
                Text('Confirm Check-in')
                  .fontSize(AppTokens.Typography.title.size)
                  .fontWeight(AppTokens.Typography.title.weight)
                  .fontColor(AppTokens.Colors.onPrimary)
              }
              .onClick(() => {
                this.showDialog = true;
              })
              .width('100%')
              .height(52)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.large)
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level2.radius,
              color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.Elevation.level2.dy
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .bindContentCover(this.showDialog, this.alertDialogBuilder)
  }

  @Builder
  alertDialogBuilder() {
    Column() {
      // Empty builder, actual alert is handled by AlertDialog.show()
    }
  }

  aboutToAppear() {
    // No-op
  }

  private seatNumber(index: number): string {
    if (index === 0) {
      return '23C';
    } else if (index === 1) {
      return '11A';
    } else {
      return '2F';
    }
  }

  private showAlertDialog() {
    AlertDialog.show({
      title: 'Check-in Successful',
      message: 'Boarding pass is ready. Have a nice flight.',
      confirm: {
        value: 'Done',
        action: () => {
          this.showDialog = false;
        }
      },
      cancel: () => {
        this.showDialog = false;
      }
    });
  }
}