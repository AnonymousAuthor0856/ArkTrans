/* ============================================================
 * entry/src/main/ets/pages/Index.ets
 * ============================================================ */

// MARK: - 1. Design tokens

class AppColors {
  static readonly primary: string = '#FF1E3A8A';
  static readonly secondary: string = '#FF2563EB';
  static readonly tertiary: string = '#FF60A5FA';
  static readonly background: string = '#FFF5F8FF';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE8EEFA';
  static readonly outline: string = '#FFCBD5E1';
  static readonly success: string = '#FF16A34A';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FF0B1220';
  static readonly onBackground: string = '#FF0B1220';
  static readonly onSurface: string = '#FF0B1220';
  // gradient stops (tertiary @25%, background, secondary @20%)
  static readonly gradientTop: string = '#4060A5FA';
  static readonly gradientMid: string = '#FFF5F8FF';
  static readonly gradientBottom: string = '#332563EB';
  // elevation level 2 shadow: black @ 0.16
  static readonly shadowLevel2: string = '#29000000';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 12;
  static readonly largeCornerRadius: number = 18;
}

class AppSpacing {
  static readonly xs: number = 6;
  static readonly sm: number = 10;
  static readonly md: number = 14;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
  static readonly xxl: number = 36;
}

class ElevationMapping {
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
}

// MARK: - 2. Segmented control with checkmark on the selected segment

@Component
struct SegmentedControl {
  @Link selectedIndex: number;
  @Prop labels: string[];

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Row({ space: AppSpacing.xs }) {
          if (this.selectedIndex === index) {
            Text('✓')
              .fontSize(AppTypography.body)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onPrimary)
          }
          Text(label)
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedIndex === index ? AppColors.onPrimary : AppColors.onSurface)
        }
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .height(40)
        .backgroundColor(this.selectedIndex === index ? AppColors.primary : AppColors.surfaceVariant)
        .borderRadius(AppShapes.mediumCornerRadius)
        .onClick(() => {
          this.selectedIndex = index;
        })
      }, (label: string, index: number) => `${label}-${index}`)
    }
    .width('100%')
    .borderRadius(AppShapes.mediumCornerRadius)
    .border({ width: 1, color: AppColors.outline })
    .clip(true)
  }
}

// MARK: - 3. Root screen

@Entry
@Component
struct Index {
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

  private openDialog(): void {
    this.showDialog = true;
    AlertDialog.show({
      title: 'Check-in Successful',
      message: 'Boarding pass is ready. Have a nice flight.',
      autoCancel: false,
      alignment: DialogAlignment.Center,
      confirm: {
        value: 'Done',
        fontColor: AppColors.primary,
        action: () => {
          this.showDialog = false;
        }
      }
    });
  }

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Circle({ width: 22, height: 22 })
            .fill(AppColors.primary)
            .margin({ left: AppSpacing.lg })

          Text('Flight Check-in')
            .fontSize(AppTypography.display)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .maxLines(1)
            .layoutWeight(1)

          Circle({ width: 22, height: 22 })
            .fill(AppColors.secondary)
            .margin({ right: AppSpacing.lg })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: AppSpacing.md })

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            // Passenger & booking card
            Column({ space: AppSpacing.lg }) {
              Text('Passenger')
                .fontSize(AppTypography.headline)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSurface)

              TextInput({ text: this.name, placeholder: 'Full name' })
                .fontSize(AppTypography.body)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.outline)
                .caretColor(AppColors.primary)
                .height(48)
                .width('100%')
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.mediumCornerRadius)
                .border({ width: 1, color: AppColors.outline })
                .onChange((value: string) => {
                  this.name = value;
                })

              Text('Booking Code')
                .fontSize(AppTypography.headline)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSurface)

              TextInput({ text: this.code, placeholder: 'e.g. XY7ZK2' })
                .fontSize(AppTypography.body)
                .fontColor(AppColors.onSurface)
                .placeholderColor(AppColors.outline)
                .caretColor(AppColors.primary)
                .height(48)
                .width('100%')
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.mediumCornerRadius)
                .border({ width: 1, color: AppColors.outline })
                .onChange((value: string) => {
                  this.code = value;
                })

              Text('Seat Class')
                .fontSize(AppTypography.headline)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSurface)

              SegmentedControl({ selectedIndex: $selectedSeat, labels: this.seatTabs })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(AppSpacing.xl)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: ElevationMapping.level2Radius,
              color: AppColors.shadowLevel2,
              offsetX: 0,
              offsetY: ElevationMapping.level2Dy
            })

            // Flight details card
            Column({ space: AppSpacing.md }) {
              Row() {
                Column({ space: AppSpacing.xs }) {
                  Text('Flight')
                    .fontSize(AppTypography.title)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(AppTypography.body)
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

              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(AppTypography.label)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                  Text('12:35')
                    .fontSize(AppTypography.title)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column() {
                  Text('Gate')
                    .fontSize(AppTypography.label)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                  Text('A12')
                    .fontSize(AppTypography.title)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column() {
                  Text('Seat')
                    .fontSize(AppTypography.label)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(AppTypography.title)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding({ top: AppSpacing.md, bottom: AppSpacing.md })

              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text('Confirm Check-in')
                  .fontSize(AppTypography.title)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onPrimary)
              }
              .width('100%')
              .height(52)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.largeCornerRadius)
              .onClick(() => {
                this.openDialog();
              })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: ElevationMapping.level2Radius,
              color: AppColors.shadowLevel2,
              offsetX: 0,
              offsetY: ElevationMapping.level2Dy
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
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.gradientTop, 0.0],
        [AppColors.gradientMid, 0.5],
        [AppColors.gradientBottom, 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}