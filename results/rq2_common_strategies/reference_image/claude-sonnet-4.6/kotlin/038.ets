/**
 * 049*InvoiceScanner*en
 * UI_TYPE: Finance | STYLE_THEME: Gradient Flow | LANG: en | BASELINE_SIZE: 720x1280
 * ArkTS (ArkUI declarative) conversion of the Compose screen.
 */

const CANVAS_W: number = 320;   // inner drawing surface width (vp)
const CANVAS_H: number = 400;   // inner drawing surface height (vp)
const BIG_CIRCLE: number = 240; // surfaceVariant circle diameter
const DOT: number = 14;         // marker dot diameter

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

interface ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

class AppColors {
  static readonly primary: string = '#06B6D4';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#8B5CF6';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#E6FFFFFF';        // 0.9 alpha
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
  static readonly shadow1: string = '#1F0F172A';
  static readonly shadow2: string = '#2E0F172A';
  static readonly gradientTop: string = '#4D3B82F6';   // secondary @ 0.3
  static readonly gradientMid: string = '#F0F9FF';     // background
  static readonly gradientBottom: string = '#4D06B6D4';// primary @ 0.3
}

class AppType {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class Elevation {
  static readonly level1: ShadowSpec = { radius: 4, dy: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { radius: 8, dy: 4, opacity: 0.18 };
}

@Entry
@Component
struct InvoiceScanner {
  @State markers: Marker[] = [
    new Marker(71, 116, 'A1'),
    new Marker(161, 215, 'B2'),
    new Marker(270, 316, 'C3')
  ];
  @State scanning: boolean = false;

  private addMarker(): void {
    if (!this.scanning) {
      return;
    }
    const x: number = 40 + Math.floor(Math.random() * 250);
    const y: number = 79 + Math.floor(Math.random() * 263);
    const label: string = 'N' + (this.markers.length + 1).toString();
    this.markers = this.markers.concat([new Marker(x, y, label)]);
  }

  build() {
    Column() {
      // ---- CenterAlignedTopAppBar ----
      Row() {
        Text('Invoice Scanner')
          .fontSize(AppType.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // ---- Body with vertical gradient background ----
      Column({ space: AppSpacing.lg }) {
        // ---- Surface card + Canvas ----
        Stack() {
          Stack() {
            Circle({ width: BIG_CIRCLE, height: BIG_CIRCLE })
              .fill(AppColors.surfaceVariant)

            ForEach(this.markers, (item: Marker, index: number) => {
              Circle({ width: DOT, height: DOT })
                .fill(AppColors.primary)
                .position({ x: item.x - DOT / 2, y: item.y - DOT / 2 })
            }, (item: Marker, index: number) => item.label + '#' + index.toString())
          }
          .width(CANVAS_W)
          .height(CANVAS_H)
        }
        .width('100%')
        .height(CANVAS_H)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .clip(true)
        .shadow({
          radius: Elevation.level2.radius,
          color: AppColors.shadow2,
          offsetX: 0,
          offsetY: Elevation.level2.dy
        })

        // ---- "Scanning Active" row ----
        Row() {
          Text('Scanning Active')
            .fontSize(AppType.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(AppColors.secondary)
            .switchPointColor(AppColors.outline)
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // ---- Add Marker button ----
        Button('Add Marker')
          .type(ButtonType.Normal)
          .borderRadius(AppShapes.medium)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(AppType.titleSize)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height(48)
          .onClick(() => {
            this.addMarker();
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.gradientTop, 0.0],
          [AppColors.gradientMid, 0.5],
          [AppColors.gradientBottom, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}