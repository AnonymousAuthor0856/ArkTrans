// Approval Flow Map - Monochrome Theme
// Converted from Kotlin Compose to ArkTS

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
}

interface RadiusTokens {
  small: number;
  medium: number;
  large: number;
}

interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
}

const Colors: ColorTokens = {
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

const Spacing: SpacingTokens = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
};

const Radius: RadiusTokens = {
  small: 8,
  medium: 12,
  large: 16,
};

const initialPins: ApprovalPin[] = [
  { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
  { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
  { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
  { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 },
];

const allFilters: string[] = ['Pending', 'Approved'];

@Component
struct MapPinDot {
  @Prop selected: boolean = false;
  @Prop pinSize: number = 22;
  @Prop statusColor: string = Colors.warning;
  onPinClick: () => void = () => {};

  build() {
    Stack()
      .width(this.pinSize)
      .height(this.pinSize)
      .backgroundColor(this.statusColor)
      .borderRadius(this.pinSize / 2)
      .border({
        width: 2,
        color: this.selected ? Colors.primary : Colors.surface
      })
      .onClick(() => this.onPinClick())
  }
}

@Component
struct MapPinLabel {
  @Prop title: string = '';
  onLabelClick: () => void = () => {};

  build() {
    Text(this.title)
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
      .onClick(() => this.onLabelClick())
  }
}

@Component
struct GridOverlay {
  build() {
    Stack() {
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
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct FilterChipView {
  @Prop label: string = '';
  @Prop isOn: boolean = false;
  onClickCallback: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(this.isOn ? 16 : 14)
      .fontWeight(this.isOn ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.isOn ? Colors.onPrimary : Colors.onSurface)
      .lineHeight(this.isOn ? 22 : 20)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isOn ? Colors.primary : Colors.surface)
      .borderRadius(Radius.small)
      .border({ width: 1, color: Colors.outline })
      .onClick(() => this.onClickCallback())
  }
}

@Component
struct DetailCardView {
  @Prop pin: ApprovalPin | null = null;

  build() {
    Column() {
      if (this.pin !== null) {
        Row() {
          Column({ space: Spacing.xs }) {
            Text(this.pin.title)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .lineHeight(22)
              .fontColor(Colors.onSurface);
            Text(this.pin.status)
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
  }
}

@Component
struct MapPinView {
  @Prop pin: ApprovalPin = { id: 0, title: '', status: '', x: 0, y: 0 };
  @Prop selected: boolean = false;
  @Prop statusColor: string = Colors.warning;
  onPinClick: () => void = () => {};

  build() {
    const pinSize: number = this.selected ? 28 : 22;
    const xpos: string = this.pin.x * 100 + '%';
    const ypos: string = this.pin.y * 100 + '%';
    Stack() {
      MapPinDot({
        selected: this.selected,
        pinSize: pinSize,
        statusColor: this.statusColor,
        onPinClick: () => this.onPinClick()
      })
      .position({ x: 0, y: 0 });

      MapPinLabel({
        title: this.pin.title,
        onLabelClick: () => this.onPinClick()
      })
      .position({ x: 18, y: -4 })
    }
    .position({ x: xpos, y: ypos })
  }
}

@Entry
@Component
struct ApprovalFlowPage {
  @State activeFilters: string[] = ['Pending'];
  @State selectedId: number | null = null;
  private pins: ApprovalPin[] = initialPins;

  private toggleFilter(filter: string): void {
    const idx = this.activeFilters.indexOf(filter);
    if (idx >= 0) {
      const newArr: string[] = this.activeFilters.slice();
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

  private getStatusColor(status: string): string {
    if (status === 'Approved') return Colors.success;
    if (status === 'Pending') return Colors.warning;
    return Colors.error;
  }

  private getVisiblePins(): ApprovalPin[] {
    const result: ApprovalPin[] = [];
    for (let i = 0; i < this.pins.length; i++) {
      if (this.isPinVisible(this.pins[i])) {
        result.push(this.pins[i]);
      }
    }
    return result;
  }

  private findSelectedPin(): ApprovalPin | null {
    if (this.selectedId === null) return null;
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedId) return this.pins[i];
    }
    return null;
  }

  private handlePinClick(pinId: number): void {
    this.selectedId = this.selectedId === pinId ? null : pinId;
  }

  build() {
    Column() {
      Row() {
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .lineHeight(34)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.surface);

      Stack() {
        Scroll() {
          Column({ space: Spacing.md }) {
            Row({ space: Spacing.sm }) {
              ForEach(allFilters, (f: string) => {
                FilterChipView({
                  label: f,
                  isOn: this.activeFilters.indexOf(f) >= 0,
                  onClickCallback: () => this.toggleFilter(f)
                })
              }, (f: string) => f)
            }
            .width('100%');

            Stack() {
              GridOverlay();

              ForEach(this.getVisiblePins(), (pin: ApprovalPin) => {
                MapPinView({
                  pin: pin,
                  selected: this.selectedId === pin.id,
                  statusColor: this.getStatusColor(pin.status),
                  onPinClick: () => this.handlePinClick(pin.id)
                })
              }, (pin: ApprovalPin) => pin.id.toString());

              Column() {
                Blank()
                  .layoutWeight(1);
                DetailCardView({ pin: this.findSelectedPin() })
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
        .width('100%')
        .layoutWeight(1);

        // FAB - bottom right overlay
        Row() {
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
        .width('100%')
        .height('100%')
        .alignItems(VerticalAlign.Bottom);
      }
      .width('100%')
      .layoutWeight(1);

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
    .height('100%')
    .backgroundColor(Colors.background);
  }
}
