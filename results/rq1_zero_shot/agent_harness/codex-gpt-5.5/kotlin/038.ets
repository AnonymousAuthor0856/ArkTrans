const NAME: string = '049*InvoiceScanner*en';
const UI_TYPE: string = 'Finance';
const STYLE_THEME: string = 'Gradient Flow';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#06B6D4';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#8B5CF6';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BAE6FD';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class Marker {
  x: number;
  y: number;
  label: string;
  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

@Entry
@Component
struct MainActivity {
  @State markers: Marker[] = [new Marker(120, 200, 'A1'), new Marker(300, 400, 'B2'), new Marker(520, 600, 'C3')];
  @State scanning: boolean = false;

  addMarker(): void {
    if (!this.scanning) {
      return;
    }
    const x = 80 + ((this.markers.length * 97) % 500);
    const y = 150 + ((this.markers.length * 131) % 500);
    this.markers = [...this.markers, new Marker(x, y, `N${this.markers.length + 1}`)];
  }

  @Builder
  Header(): void {
    Text('Invoice Scanner')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  ScannerSurface(): void {
    Stack() {
      Circle().width(260).height(260).fill(AppColors.surfaceVariant);
      ForEach(this.markers, (marker: Marker) => {
        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.primary)
          .position({ x: marker.x / 2, y: marker.y / 2 });
      }, (marker: Marker) => marker.label)
    }
    .width('100%')
    .height(400)
    .padding(AppSpacing.md)
    .backgroundColor('#E6FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
    .alignContent(Alignment.Center);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        this.ScannerSurface();
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
          Blank();
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(AppColors.secondary)
            .onChange((value: boolean) => {
              this.scanning = value;
            });
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);
        Button('Add Marker')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(12)
          .width('100%')
          .height(48)
          .onClick(() => {
            this.addMarker();
          });
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
