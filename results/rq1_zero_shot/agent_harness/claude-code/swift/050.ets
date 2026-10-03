@Entry
@Component
struct FlightCheckinPage {
  @State name: string = '';
  @State code: string = '';
  @State selectedSeat: number = 0;
  @State showDialog: boolean = false;

  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  private seatNumber(index: number): string {
    if (index === 0) {
      return '23C';
    } else if (index === 1) {
      return '11A';
    } else {
      return '2F';
    }
  }

  build() {
    Stack() {
      LinearGradient({
        colors: [AppTokens.Colors.tertiary + '40', AppTokens.Colors.background, AppTokens.Colors.secondary + '33'],
        direction: GradientDirection.Bottom
      })
      .width('100%')
      .height('100%')

      Column({ space: 0 }) {
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(AppTokens.Colors.primary)
            .margin({ left: AppTokens.Spacing.lg })

          Blank()

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
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
            // Passenger & Booking Card
            Column() {
              Text('Passenger')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .margin({ bottom: AppTokens.Spacing.lg })

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(14)
                .fontColor(AppTokens.Colors.onSurface)
                .placeholderColor(AppTokens.Colors.outline)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .margin({ bottom: AppTokens.Spacing.lg })
                .onChange((value: string) => {
                  this.name = value;
                })

              Text('Booking Code')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .margin({ bottom: AppTokens.Spacing.lg })

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(14)
                .fontColor(AppTokens.Colors.onSurface)
                .placeholderColor(AppTokens.Colors.outline)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .margin({ bottom: AppTokens.Spacing.lg })
                .onChange((value: string) => {
                  this.code = value;
                })

              Text('Seat Class')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .margin({ bottom: AppTokens.Spacing.md })

              SegmentedControl({
                selectedIndex: $selectedSeat,
                labels: this.seatTabs
              })
            }
            .width('100%')
            .padding(AppTokens.Spacing.xl)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: '#000000' + this.opacityToHex(AppTokens.ElevationMapping.level2.opacity),
              offsetY: AppTokens.ElevationMapping.level2.dy
            })

            // Flight Details Card
            Column({ space: AppTokens.Spacing.md }) {
              Row() {
                Column({ space: AppTokens.Spacing.xs }) {
                  Text('Flight')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(14)
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
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('12:35')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column() {
                  Text('Gate')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('A12')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column() {
                  Text('Seat')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

              Button('Confirm Check-in')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .width('100%')
                .height(52)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .borderRadius(AppTokens.Shapes.largeCornerRadius)
                .onClick(() => {
                  this.showDialog = true;
                })
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: '#000000' + this.opacityToHex(AppTokens.ElevationMapping.level2.opacity),
              offsetY: AppTokens.ElevationMapping.level2.dy
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .flexGrow(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      if (this.showDialog) {
        Column() {
          Text('Check-in Successful')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md })

          Text('Boarding pass is ready. Have a nice flight.')
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.lg })

          Button('Done')
            .width('100%')
            .height(44)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .onClick(() => {
              this.showDialog = false;
            })
        }
        .width('80%')
        .padding(AppTokens.Spacing.xl)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .shadow({
          radius: 12,
          color: '#00000040',
          offsetY: 6
        })
      }
    }
    .width('100%')
    .height('100%')
  }

  private opacityToHex(opacity: number): string {
    const val = Math.round(opacity * 255).toString(16).toUpperCase();
    return val.length === 1 ? '0' + val : val;
  }
}

@Component
struct SegmentedControl {
  @Link selectedIndex: number;
  @State labels: string[] = [];

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Row({ space: AppTokens.Spacing.xs }) {
          if (this.selectedIndex === index) {
            Text('✓')
              .fontSize(14)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onPrimary)
          }

          Text(label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedIndex === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(40)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.selectedIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .borderRadius(this.getRadius(index))
        .onClick(() => {
          this.selectedIndex = index;
        })
      }, (label: string, index: number) => label + index.toString())
    }
    .width('100%')
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.mediumCornerRadius })
  }

  private getRadius(index: number): BorderRadiuses {
    const radius = AppTokens.Shapes.mediumCornerRadius;
    if (this.labels.length === 1) {
      return { topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius };
    } else if (index === 0) {
      return { topLeft: radius, topRight: 0, bottomLeft: radius, bottomRight: 0 };
    } else if (index === this.labels.length - 1) {
      return { topLeft: 0, topRight: radius, bottomLeft: 0, bottomRight: radius };
    } else {
      return { topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0 };
    }
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF1E3A8A';
    export const secondary: string = '#FF2563EB';
    export const tertiary: string = '#FF60A5FA';
    export const background: string = '#FFF5F8FF';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFE8EEFA';
    export const outline: string = '#FFCBD5E1';
    export const success: string = '#FF16A34A';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FFFFFFFF';
    export const onTertiary: string = '#FF0B1220';
    export const onBackground: string = '#FF0B1220';
    export const onSurface: string = '#FF0B1220';
  }

  export namespace Shapes {
    export const smallCornerRadius: number = 8;
    export const mediumCornerRadius: number = 12;
    export const largeCornerRadius: number = 18;
  }

  export namespace Spacing {
    export const xs: number = 6;
    export const sm: number = 10;
    export const md: number = 14;
    export const lg: number = 18;
    export const xl: number = 26;
    export const xxl: number = 36;
  }

  export interface ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
    export const level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.16 };
    export const level3: ShadowSpec = { elevation: 10, radius: 12, dy: 6, opacity: 0.18 };
  }
}
