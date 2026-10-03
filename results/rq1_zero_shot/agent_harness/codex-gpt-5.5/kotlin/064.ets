const NAME: string = "108ApprovalFlowen";
const UI_TYPE: string = "Map";
const STYLE_THEME: string = "Monochrome";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#2A2A2A';
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

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

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

@Entry
@Component
struct MainActivity {
  @State pendingOn: boolean = true;
  @State approvedOn: boolean = false;
  @State selectedId: number = -1;

  private pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 18, 35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 52, 42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 76, 58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 33, 72)
  ];

  private isVisible(pin: ApprovalPin): boolean {
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
      return AppColors.success;
    }
    if (status === 'Pending') {
      return AppColors.warning;
    }
    return AppColors.error;
  }

  private selectedPin(): ApprovalPin | undefined {
    return this.pins.find((pin: ApprovalPin) => pin.id === this.selectedId);
  }

  @Builder
  FilterChip(label: string, selected: boolean) {
    Text(label)
      .fontSize(selected ? 16 : 14)
      .fontWeight(selected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(selected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(selected ? AppColors.primary : AppColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
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
      ForEach([1, 2, 3, 4, 5, 6], (line: number) => {
        Blank()
          .width('100%')
          .height(1)
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: '0%', y: `${line * 13}%` })
        Blank()
          .width(1)
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: `${line * 13}%`, y: '0%' })
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
  }

  @Builder
  MapPin(pin: ApprovalPin) {
    Stack() {
      Circle()
        .width(this.selectedId === pin.id ? 28 : 22)
        .height(this.selectedId === pin.id ? 28 : 22)
        .fill(this.pinColor(pin.status))
        .stroke(this.selectedId === pin.id ? AppColors.primary : AppColors.surface)
        .strokeWidth(2)
        .position({ x: `${pin.x}%`, y: `${pin.y}%` })
        .onClick(() => {
          this.selectedId = this.selectedId === pin.id ? -1 : pin.id;
        })
      Text(pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .backgroundColor(AppColors.surface)
        .borderRadius(8)
        .border({ width: 1, color: AppColors.outline })
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .position({ x: `${Math.min(pin.x + 8, 70)}%`, y: `${Math.max(pin.y - 2, 4)}%` })
        .onClick(() => {
          this.selectedId = this.selectedId === pin.id ? -1 : pin.id;
        })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  DetailCard(pin: ApprovalPin) {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(pin.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(pin.status)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Details')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .height(40)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(10)
    }
    .width('92%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 12, color: '#29000000', offsetY: 6 })
    .position({ x: '4%', y: '78%' })
  }

  @Builder
  BottomBar() {
    Row({ space: AppSpacing.md }) {
      Button('Reject')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .enabled(this.selectedId !== -1)
        .layoutWeight(1)
        .height(48)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)
      Button('Approve')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .enabled(this.selectedId !== -1)
        .layoutWeight(1)
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
    }
    .width('100%')
    .height(72)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('Approval Flow')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .height(68)
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.background)

        Column({ space: AppSpacing.md }) {
          Row({ space: AppSpacing.sm }) {
            this.FilterChip('Pending', this.pendingOn)
            this.FilterChip('Approved', this.approvedOn)
          }
          .width('100%')

          Stack() {
            this.MapGridOverlay()
            ForEach(this.pins, (pin: ApprovalPin) => {
              if (this.isVisible(pin)) {
                this.MapPin(pin)
              }
            })
            if (this.selectedPin() !== undefined) {
              this.DetailCard(this.selectedPin() as ApprovalPin)
            }
          }
          .width('100%')
          .aspectRatio(0.9)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .border({ width: 1, color: AppColors.outline })
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Text('+')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .lineHeight(56)
        .backgroundColor(AppColors.primary)
        .borderRadius(28)
        .margin({ right: 20, bottom: 84 })
    }
    .width('100%')
    .height('100%')
  }
}
