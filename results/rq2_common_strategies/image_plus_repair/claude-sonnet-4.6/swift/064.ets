// AppTokens
const colorPrimary: string = '#111111';
const colorBackground: string = '#F7F7F7';
const colorSurface: string = '#FFFFFF';
const colorSurfaceVariant: string = '#EDEDED';
const colorOutline: string = '#D6D6D6';
const colorSuccess: string = '#1E7D4C';
const colorWarning: string = '#B98400';
const colorError: string = '#B3261E';
const colorOnPrimary: string = '#FFFFFF';
const colorOnSurface: string = '#0A0A0A';

const spacingXs: number = 4;
const spacingSm: number = 8;
const spacingMd: number = 12;
const spacingLg: number = 16;

const shapeSmall: number = 8;
const shapeMedium: number = 12;
const shapeLarge: number = 16;

class ApprovalPin {
  id: number = 0;
  title: string = '';
  status: string = '';
  x: number = 0;
  y: number = 0;
}

@Entry
@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved'];
  @State activeFilters: string[] = ['Pending'];
  @State pins: ApprovalPin[] = [];
  @State selectedPinId: number = -1;
  @State mapWidth: number = 340;
  @State mapHeight: number = 400;

  aboutToAppear() {
    const p1 = new ApprovalPin();
    p1.id = 1;
    p1.title = 'Purchase Order #1042';
    p1.status = 'Pending';
    p1.x = 0.18;
    p1.y = 0.35;
    const p2 = new ApprovalPin();
    p2.id = 2;
    p2.title = 'Travel Request #552';
    p2.status = 'Approved';
    p2.x = 0.52;
    p2.y = 0.42;
    const p3 = new ApprovalPin();
    p3.id = 3;
    p3.title = 'Contract #A77';
    p3.status = 'Pending';
    p3.x = 0.76;
    p3.y = 0.58;
    const p4 = new ApprovalPin();
    p4.id = 4;
    p4.title = 'Budget Change #09';
    p4.status = 'Rejected';
    p4.x = 0.33;
    p4.y = 0.72;
    this.pins = [p1, p2, p3, p4];
  }

  getPinColor(status: string): string {
    if (status === 'Approved') return colorSuccess;
    if (status === 'Pending') return colorWarning;
    if (status === 'Rejected') return colorError;
    return '#888888';
  }

  isFiltered(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') return this.activeFilters.indexOf('Pending') >= 0;
    if (pin.status === 'Approved') return this.activeFilters.indexOf('Approved') >= 0;
    if (pin.status === 'Rejected') return true;
    return true;
  }

  toggleFilter(f: string) {
    const idx = this.activeFilters.indexOf(f);
    if (idx >= 0) {
      this.activeFilters = this.activeFilters.filter((item: string) => item !== f);
    } else {
      this.activeFilters = [...this.activeFilters, f];
    }
  }

  getSelectedPin(): ApprovalPin | null {
    if (this.selectedPinId === -1) return null;
    for (let p of this.pins) {
      if (p.id === this.selectedPinId) return p;
    }
    return null;
  }

  getFilteredPins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin) => this.isFiltered(p));
  }

  getSelectedTitle(): string {
    const sel = this.getSelectedPin();
    if (sel !== null) return sel.title;
    return '';
  }

  getSelectedStatus(): string {
    const sel = this.getSelectedPin();
    if (sel !== null) return sel.status;
    return '';
  }

  @Builder
  FilterChip(text: string, isSelected: boolean) {
    Text(text)
      .fontSize(isSelected ? 16 : 14)
      .fontWeight(isSelected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(isSelected ? colorOnPrimary : colorOnSurface)
      .padding({ left: spacingSm, right: spacingSm, top: spacingXs, bottom: spacingXs })
      .backgroundColor(isSelected ? colorPrimary : colorSurface)
      .borderRadius(shapeSmall)
      .border({ width: 1, color: colorOutline, radius: shapeSmall })
      .onClick(() => {
        this.toggleFilter(text);
      })
  }

  @Builder
  MapGrid() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Blank().flexGrow(1)
          Divider()
            .strokeWidth(1)
            .color(colorSurfaceVariant)
            .width('100%')
        })
        Blank().flexGrow(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: spacingLg, right: spacingLg })

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Blank().flexGrow(1)
          Divider()
            .strokeWidth(1)
            .color(colorSurfaceVariant)
            .height('100%')
            .vertical(true)
        })
        Blank().flexGrow(1)
      }
      .width('100%')
      .height('100%')
      .padding({ top: spacingLg, bottom: spacingLg })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  PinView(pin: ApprovalPin) {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .fill(this.getPinColor(pin.status))
        .width(this.selectedPinId === pin.id ? 28 : 22)
        .height(this.selectedPinId === pin.id ? 28 : 22)
        .border({
          width: 2,
          color: this.selectedPinId === pin.id ? colorPrimary : colorSurface,
          radius: 100
        })

      Text(pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(colorOnSurface)
        .padding({ left: spacingSm, right: spacingSm, top: spacingXs, bottom: spacingXs })
        .backgroundColor(colorSurface)
        .borderRadius(shapeSmall)
        .border({ width: 1, color: colorOutline, radius: shapeSmall })
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .offset({ x: 18, y: -4 })
        .onClick(() => {
          if (this.selectedPinId === pin.id) {
            this.selectedPinId = -1;
          } else {
            this.selectedPinId = pin.id;
          }
        })
    }
    .position({
      x: this.mapWidth * pin.x,
      y: this.mapHeight * pin.y
    })
  }

  @Builder
  SelectedPinCard() {
    Column() {
      Blank().flexGrow(1)
      Row() {
        Column({ space: spacingXs }) {
          Text(this.getSelectedTitle())
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurface)
          Text(this.getSelectedStatus())
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .flexGrow(1)

        Button('Details')
          .fontSize(12)
          .fontColor(colorOnSurface)
          .height(40)
          .padding({ left: spacingMd, right: spacingMd })
          .backgroundColor(colorSurfaceVariant)
          .borderRadius(shapeMedium)
          .type(ButtonType.Normal)
      }
      .width('100%')
      .padding(spacingLg)
      .backgroundColor(colorSurface)
      .borderRadius(shapeLarge)
      .border({ width: 1, color: colorOutline, radius: shapeLarge })
      .shadow({ radius: 12, color: '#29000000', offsetX: 0, offsetY: 6 })
      .margin(spacingMd)
    }
    .width('100%')
    .height('100%')
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top bar
        Column() {
          Text('Approval Flow')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(colorOnSurface)
        }
        .width('100%')
        .padding({ top: spacingMd, bottom: spacingMd })
        .backgroundColor(colorSurface)
        .alignItems(HorizontalAlign.Center)

        // Scrollable content
        Scroll() {
          Column({ space: spacingMd }) {
            // Filter chips
            Scroll() {
              Row({ space: spacingSm }) {
                ForEach(this.filters, (f: string) => {
                  this.FilterChip(f, this.activeFilters.indexOf(f) >= 0)
                })
              }
              .padding({ left: spacingLg, right: spacingLg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ top: spacingMd })

            // Map area
            Stack({ alignContent: Alignment.TopStart }) {
              this.MapGrid()

              ForEach(this.getFilteredPins(), (p: ApprovalPin) => {
                this.PinView(p)
              })

              if (this.selectedPinId !== -1 && this.getSelectedPin() !== null) {
                this.SelectedPinCard()
              }
            }
            .width('100%')
            .height(400)
            .backgroundColor(colorSurface)
            .borderRadius(shapeLarge)
            .border({ width: 1, color: colorOutline, radius: shapeLarge })
            .clip(true)
            .margin({ left: spacingLg, right: spacingLg, bottom: spacingMd })
            .onAreaChange((_oldVal, newVal) => {
              this.mapWidth = newVal.width as number;
              this.mapHeight = newVal.height as number;
            })
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .flexGrow(1)
        .backgroundColor(colorBackground)

        // Bottom bar
        Row({ space: spacingMd }) {
          Button('Reject')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedPinId === -1 ? '#88000000' : colorOnSurface)
            .flexGrow(1)
            .height(48)
            .backgroundColor(colorSurfaceVariant)
            .borderRadius(shapeMedium)
            .type(ButtonType.Normal)
            .enabled(this.selectedPinId !== -1)

          Button('Approve')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedPinId === -1 ? '#88FFFFFF' : colorOnPrimary)
            .flexGrow(1)
            .height(48)
            .backgroundColor(this.selectedPinId === -1 ? '#88111111' : colorPrimary)
            .borderRadius(shapeMedium)
            .type(ButtonType.Normal)
            .enabled(this.selectedPinId !== -1)
        }
        .width('100%')
        .padding({ left: spacingLg, right: spacingLg, top: spacingMd, bottom: spacingMd })
        .backgroundColor(colorSurface)
        .shadow({ radius: 8, color: '#24000000', offsetX: 0, offsetY: -4 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(colorBackground)

      // FAB
      Button('+')
        .fontSize(24)
        .fontColor(colorOnPrimary)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(colorPrimary)
        .type(ButtonType.Circle)
        .margin({ right: spacingLg, bottom: 80 })
    }
    .width('100%')
    .height('100%')
  }
}