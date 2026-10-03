class AppColors {
  static primary: string = '#111111';
  static secondary: string = '#2A2A2A';
  static tertiary: string = '#444444';
  static background: string = '#F7F7F7';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EDEDED';
  static outline: string = '#D6D6D6';
  static success: string = '#1E7D4C';
  static warning: string = '#B98400';
  static error: string = '#B3261E';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#0A0A0A';
  static onBackground: string = '#0A0A0A';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
}

class ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: string;
  y: string;

  constructor(id: number, title: string, status: string, x: string, y: string) {
    this.id = id;
    this.title = title;
    this.status = status;
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct RootScreen {
  @State private activeFilters: string[] = ['Pending'];
  @State private selectedPinId: number = -1;
  private filters: string[] = ['Pending', 'Approved'];
  private pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', '18%', '35%'),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', '52%', '42%'),
    new ApprovalPin(3, 'Contract #A77', 'Pending', '76%', '58%'),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', '33%', '72%')
  ];

  private hasFilter(filter: string): boolean {
    return this.activeFilters.indexOf(filter) >= 0;
  }

  private pinVisible(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') {
      return this.hasFilter('Pending');
    }
    if (pin.status === 'Approved') {
      return this.hasFilter('Approved');
    }
    return true;
  }

  private statusColor(status: string): string {
    if (status === 'Approved') {
      return AppColors.success;
    }
    if (status === 'Pending') {
      return AppColors.warning;
    }
    if (status === 'Rejected') {
      return AppColors.error;
    }
    return '#808080';
  }

  private selectedPin(): ApprovalPin {
    let found: ApprovalPin = this.pins[0];
    this.pins.forEach((pin: ApprovalPin) => {
      if (pin.id === this.selectedPinId) {
        found = pin;
      }
    });
    return found;
  }

  @Builder
  private FilterChip(text: string) {
    Text(text)
      .fontSize(this.hasFilter(text) ? 16 : 14)
      .fontWeight(this.hasFilter(text) ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.hasFilter(text) ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
      .backgroundColor(this.hasFilter(text) ? AppColors.primary : AppColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        if (this.hasFilter(text)) {
          this.activeFilters = this.activeFilters.filter((item: string) => item !== text);
        } else {
          this.activeFilters = this.activeFilters.concat([text]);
        }
      })
  }

  @Builder
  private MapGridOverlay() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_i: number) => {
          Blank()
          Divider()
            .height(1)
            .color(AppColors.surfaceVariant)
        })
        Blank()
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .width('100%')
      .height('100%')

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_i: number) => {
          Blank()
          Divider()
            .vertical(true)
            .width(1)
            .color(AppColors.surfaceVariant)
        })
        Blank()
      }
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
      .width('100%')
      .height('100%')
    }
  }

  @Builder
  private MapPinView(pin: ApprovalPin) {
    if (this.pinVisible(pin)) {
      Stack({ alignContent: Alignment.TopStart }) {
        Circle()
          .width(this.selectedPinId === pin.id ? 28 : 22)
          .height(this.selectedPinId === pin.id ? 28 : 22)
          .fill(this.statusColor(pin.status))
          .stroke(this.selectedPinId === pin.id ? AppColors.primary : AppColors.surface)
          .strokeWidth(2)
        Text(pin.title)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surface)
          .borderRadius(8)
          .border({ width: 1, color: AppColors.outline })
          .position({ x: 78, y: 8 })
      }
      .width(170)
      .height(44)
      .position({ x: pin.x, y: pin.y })
      .onClick(() => {
        this.selectedPinId = this.selectedPinId === pin.id ? -1 : pin.id;
      })
    }
  }

  @Builder
  private DetailCard() {
    if (this.selectedPinId !== -1) {
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text(this.selectedPin().title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(this.selectedPin().status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        Button('Details')
          .height(40)
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
      }
      .padding(AppSpacing.lg)
      .width('92%')
      .backgroundColor(AppColors.surface)
      .borderRadius(16)
      .border({ width: 1, color: AppColors.outline })
      .shadow({ radius: 12, color: '#00000029', offsetX: 0, offsetY: 6 })
      .position({ x: '50%', y: '86%' })
    }
  }

  @Builder
  private MapArea() {
    Stack() {
      this.MapGridOverlay()
      ForEach(this.pins, (pin: ApprovalPin) => {
        this.MapPinView(pin)
      })
      this.DetailCard()
    }
    .width('100%')
    .height(360)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  private BottomBar() {
    Row({ space: AppSpacing.md }) {
      Button('Reject')
        .height(48)
        .layoutWeight(1)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)
        .enabled(this.selectedPinId !== -1)
      Button('Approve')
        .height(48)
        .layoutWeight(1)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
        .enabled(this.selectedPinId !== -1)
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .width('100%')
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#00000024', offsetX: 0, offsetY: 4 })
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.surface)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChip(filter)
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })

            this.MapArea()
              .margin({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.md })
          }
          .width('100%')
        }
        .layoutWeight(1)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .width(56)
            .height(56)
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(28)
            .margin(AppSpacing.lg)
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
