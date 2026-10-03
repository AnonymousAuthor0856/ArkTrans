const NAME: string = '061*GroupBuy*en';
const UI_TYPE: string = 'ECommerce';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FF8C00';
  static readonly secondary: string = '#FFC107';
  static readonly tertiary: string = '#FFE082';
  static readonly background: string = '#FFF8E1';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFECB3';
  static readonly outline: string = '#D7CCC8';
  static readonly success: string = '#4CAF50';
  static readonly warning: string = '#FFB300';
  static readonly error: string = '#E53935';
  static readonly onPrimary: string = '#3E2723';
  static readonly onSecondary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class Pin {
  x: number;
  y: number;
  label: string;
  constructor(x: number, y: number, label: string) { this.x = x; this.y = y; this.label = label; }
}

@Entry
@Component
struct MainActivity {
  @State pins: Pin[] = [new Pin(150, 250, 'Group A'), new Pin(350, 420, 'Group B'), new Pin(520, 310, 'Group C')];

  addGroup(): void {
    const x = 100 + ((this.pins.length * 97) % 450);
    const y = 150 + ((this.pins.length * 131) % 300);
    this.pins = [...this.pins, new Pin(x, y, 'New')];
  }

  @Builder
  MapCard(): void {
    Column({ space: AppSpacing.md }) {
      Text('Live Deals Map')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Stack() {
        Rect().width('100%').height('100%').fill(AppColors.surfaceVariant).radius(10);
        ForEach(this.pins, (pin: Pin, index: number) => {
          Circle()
            .width(28)
            .height(28)
            .fill(AppColors.primary)
            .position({ x: pin.x / 2, y: pin.y / 2 });
        }, (_pin: Pin, index: number) => index.toString())
      }
      .width('100%')
      .height(220)
      .padding(8)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(10);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 8, color: '#26000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  ActiveGroups(): void {
    Column({ space: AppSpacing.sm }) {
      Text('Active Groups')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary);
      ForEach(this.pins, (pin: Pin, index: number) => {
        Row() {
          Text(pin.label)
            .fontSize(14)
            .fontColor(AppColors.onSurface);
          Blank();
          Circle().width(14).height(14).fill(AppColors.primary);
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);
      }, (_pin: Pin, index: number) => index.toString())
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground);
      this.MapCard();
      Blank().height(AppSpacing.sm);
      Row() {
        Button('Add Group')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(10)
          .layoutWeight(1)
          .height(48)
          .onClick(() => {
            this.addGroup();
          });
        Blank().width(AppSpacing.md);
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(10)
          .layoutWeight(1)
          .height(48)
          .onClick(() => {
            this.pins = [];
          });
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
      this.ActiveGroups();
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background);
  }
}
