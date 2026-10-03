// ============================================================
// AppTokens
// ============================================================
namespace AppTokens {
  export namespace Colors {
    export const primary = '#111111';
    export const secondary = '#2A2A2A';
    export const tertiary = '#444444';
    export const background = '#F7F7F7';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#EDEDED';
    export const outline = '#D6D6D6';
    export const success = '#1E7D4C';
    export const warning = '#B98400';
    export const error = '#B3261E';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#FFFFFF';
    export const onTertiary = '#FFFFFF';
    export const onBackground = '#0A0A0A';
    export const onSurface = '#0A0A0A';
  }

  export namespace Spacing {
    export const xs = 4;
    export const sm = 8;
    export const md = 12;
    export const lg = 16;
  }

  export namespace Shapes {
    export const small = 8;
    export const medium = 12;
    export const large = 16;
  }

  export namespace Typography {
    export const displaySize = 28;
    export const headlineSize = 20;
    export const titleSize = 16;
    export const bodySize = 14;
    export const labelSize = 12;
  }

  export class ElevationSpec {
    radius: number = 0;
    dy: number = 0;
    opacity: number = 0;
  }

  export namespace Elevation {
    export const level1: ElevationSpec = { radius: 4, dy: 2, opacity: 0.10 };
    export const level2: ElevationSpec = { radius: 8, dy: 4, opacity: 0.14 };
    export const level3: ElevationSpec = { radius: 12, dy: 6, opacity: 0.16 };
  }
}

// ============================================================
// Data Model
// ============================================================
class ApprovalPin {
  id: number = 0;
  title: string = '';
  status: string = '';
  x: number = 0;
  y: number = 0;
}

// ============================================================
// FilterChip Component
// ============================================================
@Component
struct FilterChipView {
  text: string = '';
  isSelected: boolean = false;
  onTap: () => void = () => {};

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? AppTokens.Typography.titleSize : AppTokens.Typography.bodySize)
      .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.sm,
        right: AppTokens.Spacing.sm,
        top: AppTokens.Spacing.xs,
        bottom: AppTokens.Spacing.xs
      })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
      .onClick(() => this.onTap())
  }
}

// ============================================================
// MapPin Component
// ============================================================
@Component
struct MapPinView {
  pin: ApprovalPin = new ApprovalPin();
  selected: boolean = false;
  onPinClick: () => void = () => {};

  private pinColor(): string {
    switch (this.pin.status) {
      case 'Approved': return AppTokens.Colors.success;
      case 'Pending': return AppTokens.Colors.warning;
      case 'Rejected': return AppTokens.Colors.error;
      default: return '#888888';
    }
  }

  build() {
    Row() {
      // Circle pin: use border to simulate stroke ring
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.pinColor())
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface,
          radius: this.selected ? 14 : 11
        })

      // Label card
      Text(this.pin.title)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({
          left: AppTokens.Spacing.sm,
          right: AppTokens.Spacing.sm,
          top: AppTokens.Spacing.xs,
          bottom: AppTokens.Spacing.xs
        })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
        .shadow({ radius: 4, offsetY: 2, color: '#1A000000' })
        .margin({ left: 4, top: -4 })
        .onClick(() => this.onPinClick())
    }
    .alignItems(VerticalAlign.Top)
  }
}

// ============================================================
// MapGridOverlay Component
// ============================================================
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_i: number) => {
          Blank().layoutWeight(1)
          Divider()
            .strokeWidth(1)
            .color(AppTokens.Colors.surfaceVariant)
        })
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Vertical lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_i: number) => {
          Blank().layoutWeight(1)
          Divider()
            .vertical(true)
            .strokeWidth(1)
            .color(AppTokens.Colors.surfaceVariant)
        })
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
  }
}

// ============================================================
// RootScreen
// ============================================================
@Entry
@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved'];
  @State activeFilters: string[] = ['Pending'];
  @State pins: ApprovalPin[] = (() => {
    const p1 = new ApprovalPin();
    p1.id = 1; p1.title = 'Purchase Order #1042'; p1.status = 'Pending'; p1.x = 0.18; p1.y = 0.35;
    const p2 = new ApprovalPin();
    p2.id = 2; p2.title = 'Travel Request #552'; p2.status = 'Approved'; p2.x = 0.52; p2.y = 0.42;
    const p3 = new ApprovalPin();
    p3.id = 3; p3.title = 'Contract #A77'; p3.status = 'Pending'; p3.x = 0.76; p3.y = 0.58;
    const p4 = new ApprovalPin();
    p4.id = 4; p4.title = 'Budget Change #09'; p4.status = 'Rejected'; p4.x = 0.33; p4.y = 0.72;
    return [p1, p2, p3, p4];
  })();
  @State selectedPinId: number = -1;
  @State mapWidth: number = 300;
  @State mapHeight: number = 360;

  private isFilterActive(f: string): boolean {
    return this.activeFilters.indexOf(f) >= 0;
  }

  private toggleFilter(f: string): void {
    const idx = this.activeFilters.indexOf(f);
    if (idx >= 0) {
      const copy = [...this.activeFilters];
      copy.splice(idx, 1);
      this.activeFilters = copy;
    } else {
      this.activeFilters = [...this.activeFilters, f];
    }
  }

  private visiblePins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin) => {
      if (p.status === 'Pending') return this.activeFilters.indexOf('Pending') >= 0;
      if (p.status === 'Approved') return this.activeFilters.indexOf('Approved') >= 0;
      return true;
    });
  }

  private selectedPin(): ApprovalPin | null {
    if (this.selectedPinId < 0) return null;
    const found = this.pins.filter((p: ApprovalPin) => p.id === this.selectedPinId);
    return found.length > 0 ? found[0] : null;
  }

  build() {
    Column() {
      // ── Top Bar ──────────────────────────────────────────
      Row() {
        Text('Approval Flow')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)

      // ── Scrollable Content ───────────────────────────────
      Scroll() {
        Column() {
          // Filter chips
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.filters, (f: string) => {
                FilterChipView({
                  text: f,
                  isSelected: this.isFilterActive(f),
                  onTap: () => this.toggleFilter(f)
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
          Stack({ alignContent: Alignment.TopStart }) {
            // Grid overlay
            MapGridOverlay()
              .width('100%')
              .height('100%')

            // Pins
            ForEach(this.visiblePins(), (p: ApprovalPin) => {
              MapPinView({
                pin: p,
                selected: this.selectedPinId === p.id,
                onPinClick: () => {
                  this.selectedPinId = this.selectedPinId === p.id ? -1 : p.id;
                }
              })
              .position({
                x: p.x * this.mapWidth,
                y: p.y * this.mapHeight
              })
            })

            // Detail card for selected pin
            if (this.selectedPin() !== null) {
              Column() {
                Blank().layoutWeight(1)
                Row() {
                  Column({ space: AppTokens.Spacing.xs }) {
                    Text(this.selectedPin()!.title)
                      .fontSize(AppTokens.Typography.titleSize)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)
                    Text(this.selectedPin()!.status)
                      .fontSize(AppTokens.Typography.labelSize)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Text('Details')
                    .fontSize(AppTokens.Typography.labelSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                    .height(40)
                    .backgroundColor(AppTokens.Colors.surfaceVariant)
                    .borderRadius(AppTokens.Shapes.medium)
                }
                .width('100%')
                .padding(AppTokens.Spacing.lg)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.large)
                .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
                .shadow({ radius: 12, offsetY: 6, color: '#29000000' })
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
          .margin({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.md
          })
          .onAreaChange((_old: Area, newArea: Area) => {
            this.mapWidth = newArea.width as number;
            this.mapHeight = newArea.height as number;
          })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.Colors.background)

      // ── Bottom Bar ───────────────────────────────────────
      Row({ space: AppTokens.Spacing.md }) {
        Button('Reject')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .enabled(this.selectedPinId >= 0)
          .buttonStyle(ButtonStyleMode.NORMAL)

        Button('Approve')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .enabled(this.selectedPinId >= 0)
          .buttonStyle(ButtonStyleMode.NORMAL)
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, offsetY: -4, color: '#24000000' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}