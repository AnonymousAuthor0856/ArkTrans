// Approval Flow Map - Monochrome Theme
// Converted from Kotlin Compose to ArkTS

import prompt from '@ohos.promptAction';

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

const filters: string[] = ['Pending', 'Approved'];

@Entry
@Component
struct ApprovalFlowPage {
  @State activeFilters: string[] = ['Pending'];
  @State selectedId: number | null = null;
  private pins: ApprovalPin[] = initialPins;

  private toggleFilter(filter: string): void {
    const idx = this.activeFilters.indexOf(filter);
    if (idx >= 0) {
      this.activeFilters.splice(idx, 1);
    } else {
      this.activeFilters.push(filter);
    }
  }

  private isPinVisible(pin: ApprovalPin): boolean {
    switch (pin.status) {
      case 'Pending':
        return this.activeFilters.indexOf('Pending') >= 0;
      case 'Approved':
        return this.activeFilters.indexOf('Approved') >= 0;
      case 'Rejected':
        return true;
      default:
        return true;
    }
  }

  private getSelectedPin(): ApprovalPin | null {
    if (this.selectedId === null) return null;
    for (const p of this.pins) {
      if (p.id === this.selectedId) return p;
    }
    return null;
  }

  private getStatusColor(status: string): ResourceColor {
    if (status === 'Approved') return Colors.success;
    if (status === 'Pending') return Colors.warning;
    return Colors.error;
  }

  build() {
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

      // Main content area
      Column({ space: Spacing.md }) {
        // Filter chips row
        Scroll() {
          Row({ space: Spacing.sm }) {
            ForEach(filters, (f: string) => {
              const isOn = this.activeFilters.indexOf(f) >= 0;
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
            })
          }
          .width('100%')
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%');

        // Map container
        Stack() {
          // Map background with grid overlay
          Column() {
            // Horizontal grid lines
            ForEach([0, 1, 2, 3, 4, 5], (_: number) => {
              Blank();
              Rect()
                .width('100%')
                .height(1)
                .fill(Colors.surfaceVariant)
            }, (i: number) => 'h' + i.toString())
            Blank();
          }
          .width('100%')
          .height('100%')
          .padding(Spacing.lg);

          Row() {
            // Vertical grid lines
            ForEach([0, 1, 2, 3, 4, 5], (_: number) => {
              Blank();
              Rect()
                .width(1)
                .height('100%')
                .fill(Colors.surfaceVariant)
            }, (i: number) => 'v' + i.toString())
            Blank();
          }
          .width('100%')
          .height('100%')
          .padding(Spacing.lg);

          // Map pins - positioned absolutely
          ForEach(this.pins.filter(p => this.isPinVisible(p)), (pin: ApprovalPin) => {
            const selected = this.selectedId === pin.id;
            const pinSize = selected ? 28 : 22;
            Stack() {
              // Pin dot
              Circle()
                .width(pinSize)
                .height(pinSize)
                .fill(this.getStatusColor(pin.status))
                .stroke({
                  color: selected ? Colors.primary : Colors.surface,
                  width: 2
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
                .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
                .backgroundColor(Colors.surface)
                .borderRadius(Radius.small)
                .border({ width: 1, color: Colors.outline })
                .position({ x: 18, y: -4 })
                .onClick(() => {
                  this.selectedId = this.selectedId === pin.id ? null : pin.id;
                })
            }
            .position({
              x: `${pin.x * 100}%`,
              y: `${pin.y * 100}%`
            })
          }, (pin: ApprovalPin) => pin.id.toString());

          // Selected pin detail card
          if (this.selectedId !== null && this.getSelectedPin() !== null) {
            const sel = this.getSelectedPin()!;
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

              Row({ space: Spacing.sm }) {
                Text('Details')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .lineHeight(16)
                  .fontColor(Colors.onSurface)
                  .padding({ left: 16, right: 16, top: 0, bottom: 0 })
                  .height(40)
                  .backgroundColor(Colors.surfaceVariant)
                  .borderRadius(Radius.medium)
                  .onClick(() => {
                    prompt.showToast({ message: `View details: ${sel.title}` });
                  })
              }
            }
            .width('100%')
            .padding(Spacing.lg)
            .backgroundColor(Colors.surface)
            .borderRadius(Radius.large)
            .border({ width: 1, color: Colors.outline })
            .shadow({
              radius: 12,
              color: '#1A000000',
              offsetY: 6
            })
            .position({ y: 'auto' })
            .margin(Spacing.md)
            .align(Alignment.Bottom);
          }
        }
        .width('100%')
        .aspectRatio(0.9)
        .backgroundColor(Colors.surface)
        .borderRadius(Radius.large)
        .border({ width: 1, color: Colors.outline });

        // FAB area - spacer to push content above bottom bar
        Blank()
          .layoutWeight(1);
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md });

      // Bottom bar with Reject / Approve buttons
      Row({ space: Spacing.md }) {
        Text('Reject')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .lineHeight(22)
          .fontColor(this.selectedId !== null ? Colors.onSurface : Colors.outline)
          .width('100%')
          .height(48)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.selectedId !== null ? Colors.surfaceVariant : Colors.surfaceVariant)
          .borderRadius(Radius.medium)
          .layoutWeight(1)
          .opacity(this.selectedId !== null ? 1.0 : 0.5)
          .onClick(() => {
            if (this.selectedId !== null) {
              prompt.showToast({ message: 'Rejected' });
            }
          });

        Text('Approve')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .lineHeight(22)
          .fontColor(this.selectedId !== null ? Colors.onPrimary : Colors.outline)
          .width('100%')
          .height(48)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.selectedId !== null ? Colors.primary : Colors.surfaceVariant)
          .borderRadius(Radius.medium)
          .layoutWeight(1)
          .onClick(() => {
            if (this.selectedId !== null) {
              prompt.showToast({ message: 'Approved' });
            }
          });
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md + 8 })
      .backgroundColor(Colors.surface);

      // Floating Action Button
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
      .position({ right: 0, bottom: 0 })
      .onClick(() => {
        prompt.showToast({ message: 'New approval' });
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background);
  }
}
