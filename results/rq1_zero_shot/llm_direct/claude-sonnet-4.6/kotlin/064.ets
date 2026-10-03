import { router } from '@kit.ArkUI';

// ─── Design Tokens ───────────────────────────────────────────────────────────

const Colors = {
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
  onSurface: '#0A0A0A',
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
};

// ─── Data ────────────────────────────────────────────────────────────────────

interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number; // 0‒1 relative
  y: number; // 0‒1 relative
}

const ALL_PINS: ApprovalPin[] = [
  { id: 1, title: 'Purchase Order #1042', status: 'Pending',  x: 0.18, y: 0.35 },
  { id: 2, title: 'Travel Request #552',  status: 'Approved', x: 0.52, y: 0.42 },
  { id: 3, title: 'Contract #A77',        status: 'Pending',  x: 0.76, y: 0.58 },
  { id: 4, title: 'Budget Change #09',    status: 'Rejected', x: 0.33, y: 0.72 },
];

const ALL_FILTERS: string[] = ['Pending', 'Approved'];

// ─── Helper ──────────────────────────────────────────────────────────────────

function pinColor(status: string): string {
  if (status === 'Approved') return Colors.success;
  if (status === 'Pending')  return Colors.warning;
  return Colors.error;
}

// ─── MapGridOverlay ──────────────────────────────────────────────────────────

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // horizontal lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .color(Colors.surfaceVariant)
            .strokeWidth(1)
        }, (i: number) => i.toString())
      }
      .width('100%')
      .height('100%')
      .padding(Spacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)

      // vertical lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .vertical(true)
            .color(Colors.surfaceVariant)
            .strokeWidth(1)
            .height('100%')
        }, (i: number) => i.toString())
      }
      .width('100%')
      .height('100%')
      .padding(Spacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
  }
}

// ─── MapPin ──────────────────────────────────────────────────────────────────

@Component
struct MapPin {
  pin: ApprovalPin = ALL_PINS[0];
  selected: boolean = false;
  onPinClick: () => void = () => {};

  build() {
    Row() {
      // circle dot
      Stack()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .borderRadius(this.selected ? 14 : 11)
        .backgroundColor(pinColor(this.pin.status))
        .border({
          width: 2,
          color: this.selected ? Colors.primary : Colors.surface,
          radius: this.selected ? 14 : 11,
        })

      // label card
      Text(this.pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
        .backgroundColor(Colors.surface)
        .borderRadius(8)
        .border({ width: 1, color: Colors.outline, radius: 8 })
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .margin({ left: 4, top: 0 })
        .onClick(() => this.onPinClick())
    }
    .alignItems(VerticalAlign.Center)
  }
}

// ─── RootScreen ──────────────────────────────────────────────────────────────

@Entry
@Component
struct RootScreen {
  @State activeFilters: string[] = ['Pending'];
  @State selectedId: number | null = null;

  // map container measured size
  @State mapWidth: number = 0;
  @State mapHeight: number = 0;

  private filters: string[] = ALL_FILTERS;

  toggleFilter(f: string) {
    const idx = this.activeFilters.indexOf(f);
    if (idx >= 0) {
      this.activeFilters = this.activeFilters.filter(x => x !== f);
    } else {
      this.activeFilters = [...this.activeFilters, f];
    }
  }

  visiblePins(): ApprovalPin[] {
    return ALL_PINS.filter(p => {
      if (p.status === 'Pending')  return this.activeFilters.includes('Pending');
      if (p.status === 'Approved') return this.activeFilters.includes('Approved');
      return true; // Rejected always shown
    });
  }

  selectedPin(): ApprovalPin | undefined {
    if (this.selectedId === null) return undefined;
    return ALL_PINS.find(p => p.id === this.selectedId);
  }

  build() {
    Column() {
      // ── Top Bar ──────────────────────────────────────────────────────────
      Row() {
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)

      // ── Body ─────────────────────────────────────────────────────────────
      Column({ space: Spacing.md }) {

        // Filter chips
        Scroll() {
          Row({ space: Spacing.sm }) {
            ForEach(this.filters, (f: string) => {
              const isOn = this.activeFilters.includes(f);
              Text(f)
                .fontSize(isOn ? 16 : 14)
                .fontWeight(isOn ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(isOn ? Colors.onPrimary : Colors.onSurface)
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .backgroundColor(isOn ? Colors.primary : Colors.surface)
                .borderRadius(8)
                .border({ width: 1, color: Colors.outline, radius: 8 })
                .onClick(() => this.toggleFilter(f))
            }, (f: string) => f)
          }
          .padding({ left: 0, right: 0 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        // Map area
        Stack({ alignContent: Alignment.BottomStart }) {
          // background + grid
          Stack() {
            MapGridOverlay()

            // pins
            ForEach(this.visiblePins(), (p: ApprovalPin) => {
              MapPin({
                pin: p,
                selected: this.selectedId === p.id,
                onPinClick: () => {
                  this.selectedId = (this.selectedId === p.id) ? null : p.id;
                }
              })
              .position({
                x: this.mapWidth  * p.x,
                y: this.mapHeight * p.y,
              })
            }, (p: ApprovalPin) => p.id.toString())
          }
          .width('100%')
          .height('100%')
          .onAreaChange((_old, newArea) => {
            this.mapWidth  = newArea.width  as number;
            this.mapHeight = newArea.height as number;
          })

          // Detail card
          if (this.selectedPin() !== undefined) {
            Row() {
              Column({ space: Spacing.xs }) {
                Text(this.selectedPin()!.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(this.selectedPin()!.status)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Details')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(12)
                .height(40)
                .padding({ left: 12, right: 12 })
            }
            .width('100%')
            .padding(Spacing.lg)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(Colors.surface)
            .borderRadius(16)
            .border({ width: 1, color: Colors.outline, radius: 16 })
            .shadow({ radius: 12, color: '#29000000', offsetY: 6 })
            .margin(Spacing.md)
          }
        }
        .width('100%')
        .aspectRatio(0.9)
        .constraintSize({ minHeight: 360 })
        .backgroundColor(Colors.surface)
        .borderRadius(16)
        .border({ width: 1, color: Colors.outline, radius: 16 })
        .clip(true)

      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .alignItems(HorizontalAlign.Start)

      // ── Bottom Bar ───────────────────────────────────────────────────────
      Row({ space: Spacing.md }) {
        Button('Reject')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .enabled(this.selectedId !== null)
          .opacity(this.selectedId !== null ? 1.0 : 0.4)

        Button('Approve')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .enabled(this.selectedId !== null)
          .opacity(this.selectedId !== null ? 1.0 : 0.4)
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .backgroundColor(Colors.surface)
      .shadow({ radius: 8, color: '#24000000', offsetY: -2 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}