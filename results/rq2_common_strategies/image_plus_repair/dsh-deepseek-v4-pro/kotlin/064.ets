// Translated from Kotlin Jetpack Compose (064.kt) to ArkTS / ArkUI.
// 108ApprovalFlowen - Map UI - Monochrome theme

const COL_PRIMARY: string = '#111111';
const COL_SECONDARY: string = '#2A2A2A';
const COL_TERTIARY: string = '#444444';
const COL_BACKGROUND: string = '#F7F7F7';
const COL_SURFACE: string = '#FFFFFF';
const COL_SURFACE_VARIANT: string = '#EDEDED';
const COL_OUTLINE: string = '#D6D6D6';
const COL_SUCCESS: string = '#1E7D4C';
const COL_WARNING: string = '#B98400';
const COL_ERROR: string = '#B3261E';
const COL_ON_PRIMARY: string = '#FFFFFF';
const COL_ON_SURFACE: string = '#0A0A0A';

interface ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;
}

@Entry
@Component
struct ApprovalFlowPage {
  @State filters: string[] = ['Pending', 'Approved'];
  @State active: string[] = ['Pending'];
  @State selectedId: number = -1;
  private pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 },
  ];
  private gridLines: number[] = [0, 1, 2, 3, 4, 5];

  private isFilterActive(f: string): boolean {
    return this.active.indexOf(f) >= 0;
  }

  private toggleFilter(f: string): void {
    const idx = this.active.indexOf(f);
    if (idx >= 0) {
      const next = this.active.slice();
      next.splice(idx, 1);
      this.active = next;
    } else {
      this.active = this.active.concat([f]);
    }
  }

  private pinColor(status: string): string {
    if (status === 'Approved') {
      return COL_SUCCESS;
    }
    if (status === 'Pending') {
      return COL_WARNING;
    }
    return COL_ERROR;
  }

  private visiblePins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin): boolean => {
      if (p.status === 'Pending') {
        return this.active.indexOf('Pending') >= 0;
      }
      if (p.status === 'Approved') {
        return this.active.indexOf('Approved') >= 0;
      }
      return true;
    });
  }

  private selectedPin(): ApprovalPin | undefined {
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedId) {
        return this.pins[i];
      }
    }
    return undefined;
  }

  private selectedTitle(): string {
    const p = this.selectedPin();
    if (p !== undefined) {
      return p.title;
    }
    return '';
  }

  private selectedStatus(): string {
    const p = this.selectedPin();
    if (p !== undefined) {
      return p.status;
    }
    return '';
  }

  @Builder
  TopBar() {
    Row() {
      Text('Approval Flow')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COL_ON_SURFACE)
    }
    .width('100%')
    .height(64)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  FilterChipItem(f: string) {
    Text(f)
      .fontSize(this.isFilterActive(f) ? 16 : 14)
      .fontWeight(this.isFilterActive(f) ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.isFilterActive(f) ? COL_ON_PRIMARY : COL_ON_SURFACE)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .backgroundColor(this.isFilterActive(f) ? COL_PRIMARY : COL_SURFACE)
      .borderRadius(8)
      .border({ width: 1, color: COL_OUTLINE })
      .margin({ right: 8 })
      .onClick(() => {
        this.toggleFilter(f);
      })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      Column() {
        ForEach(this.gridLines, (i: number) => {
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(COL_SURFACE_VARIANT)
        }, (i: number): string => i.toString())
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(16)

      Row() {
        ForEach(this.gridLines, (i: number) => {
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(COL_SURFACE_VARIANT)
        }, (i: number): string => 'v' + i.toString())
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(16)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  Pin(p: ApprovalPin) {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width(this.selectedId === p.id ? 28 : 22)
        .height(this.selectedId === p.id ? 28 : 22)
        .backgroundColor(this.pinColor(p.status))
        .borderRadius(this.selectedId === p.id ? 14 : 11)
        .border({ width: 2, color: this.selectedId === p.id ? COL_PRIMARY : COL_SURFACE })

      Text(p.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COL_ON_SURFACE)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(COL_SURFACE)
        .borderRadius(8)
        .border({ width: 1, color: COL_OUTLINE })
        .position({ x: 18, y: -4 })
        .onClick(() => {
          if (this.selectedId === p.id) {
            this.selectedId = -1;
          } else {
            this.selectedId = p.id;
          }
        })
    }
    .position({ x: (Math.round(p.x * 100)).toString() + '%', y: (Math.round(p.y * 100)).toString() + '%' })
  }

  @Builder
  DetailsCard() {
    Column() {
      Row() {
        Column() {
          Text(this.selectedTitle())
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COL_ON_SURFACE)
            .margin({ bottom: 4 })
          Text(this.selectedStatus())
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COL_ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)

        Button() {
          Text('Details')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COL_ON_SURFACE)
        }
        .type(ButtonType.Normal)
        .height(40)
        .backgroundColor(COL_SURFACE_VARIANT)
        .borderRadius(12)
        .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding(16)
    }
    .width('100%')
    .backgroundColor(COL_SURFACE)
    .borderRadius(16)
    .border({ width: 1, color: COL_OUTLINE })
  }

  @Builder
  MapArea() {
    Stack({ alignContent: Alignment.Bottom }) {
      this.MapGridOverlay()
      ForEach(this.visiblePins(), (p: ApprovalPin) => {
        this.Pin(p)
      }, (p: ApprovalPin): string => p.id.toString())
      if (this.selectedId >= 0) {
        Column() {
          this.DetailsCard()
        }
        .width('100%')
        .padding({ left: 12, right: 12, bottom: 12, top: 12 })
      }
    }
    .width('100%')
    .constraintSize({ minHeight: 360 })
    .aspectRatio(0.9)
    .backgroundColor(COL_SURFACE)
    .borderRadius(16)
    .border({ width: 1, color: COL_OUTLINE })
  }

  @Builder
  BottomBar() {
    Row() {
      Button() {
        Text('Reject')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COL_ON_SURFACE)
      }
      .type(ButtonType.Normal)
      .height(48)
      .layoutWeight(1)
      .margin({ right: 6 })
      .backgroundColor(COL_SURFACE_VARIANT)
      .borderRadius(12)
      .enabled(this.selectedId >= 0)
      .onClick(() => {})

      Button() {
        Text('Approve')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COL_ON_PRIMARY)
      }
      .type(ButtonType.Normal)
      .height(48)
      .layoutWeight(1)
      .margin({ left: 6 })
      .backgroundColor(COL_PRIMARY)
      .borderRadius(12)
      .enabled(this.selectedId >= 0)
      .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(COL_SURFACE)
  }

  @Builder
  Fab() {
    Button() {
      Text('+')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(COL_ON_PRIMARY)
    }
    .type(ButtonType.Normal)
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(COL_PRIMARY)
    .margin({ right: 16, bottom: 88 })
    .onClick(() => {})
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        Column() {
          Scroll() {
            Row() {
              ForEach(this.filters, (f: string) => {
                this.FilterChipItem(f)
              }, (f: string): string => f)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .margin({ bottom: 12 })

          this.MapArea()
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(COL_BACKGROUND)

      this.Fab()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COL_BACKGROUND)
  }
}
