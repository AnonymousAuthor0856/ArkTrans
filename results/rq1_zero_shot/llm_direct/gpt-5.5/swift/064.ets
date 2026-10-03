type VoidCallback = () => void;

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#2A2A2A';
  static readonly tertiary: string = '#444444';
  static readonly background: string = '#F7F7F7';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDEDED';
  static readonly outline: string = '#D6D6D6';
  static readonly success: string = '#1E7D4C';
  static readonly warning: string = '#B98400';
  static readonly error: string = '#B3261E';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0A0A0A';
  static readonly onSurface: string = '#0A0A0A';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;

  static readonly displayWeight: number = 600;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16);
}

class AppTokens {
  static readonly gridLines: number[] = [0, 1, 2, 3, 4, 5];

  static shadowColor(opacity: number): string {
    return `rgba(0, 0, 0, ${opacity})`;
  }
}

class ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;

  constructor(id: number, title: string, status: string, x: number, y: number) {
    this.id = id;
    this.title = title;
    this.status = status;
    this.x = x;
    this.y = y;
  }
}

@Builder
function EmptyBuilder() {
}

@Component
struct FilterChipView {
  text: string = '';
  isSelected: boolean = false;
  onTap: VoidCallback = () => {
  };

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.text)
        .fontSize(this.isSelected ? AppTypography.titleSize : AppTypography.bodySize)
        .fontWeight(this.isSelected ? AppTypography.titleWeight : AppTypography.bodyWeight)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
    }
    .padding(0)
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.small)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.small
    })
    .stateEffect(false)
    .onClick(() => {
      this.onTap();
    })
  }
}

@Component
struct CardView {
  elevation: ShadowSpec = AppElevationMapping.level1;
  cornerRadius: number = AppShapes.small;
  borderWidth: number = 1;
  borderColor: string = AppColors.outline;
  showBorder: boolean = true;
  onClick?: VoidCallback;
  @BuilderParam content: () => void = EmptyBuilder;

  build() {
    Row() {
      this.content();
    }
    .backgroundColor(AppColors.surface)
    .borderRadius(this.cornerRadius)
    .shadow({
      radius: this.elevation.radius,
      color: AppTokens.shadowColor(this.elevation.opacity),
      offsetX: 0,
      offsetY: this.elevation.dy
    })
    .border({
      width: this.showBorder ? this.borderWidth : 0,
      color: this.borderColor,
      radius: this.cornerRadius
    })
    .onClick(() => {
      if (this.onClick) {
        this.onClick();
      }
    })
  }
}

@Component
struct MapPinView {
  pin: ApprovalPin = new ApprovalPin(0, '', '', 0, 0);
  selected: boolean = false;
  onClick: VoidCallback = () => {
  };

  private statusColor(): string {
    switch (this.pin.status) {
      case 'Approved':
        return AppColors.success;
      case 'Pending':
        return AppColors.warning;
      case 'Rejected':
        return AppColors.error;
      default:
        return '#808080';
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.statusColor())
        .stroke({
          width: 2,
          color: this.selected ? AppColors.primary : AppColors.surface
        })

      CardView({
        elevation: AppElevationMapping.level1,
        cornerRadius: AppShapes.small,
        onClick: this.onClick,
        content: () => {
          Text(this.pin.title)
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onSurface)
            .padding({
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              top: AppSpacing.xs,
              bottom: AppSpacing.xs
            })
        }
      })
        .offset({
          x: 18,
          y: -4
        })
    }
    .width(220)
    .height(44)
    .onClick(() => {
      this.onClick();
    })
  }
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      Column() {
        ForEach(AppTokens.gridLines, (_: number) => {
          Blank()
            .layoutWeight(1)

          Divider()
            .height(1)
            .backgroundColor(AppColors.surfaceVariant)
        })

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg
      })

      Row() {
        ForEach(AppTokens.gridLines, (_: number) => {
          Blank()
            .layoutWeight(1)

          Divider()
            .vertical(true)
            .width(1)
            .backgroundColor(AppColors.surfaceVariant)
        })

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved'];
  @State activeFilters: string[] = ['Pending'];
  @State pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.18, 0.35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.33, 0.72)
  ];
  @State selectedPinId: number = -1;

  private toggleFilter(filter: string): void {
    if (this.activeFilters.includes(filter)) {
      this.activeFilters = this.activeFilters.filter((item: string) => item !== filter);
    } else {
      this.activeFilters = [...this.activeFilters, filter];
    }
  }

  private toggleSelectedPin(id: number): void {
    this.selectedPinId = this.selectedPinId === id ? -1 : id;
  }

  private visiblePins(): ApprovalPin[] {
    return this.pins.filter((pin: ApprovalPin) => {
      switch (pin.status) {
        case 'Pending':
          return this.activeFilters.includes('Pending');
        case 'Approved':
          return this.activeFilters.includes('Approved');
        case 'Rejected':
          return true;
        default:
          return true;
      }
    });
  }

  private selectedPin(): ApprovalPin | undefined {
    return this.pins.find((pin: ApprovalPin) => pin.id === this.selectedPinId);
  }

  private selectedPinTitle(): string {
    const pin = this.selectedPin();
    return pin ? pin.title : '';
  }

  private selectedPinStatus(): string {
    const pin = this.selectedPin();
    return pin ? pin.status : '';
  }

  build() {
    Stack() {
      Column() {
        Column() {
          Text('Approval Flow')
            .fontSize(AppTypography.displaySize)
            .fontWeight(AppTypography.displayWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding({
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  FilterChipView({
                    text: filter,
                    isSelected: this.activeFilters.includes(filter),
                    onTap: () => {
                      this.toggleFilter(filter);
                    }
                  })
                }, (filter: string) => filter)
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.md
            })

            GeometryReader((geometry: GeometryProxy) => {
              Stack({ alignContent: Alignment.TopStart }) {
                MapGridOverlay()

                ForEach(this.visiblePins(), (pin: ApprovalPin) => {
                  MapPinView({
                    pin: pin,
                    selected: this.selectedPinId === pin.id,
                    onClick: () => {
                      this.toggleSelectedPin(pin.id);
                    }
                  })
                    .position({
                      x: geometry.size.width * pin.x,
                      y: geometry.size.height * pin.y
                    })
                }, (pin: ApprovalPin) => pin.id.toString())

                if (this.selectedPinId !== -1) {
                  Column() {
                    Blank()
                      .layoutWeight(1)

                    CardView({
                      elevation: AppElevationMapping.level3,
                      cornerRadius: AppShapes.large,
                      borderWidth: 1,
                      borderColor: AppColors.outline,
                      content: () => {
                        Row() {
                          Column({ space: AppSpacing.xs }) {
                            Text(this.selectedPinTitle())
                              .fontSize(AppTypography.titleSize)
                              .fontWeight(AppTypography.titleWeight)
                              .fontColor(AppColors.onSurface)

                            Text(this.selectedPinStatus())
                              .fontSize(AppTypography.labelSize)
                              .fontWeight(AppTypography.labelWeight)
                              .fontColor(AppColors.onSurface)
                          }
                          .alignItems(HorizontalAlign.Start)
                          .layoutWeight(1)

                          Row({ space: AppSpacing.sm }) {
                            Button({ type: ButtonType.Normal }) {
                              Text('Details')
                                .fontSize(AppTypography.labelSize)
                                .fontWeight(AppTypography.labelWeight)
                                .fontColor(AppColors.onSurface)
                                .padding({
                                  left: AppSpacing.md,
                                  right: AppSpacing.md
                                })
                            }
                            .height(40)
                            .padding(0)
                            .backgroundColor(AppColors.surfaceVariant)
                            .borderRadius(AppShapes.medium)
                            .stateEffect(false)
                          }
                        }
                        .alignItems(VerticalAlign.Center)
                        .width('100%')
                        .padding(AppSpacing.lg)
                      }
                    })
                      .width('100%')
                      .margin(AppSpacing.md)
                  }
                  .width('100%')
                  .height('100%')
                }
              }
              .width('100%')
              .height('100%')
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.large)
              .border({
                width: 1,
                color: AppColors.outline,
                radius: AppShapes.large
              })
            })
              .width('100%')
              .constraintSize({
                minHeight: 360
              })
              .aspectRatio(0.9)
              .padding({
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                bottom: AppSpacing.md
              })
          }
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')

        Column() {
          Row({ space: AppSpacing.md }) {
            Button({ type: ButtonType.Normal }) {
              Text('Reject')
                .fontSize(AppTypography.titleSize)
                .fontWeight(AppTypography.titleWeight)
                .fontColor(AppColors.onSurface)
            }
            .height(48)
            .layoutWeight(1)
            .padding(0)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
            .enabled(this.selectedPinId !== -1)
            .stateEffect(false)

            Button({ type: ButtonType.Normal }) {
              Text('Approve')
                .fontSize(AppTypography.titleSize)
                .fontWeight(AppTypography.titleWeight)
                .fontColor(AppColors.onPrimary)
            }
            .height(48)
            .layoutWeight(1)
            .padding(0)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .enabled(this.selectedPinId !== -1)
            .stateEffect(false)
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
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: AppElevationMapping.level2.radius,
          color: AppTokens.shadowColor(AppElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
          .layoutWeight(1)

        Row() {
          Blank()
            .layoutWeight(1)

          Button({ type: ButtonType.Circle }) {
            Text('+')
              .fontSize(AppTypography.headlineSize)
              .fontWeight(AppTypography.headlineWeight)
              .fontColor(AppColors.onPrimary)
          }
          .width(56)
          .height(56)
          .backgroundColor(AppColors.primary)
          .stateEffect(false)
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Entry
@Component
struct ApprovalFlowApp {
  build() {
    RootScreen()
  }
}