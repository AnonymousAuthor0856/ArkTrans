import { router } from '@kit.ArkUI';

// MARK: - AppTokens
const AppTokens = {
  Colors: {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#444444',
    background: '#F7F7F7',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDEDED',
    outline: '#D6D6D6',
    success: '#1E7D4C',
    warning: '#B98400',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A',
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16,
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
  },
  Elevation: {
    level1: { radius: 4, dy: 2, opacity: 0.10 },
    level2: { radius: 8, dy: 4, opacity: 0.14 },
    level3: { radius: 12, dy: 6, opacity: 0.16 },
  },
};

// MARK: - Data Models
interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
}

// MARK: - FilterChipView
@Component
struct FilterChipView {
  text: string = '';
  isSelected: boolean = false;
  onTap: () => void = () => {};

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
      .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.sm,
        right: AppTokens.Spacing.sm,
        top: AppTokens.Spacing.xs,
        bottom: AppTokens.Spacing.xs,
      })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
      .onClick(() => {
        this.onTap();
      })
  }
}

// MARK: - MapPinView
@Component
struct MapPinView {
  pin: ApprovalPin = { id: 0, title: '', status: '', x: 0, y: 0 };
  selected: boolean = false;
  onClick: () => void = () => {};

  getPinColor(): string {
    switch (this.pin.status) {
      case 'Approved': return AppTokens.Colors.success;
      case 'Pending': return AppTokens.Colors.warning;
      case 'Rejected': return AppTokens.Colors.error;
      default: return '#888888';
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin circle
      Circle()
        .fill(this.getPinColor())
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface,
          radius: 999,
        })

      // Info card next to pin
      Text(this.pin.title)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({
          left: AppTokens.Spacing.sm,
          right: AppTokens.Spacing.sm,
          top: AppTokens.Spacing.xs,
          bottom: AppTokens.Spacing.xs,
        })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
        .shadow({
          radius: AppTokens.Elevation.level1.radius,
          color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.Elevation.level1.dy,
        })
        .offset({ x: 18, y: -4 })
        .onClick(() => {
          this.onClick();
        })
    }
    .alignContent(Alignment.TopStart)
  }
}

// MARK: - MapGridOverlay
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal grid lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
          Blank().flexGrow(1)
          Divider()
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
        })
        Blank().flexGrow(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Vertical grid lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
          Blank().flexGrow(1)
          Divider()
            .vertical(true)
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
        })
        Blank().flexGrow(1)
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved'];
  @State activeFilters: string[] = ['Pending'];
  @State pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 },
  ];
  @State selectedPinId: number | null = null;
  @State mapWidth: number = 0;
  @State mapHeight: number = 0;

  isFilterActive(filter: string): boolean {
    return this.activeFilters.indexOf(filter) >= 0;
  }

  toggleFilter(filter: string): void {
    const idx = this.activeFilters.indexOf(filter);
    if (idx >= 0) {
      const newFilters = this.activeFilters.filter(f => f !== filter);
      this.activeFilters = newFilters;
    } else {
      this.activeFilters = [...this.activeFilters, filter];
    }
  }

  shouldShowPin(pin: ApprovalPin): boolean {
    switch (pin.status) {
      case 'Pending': return this.activeFilters.indexOf('Pending') >= 0;
      case 'Approved': return this.activeFilters.indexOf('Approved') >= 0;
      case 'Rejected': return true;
      default: return true;
    }
  }

  getSelectedPin(): ApprovalPin | null {
    if (this.selectedPinId === null) return null;
    const found = this.pins.filter(p => p.id === this.selectedPinId);
    return found.length > 0 ? found[0] : null;
  }

  build() {
    Stack() {
      Column() {
        // Top App Bar
        Column() {
          Text('Approval Flow')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        // Scrollable content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filter chips
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (f: string) => {
                  FilterChipView({
                    text: f,
                    isSelected: this.isFilterActive(f),
                    onTap: () => {
                      this.toggleFilter(f);
                    },
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ top: AppTokens.Spacing.md })

            // Map area
            Stack() {
              MapGridOverlay()

              // Pins
              ForEach(this.pins.filter(p => this.shouldShowPin(p)), (p: ApprovalPin) => {
                MapPinView({
                  pin: p,
                  selected: this.selectedPinId === p.id,
                  onClick: () => {
                    this.selectedPinId = this.selectedPinId === p.id ? null : p.id;
                  },
                })
                  .position({
                    x: this.mapWidth * p.x,
                    y: this.mapHeight * p.y,
                  })
              })

              // Selected pin detail card
              if (this.selectedPinId !== null && this.getSelectedPin() !== null) {
                Column() {
                  Blank().flexGrow(1)
                  Row() {
                    Column({ space: AppTokens.Spacing.xs }) {
                      Text(this.getSelectedPin()!.title)
                        .fontSize(AppTokens.Typography.title.size)
                        .fontWeight(AppTokens.Typography.title.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                      Text(this.getSelectedPin()!.status)
                        .fontSize(AppTokens.Typography.label.size)
                        .fontWeight(AppTokens.Typography.label.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                    }
                    .alignItems(HorizontalAlign.Start)
                    .flexGrow(1)

                    Row({ space: AppTokens.Spacing.sm }) {
                      Text('Details')
                        .fontSize(AppTokens.Typography.label.size)
                        .fontWeight(AppTokens.Typography.label.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                        .height(40)
                        .backgroundColor(AppTokens.Colors.surfaceVariant)
                        .borderRadius(AppTokens.Shapes.medium)
                        .textAlign(TextAlign.Center)
                    }
                  }
                  .width('100%')
                  .padding(AppTokens.Spacing.lg)
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.large)
                  .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
                  .shadow({
                    radius: AppTokens.Elevation.level3.radius,
                    color: `rgba(0,0,0,${AppTokens.Elevation.level3.opacity})`,
                    offsetX: 0,
                    offsetY: AppTokens.Elevation.level3.dy,
                  })
                  .margin(AppTokens.Spacing.md)
                }
                .width('100%')
                .height('100%')
              }
            }
            .width('100%')
            .aspectRatio(0.9)
            .constraintSize({ minHeight: 360 })
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .padding({ bottom: AppTokens.Spacing.md })
            .onAreaChange((_oldValue, newValue) => {
              this.mapWidth = newValue.width as number;
              this.mapHeight = newValue.height as number;
            })
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)

        // Bottom Bar
        Column() {
          Row({ space: AppTokens.Spacing.md }) {
            Text('Reject')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .textAlign(TextAlign.Center)
              .height(48)
              .layoutWeight(1)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .opacity(this.selectedPinId === null ? 0.4 : 1.0)
              .enabled(this.selectedPinId !== null)

            Text('Approve')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .textAlign(TextAlign.Center)
              .height(48)
              .layoutWeight(1)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .opacity(this.selectedPinId === null ? 0.4 : 1.0)
              .enabled(this.selectedPinId !== null)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md,
          })
        }
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
          offsetX: 0,
          offsetY: -AppTokens.Elevation.level2.dy,
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Floating Action Button
      Column() {
        Blank().flexGrow(1)
        Row() {
          Blank().flexGrow(1)
          Text('+')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(56)
            .height(56)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(28)
            .margin(AppTokens.Spacing.lg)
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