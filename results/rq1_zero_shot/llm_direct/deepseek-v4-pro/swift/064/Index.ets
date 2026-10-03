// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#444444',
    background: '#F7F7F7',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDED',
    outline: '#D6D6D6',
    success: '#1E7D4C',
    warning: '#B98400',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A'
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Medium },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16
  };

  static readonly Elevation = {
    level1: { radius: 4, offsetY: 2, opacity: 0.10 },
    level2: { radius: 8, offsetY: 4, opacity: 0.14 },
    level3: { radius: 12, offsetY: 6, opacity: 0.16 }
  };
}

// ApprovalPin.ets
export class ApprovalPin {
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

// FilterChipView.ets
@Component
export struct FilterChipView {
  @Prop text: string;
  @Prop isSelected: boolean;
  onTap: () => void = () => {};

  build() {
    Button() {
      Text(this.text)
        .fontSize(this.isSelected ? AppTokens.Typography.title.fontSize : AppTokens.Typography.body.fontSize)
        .fontWeight(this.isSelected ? AppTokens.Typography.title.fontWeight : AppTokens.Typography.body.fontWeight)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .padding({
          left: AppTokens.Spacing.sm,
          right: AppTokens.Spacing.sm,
          top: AppTokens.Spacing.xs,
          bottom: AppTokens.Spacing.xs
        })
    }
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
    .onClick(() => {
      this.onTap();
    })
  }
}

// CardView.ets
@Component
export struct CardView {
  @Prop elevationRadius: number = AppTokens.Elevation.level1.radius;
  @Prop elevationOffsetY: number = AppTokens.Elevation.level1.offsetY;
  @Prop elevationOpacity: number = AppTokens.Elevation.level1.opacity;
  @Prop cornerRadius: number = AppTokens.Shapes.small;
  @Prop hasBorder: boolean = true;
  @Prop borderColor: string = AppTokens.Colors.outline;
  @Prop borderWidth: number = 1;
  onClick: () => void = () => {};
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(this.cornerRadius)
    .shadow({
      radius: this.elevationRadius,
      color: `rgba(0, 0, 0, ${this.elevationOpacity})`,
      offsetY: this.elevationOffsetY,
      offsetX: 0
    })
    .border(this.hasBorder ? {
      width: this.borderWidth,
      color: this.borderColor
    } : undefined)
    .onClick(() => {
      this.onClick();
    })
  }
}

// MapPinView.ets
@Component
export struct MapPinView {
  @Prop pin: ApprovalPin;
  @Prop selected: boolean;
  onClick: () => void = () => {};

  private getBaseColor(): string {
    switch (this.pin.status) {
      case 'Approved':
        return AppTokens.Colors.success;
      case 'Pending':
        return AppTokens.Colors.warning;
      case 'Rejected':
        return AppTokens.Colors.error;
      default:
        return '#808080';
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin circle
      Circle()
        .fill(this.getBaseColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .stroke(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
        .strokeWidth(2)

      // Info card next to pin
      Column() {
        Text(this.pin.title)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs
          })
      }
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .shadow({
        radius: AppTokens.Elevation.level1.radius,
        color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
        offsetY: AppTokens.Elevation.level1.offsetY,
        offsetX: 0
      })
      .border({
        width: 1,
        color: AppTokens.Colors.outline
      })
      .offset({ x: 18, y: -4 })
      .onClick(() => {
        this.onClick();
      })
    }
  }
}

// MapGridOverlay.ets
@Component
export struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal grid lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
          Blank()
            .layoutWeight(1)
          Rect()
            .fill(AppTokens.Colors.surfaceVariant)
            .height(1)
            .width('100%')
        })
        Blank()
          .layoutWeight(1)
      }
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg
      })

      // Vertical grid lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (item: number) => {
          Blank()
            .layoutWeight(1)
          Rect()
            .fill(AppTokens.Colors.surfaceVariant)
            .width(1)
            .height('100%')
        })
        Blank()
          .layoutWeight(1)
      }
      .padding({
        top: AppTokens.Spacing.lg,
        bottom: AppTokens.Spacing.lg
      })
    }
  }
}

// RootScreen.ets
@Entry
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

  private isPinVisible(pin: ApprovalPin): boolean {
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
  }

  private toggleFilter(filter: string): void {
    const index = this.activeFilters.indexOf(filter);
    if (index >= 0) {
      this.activeFilters.splice(index, 1);
    } else {
      this.activeFilters.push(filter);
    }
  }

  private getSelectedPin(): ApprovalPin | undefined {
    return this.pins.find(p => p.id === this.selectedPinId);
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main content
      Column() {
        // Top bar
        Column() {
          Text('Approval Flow')
            .fontSize(AppTokens.Typography.display.fontSize)
            .fontWeight(AppTokens.Typography.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filter chips row
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  FilterChipView({
                    text: filter,
                    isSelected: this.activeFilters.includes(filter),
                    onTap: () => {
                      this.toggleFilter(filter);
                    }
                  })
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.md
            })

            // Map area
            Stack() {
              MapGridOverlay()

              // Approval pins
              ForEach(this.pins.filter(p => this.isPinVisible(p)), (pin: ApprovalPin) => {
                MapPinView({
                  pin: pin,
                  selected: this.selectedPinId === pin.id,
                  onClick: () => {
                    this.selectedPinId = this.selectedPinId === pin.id ? -1 : pin.id;
                  }
                })
                .offset({
                  x: 300 * pin.x,
                  y: 360 * pin.y
                })
              })

              // Selected pin detail card
              if (this.selectedPinId >= 0 && this.getSelectedPin()) {
                Column() {
                  Blank()
                    .layoutWeight(1)
                  Column() {
                    Row() {
                      Column({ space: AppTokens.Spacing.xs }) {
                        Text(this.getSelectedPin()!.title)
                          .fontSize(AppTokens.Typography.title.fontSize)
                          .fontWeight(AppTokens.Typography.title.fontWeight)
                          .fontColor(AppTokens.Colors.onSurface)
                        Text(this.getSelectedPin()!.status)
                          .fontSize(AppTokens.Typography.label.fontSize)
                          .fontWeight(AppTokens.Typography.label.fontWeight)
                          .fontColor(AppTokens.Colors.onSurface)
                      }
                      .alignItems(HorizontalAlign.Start)

                      Blank()
                        .layoutWeight(1)

                      Button() {
                        Text('Details')
                          .fontSize(AppTokens.Typography.label.fontSize)
                          .fontWeight(AppTokens.Typography.label.fontWeight)
                          .fontColor(AppTokens.Colors.onSurface)
                          .padding({
                            left: AppTokens.Spacing.md,
                            right: AppTokens.Spacing.md
                          })
                      }
                      .height(40)
                      .backgroundColor(AppTokens.Colors.surfaceVariant)
                      .borderRadius(AppTokens.Shapes.medium)
                    }
                    .width('100%')
                    .alignItems(VerticalAlign.Center)
                    .padding(AppTokens.Spacing.lg)
                  }
                  .width('100%')
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.large)
                  .shadow({
                    radius: AppTokens.Elevation.level3.radius,
                    color: `rgba(0, 0, 0, ${AppTokens.Elevation.level3.opacity})`,
                    offsetY: AppTokens.Elevation.level3.offsetY,
                    offsetX: 0
                  })
                  .border({
                    width: 1,
                    color: AppTokens.Colors.outline
                  })
                  .padding(AppTokens.Spacing.md)
                }
                .width('100%')
                .height('100%')
              }
            }
            .width('100%')
            .height(360)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 1,
              color: AppTokens.Colors.outline
            })
            .padding({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              bottom: AppTokens.Spacing.md
            })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Bottom bar
        Column() {
          Row({ space: AppTokens.Spacing.md }) {
            Button() {
              Text('Reject')
                .fontSize(AppTokens.Typography.title.fontSize)
                .fontWeight(AppTokens.Typography.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .enabled(this.selectedPinId >= 0)

            Button() {
              Text('Approve')
                .fontSize(AppTokens.Typography.title.fontSize)
                .fontWeight(AppTokens.Typography.title.fontWeight)
                .fontColor(AppTokens.Colors.onPrimary)
                .width('100%')
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .enabled(this.selectedPinId >= 0)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
          offsetY: AppTokens.Elevation.level2.offsetY,
          offsetX: 0
        })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Column() {
        Blank()
          .layoutWeight(1)
        Row() {
          Blank()
            .layoutWeight(1)
          Button() {
            Text('+')
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width(56)
              .height(56)
              .textAlign(TextAlign.Center)
          }
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(28)
          .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}