// Approval Flow Map - Monochrome Theme
// Converted from Kotlin Compose to ArkTS

// Design Tokens
const Colors = {
  primary: '#FF111111',
  secondary: '#FF2A2A2A',
  tertiary: '#FF444444',
  background: '#FFF7F7F7',
  surface: '#FFFFFFFF',
  surfaceVariant: '#FFEDEDED',
  outline: '#FFD6D6D6',
  success: '#FF1E7D4C',
  warning: '#FFB98400',
  error: '#FFB3261E',
  onPrimary: '#FFFFFFFF',
  onSecondary: '#FFFFFFFF',
  onTertiary: '#FFFFFFFF',
  onBackground: '#FF0A0A0A',
  onSurface: '#FF0A0A0A',
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
};

const Radius = {
  small: 8,
  medium: 12,
  large: 16,
};

interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
}

const initialPins: ApprovalPin[] = [
  { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
  { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
  { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
  { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 },
];

const allFilters: string[] = ['Pending', 'Approved'];

@Entry
@Component
struct ApprovalFlowPage {
  @State activeFilters: string[] = ['Pending'];
  @State selectedId: number | null = null;
  private pins: ApprovalPin[] = initialPins;

  private toggleFilter(filter: string): void {
    const idx = this.activeFilters.indexOf(filter);
    if (idx >= 0) {
      const newArr = this.activeFilters.slice();
      newArr.splice(idx, 1);
      this.activeFilters = newArr;
    } else {
      this.activeFilters = this.activeFilters.concat([filter]);
    }
  }

  private isPinVisible(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') {
      return this.activeFilters.indexOf('Pending') >= 0;
    }
    if (pin.status === 'Approved') {
      return this.activeFilters.indexOf('Approved') >= 0;
    }
    return true;
  }

  private getStatusColor(status: string): ResourceColor {
    if (status === 'Approved') return Colors.success;
    if (status === 'Pending') return Colors.warning;
    return Colors.error;
  }

  private getVisiblePins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin) => this.isPinVisible(p));
  }

  private findSelectedPin(): ApprovalPin | null {
    if (this.selectedId === null) return null;
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedId) return this.pins[i];
    }
    return null;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Main content column
      Column() {
        // Top App Bar
        Row() {
          Text('Approval Flow')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Colors.onSurface)
            .lineHeight(34)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Colors.surface);

        // Scrollable content area
        Scroll() {
          Column({ space: Spacing.md }) {
            // Filter chips row
            Row({ space: Spacing.sm }) {
              ForEach(allFilters, (f: string) => {
                const isOn: boolean = this.activeFilters.indexOf(f) >= 0;
                Text(f)
                  .fontSize(isOn ? 16 : 14)
                  .fontWeight(isOn ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(isOn ? Colors.onPrimary : Colors.onSurface)
                  .lineHeight(isOn ? 22 : 20)
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .backgroundColor(isOn ? Colors.primary : Colors.surface)
                  .borderRadius(Radius.small)
                  .border({ width: 1, color: Colors.outline })
                  .onClick(() => this.toggleFilter(f))
              }, (f: string) => f)
            }
            .width('100%');

            // Map container
            Stack() {
              // Horizontal grid lines
              Column() {
                ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
                  Stack()
                    .width('100%')
                    .height(1)
                    .backgroundColor(Colors.surfaceVariant)
                }, (i: number) => 'h' + i.toString())
              }
              .width('100%')
              .height('100%')
              .padding(Spacing.lg)
              .justifyContent(FlexAlign.SpaceEvenly);

              // Vertical grid lines
              Row() {
                ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
                  Stack()
                    .width(1)
                    .height('100%')
                    .backgroundColor(Colors.surfaceVariant)
                }, (i: number) => 'v' + i.toString())
              }
              .width('100%')
              .height('100%')
              .padding(Spacing.lg)
              .justifyContent(FlexAlign.SpaceEvenly);

              // Map pins
              ForEach(this.getVisiblePins(), (pin: ApprovalPin) => {
                const selected: boolean = this.selectedId === pin.id;
                const pinSize: number = selected ? 28 : 22;
                Stack() {
                  // Pin dot
                  Stack()
                    .width(pinSize)
                    .height(pinSize)
                    .backgroundColor(this.getStatusColor(pin.status))
                    .borderRadius(pinSize / 2)
                    .border({
                      width: 2,
                      color: selected ? Colors.primary : Colors.surface
                    })
                    .position({ x: 0, y: 0 })
                    .onClick(() => {
                      this.selectedId = this.selectedId === pin.id ? null : pin.id;
                    });

                  // Pin label card
                  Text(pin.title)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .lineHeight(16)
                    .fontColor(Colors.onSurface)
                    .padding({
                      left: Spacing.sm,
                      right: Spacing.sm,
                      top: Spacing.xs,
                      bottom: Spacing.xs
                    })
                    .backgroundColor(Colors.surface)
                    .borderRadius(Radius.small)
                    .border({ width: 1, color: Colors.outline })
                    .position({ x: 18, y: -4 })
                    .onClick(() => {
                      this.selectedId = this.selectedId === pin.id ? null : pin.id;
                    })
                }
                .position({
                  x: pin.x * 100 + '%',
                  y: pin.y * 100 + '%'
                })
              }, (pin: ApprovalPin) => pin.id.toString());

              // Selected pin detail card (bottom-aligned)
              Column() {
                Blank()
                  .layoutWeight(1);
                if (this.selectedId !== null && this.findSelectedPin() !== null) {
                  const sel: ApprovalPin = this.findSelectedPin()!;
                  Row() {
                    Column({ space: Spacing.xs }) {
                      Text(sel.title)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .lineHeight(22)
                        .fontColor(Colors.onSurface);
                      Text(sel.status)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .lineHeight(16)
                        .fontColor(Colors.onSurface);
                    }
                    .alignItems(HorizontalAlign.Start)
                    .layoutWeight(1);

                    Text('Details')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .lineHeight(16)
                      .fontColor(Colors.onSurface)
                      .padding({ left: 16, right: 16, top: 0, bottom: 0 })
                      .height(40)
                      .textAlign(TextAlign.Center)
                      .backgroundColor(Colors.surfaceVariant)
                      .borderRadius(Radius.medium)
                      .onClick(() => {})
                  }
                  .width('100%')
                  .padding(Spacing.lg)
                  .backgroundColor(Colors.surface)
                  .borderRadius(Radius.large)
                  .border({ width: 1, color: Colors.outline })
                  .shadow({
                    radius: 12,
                    color: '#1A000000',
                    offsetX: 0,
                    offsetY: 6
                  })
                  .margin(Spacing.md)
                }
              }
              .width('100%')
              .height('100%');
            }
            .width('100%')
            .aspectRatio(0.9)
            .backgroundColor(Colors.surface)
            .borderRadius(Radius.large)
            .border({ width: 1, color: Colors.outline });
          }
          .width('100%')
          .padding({
            left: Spacing.lg,
            right: Spacing.lg,
            top: Spacing.md,
            bottom: Spacing.md
          })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%');

        // Bottom bar with Reject / Approve buttons
        Row({ space: Spacing.md }) {
          Text('Reject')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .lineHeight(22)
            .fontColor(this.selectedId !== null ? Colors.onSurface : Colors.outline)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(Radius.medium)
            .layoutWeight(1)
            .opacity(this.selectedId !== null ? 1.0 : 0.5)
            .onClick(() => {});

          Text('Approve')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .lineHeight(22)
            .fontColor(this.selectedId !== null ? Colors.onPrimary : Colors.outline)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(this.selectedId !== null ? Colors.primary : Colors.surfaceVariant)
            .borderRadius(Radius.medium)
            .layoutWeight(1)
            .onClick(() => {});
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.md,
          bottom: Spacing.md + 8
        })
        .backgroundColor(Colors.surface);
      }
      .width('100%')
      .height('100%');

      // Floating Action Button - bottom right overlay
      Row() {
        Blank()
          .layoutWeight(1);
        Column() {
          Blank()
            .layoutWeight(1);
          Stack() {
            Text('+')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onPrimary)
              .textAlign(TextAlign.Center)
          }
          .width(56)
          .height(56)
          .backgroundColor(Colors.primary)
          .borderRadius(28)
          .margin({ right: Spacing.lg, bottom: 80 })
          .onClick(() => {})
        }
        .height('100%')
        .alignItems(HorizontalAlign.End);
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background);
  }
}
