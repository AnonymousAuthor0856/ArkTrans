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

class ApprovalColors {
  static readonly primary: string = '#111111';
  static readonly background: string = '#F7F7F7';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDEDED';
  static readonly outline: string = '#D6D6D6';
  static readonly success: string = '#1E7D4C';
  static readonly warning: string = '#B98400';
  static readonly error: string = '#B3261E';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#0A0A0A';
}

@Entry
@Component
struct Index {
  @State pendingOn: boolean = true;
  @State approvedOn: boolean = false;
  @State selectedId: number = 0;
  private pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.18, 0.35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.33, 0.72)
  ];

  private visiblePin(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') {
      return this.pendingOn;
    }
    if (pin.status === 'Approved') {
      return this.approvedOn;
    }
    return true;
  }

  private pinColor(status: string): string {
    if (status === 'Approved') {
      return ApprovalColors.success;
    }
    if (status === 'Pending') {
      return ApprovalColors.warning;
    }
    return ApprovalColors.error;
  }

  private selectedTitle(): string {
    for (let index = 0; index < this.pins.length; index++) {
      if (this.pins[index].id === this.selectedId) {
        return this.pins[index].title;
      }
    }
    return '';
  }

  private selectedStatus(): string {
    for (let index = 0; index < this.pins.length; index++) {
      if (this.pins[index].id === this.selectedId) {
        return this.pins[index].status;
      }
    }
    return '';
  }

  @Builder
  FilterChip(label: string, active: boolean) {
    Button(label)
      .height(36)
      .fontSize(active ? 16 : 14)
      .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(active ? ApprovalColors.onPrimary : ApprovalColors.onSurface)
      .backgroundColor(active ? ApprovalColors.primary : ApprovalColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: ApprovalColors.outline })
      .onClick(() => {
        if (label === 'Pending') {
          this.pendingOn = !this.pendingOn;
        } else {
          this.approvedOn = !this.approvedOn;
        }
      })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Text('')
          .width('90%')
          .height(1)
          .backgroundColor(ApprovalColors.surfaceVariant)
          .position({ x: 16, y: 40 + index * 50 })
      }, (index: number) => 'h' + index.toString())
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Text('')
          .width(1)
          .height('88%')
          .backgroundColor(ApprovalColors.surfaceVariant)
          .position({ x: 28 + index * 54, y: 18 })
      }, (index: number) => 'v' + index.toString())
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MapPin(pin: ApprovalPin) {
    if (this.visiblePin(pin)) {
      Column() {
        Row() {
          Circle()
            .width(this.selectedId === pin.id ? 28 : 22)
            .height(this.selectedId === pin.id ? 28 : 22)
            .fill(this.pinColor(pin.status))
            .stroke(this.selectedId === pin.id ? ApprovalColors.primary : ApprovalColors.surface)
            .strokeWidth(2)

          Text(pin.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(ApprovalColors.onSurface)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .backgroundColor(ApprovalColors.surface)
            .borderRadius(8)
            .border({ width: 1, color: ApprovalColors.outline })
            .margin({ left: 6 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .position({ x: pin.x * 320, y: pin.y * 360 })
      .onClick(() => {
        if (this.selectedId === pin.id) {
          this.selectedId = 0;
        } else {
          this.selectedId = pin.id;
        }
      })
    }
  }

  @Builder
  SelectedCard() {
    if (this.selectedId !== 0) {
      Row() {
        Column() {
          Text(this.selectedTitle())
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(ApprovalColors.onSurface)
          Text(this.selectedStatus())
            .fontSize(12)
            .fontColor(ApprovalColors.onSurface)
            .margin({ top: 4 })
        }
        .layoutWeight(1)

        Button('Details')
          .height(40)
          .fontSize(12)
          .fontColor(ApprovalColors.onSurface)
          .backgroundColor(ApprovalColors.surfaceVariant)
          .borderRadius(12)
      }
      .width('92%')
      .padding(16)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(ApprovalColors.surface)
      .borderRadius(16)
      .border({ width: 1, color: ApprovalColors.outline })
      .position({ x: 14, y: 300 })
      .shadow({ radius: 12, color: '#29000000', offsetX: 0, offsetY: 6 })
    }
  }

  @Builder
  MapPanel() {
    Stack() {
      this.MapGridOverlay()
      ForEach(this.pins, (pin: ApprovalPin) => {
        this.MapPin(pin)
      }, (pin: ApprovalPin) => pin.id.toString())
      this.SelectedCard()
    }
    .width('100%')
    .height(390)
    .backgroundColor(ApprovalColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: ApprovalColors.outline })
  }

  @Builder
  BottomBar() {
    Row() {
      Button('Reject')
        .height(48)
        .fontSize(16)
        .fontColor(ApprovalColors.onSurface)
        .backgroundColor(ApprovalColors.surfaceVariant)
        .borderRadius(12)
        .layoutWeight(1)
        .enabled(this.selectedId !== 0)

      Button('Approve')
        .height(48)
        .fontSize(16)
        .fontColor(ApprovalColors.onPrimary)
        .backgroundColor(ApprovalColors.primary)
        .borderRadius(12)
        .layoutWeight(1)
        .margin({ left: 12 })
        .enabled(this.selectedId !== 0)
    }
    .width('100%')
    .height(72)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(ApprovalColors.surface)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(ApprovalColors.onSurface)
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Center)

        Row() {
          this.FilterChip('Pending', this.pendingOn)
          Column() {
            this.FilterChip('Approved', this.approvedOn)
          }
          .margin({ left: 8 })
        }
        .width('100%')
        .margin({ bottom: 12 })

        this.MapPanel()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, bottom: 84 })
      .backgroundColor(ApprovalColors.background)

      Column() {
        this.BottomBar()
      }
      .width('100%')
      .align(Alignment.Bottom)

      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .fontSize(20)
        .fontColor(ApprovalColors.onPrimary)
        .backgroundColor(ApprovalColors.primary)
        .margin({ right: 24, bottom: 84 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ApprovalColors.background)
  }
}
