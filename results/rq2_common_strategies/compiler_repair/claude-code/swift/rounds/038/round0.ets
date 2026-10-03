import promptAction from '@ohos.promptAction';

// MARK: - AppTokens (Colors, Typography, Shapes, Spacing, ElevationMapping)

class AppColors {
  static readonly primary: string = '#FF06B6D4';
  static readonly secondary: string = '#FF3B82F6';
  static readonly tertiary: string = '#FF8B5CF6';
  static readonly background: string = '#FFF0F9FF';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE0F2FE';
  static readonly outline: string = '#FFBAE6FD';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFFACC15';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FFFFFFFF';
  static readonly onBackground: string = '#FF0F172A';
  static readonly onSurface: string = '#FF0F172A';
}

class AppTypography {
  static readonly displayFontSize: number = 28;
  static readonly displayFontWeight: FontWeight = FontWeight.Bold;
  static readonly titleFontSize: number = 18;
  static readonly titleFontWeight: FontWeight = FontWeight.Medium;
  static readonly bodyFontSize: number = 14;
  static readonly bodyFontWeight: FontWeight = FontWeight.Regular;
  static readonly labelFontSize: number = 12;
  static readonly labelFontWeight: FontWeight = FontWeight.Medium;
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

class ShadowSpec {
  radius: number;
  x: number;
  y: number;
  opacity: number;

  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius;
    this.x = x;
    this.y = y;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 0, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(8, 0, 4, 0.18);
}

// MARK: - Data Model

interface Marker {
  id: string;
  x: number;
  y: number;
  label: string;
}

// MARK: - Custom Toggle Switch Component

@Component
struct CustomToggle {
  @Link isOn: boolean;
  checkedThumbColor: string = AppColors.secondary;
  uncheckedThumbColor: string = AppColors.outline;
  checkedTrackColor: string = AppColors.secondary;
  uncheckedTrackColor: string = AppColors.surfaceVariant;

  build() {
    Stack() {
      Capsule()
        .fill(this.isOn ? this.checkedTrackColor : this.uncheckedTrackColor)
        .width(50)
        .height(30)
    }
    .width(50)
    .height(30)
    .onClick(() => {
      this.isOn = !this.isOn;
    })
  }
}

// MARK: - RootScreen (Main UI)

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: '1', x: 120, y: 200, label: 'A1' },
    { id: '2', x: 300, y: 400, label: 'B2' },
    { id: '3', x: 520, y: 600, label: 'C3' }
  ];
  @State scanning: boolean = false;
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();
  @State canvasVersion: number = 0;

  aboutToAppear(): void {
    this.markers = [...this.markers];
  }

  drawCanvas(): void {
    const ctx = this.canvasCtx;
    const width = 360;
    const height = 400 - AppSpacing.md * 2;

    ctx.clearRect(0, 0, width, height);

    // Draw inner circle (surfaceVariant)
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = Math.min(width, height) / 2.5;
    ctx.fillStyle = AppColors.surfaceVariant;
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.fill();

    // Draw markers
    for (let i = 0; i < this.markers.length; i++) {
      const marker = this.markers[i];
      ctx.fillStyle = AppColors.primary;
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2);
      ctx.fill();
    }
  }

  addMarker(): void {
    if (this.scanning) {
      const newMarker: Marker = {
        id: String(Date.now()),
        x: 80 + Math.random() * 500,
        y: 150 + Math.random() * 500,
        label: 'N' + (this.markers.length + 1)
      };
      this.markers.push(newMarker);
      this.canvasVersion++;
    }
  }

  build() {
    Column() {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(AppTypography.displayFontSize)
        .fontWeight(AppTypography.displayFontWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background);

      // Main Content Area
      Column() {
        // Surface containing the Canvas
        Stack() {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .padding(AppSpacing.md)
            .onReady(() => {
              this.drawCanvas();
            });
        }
        .width('100%')
        .height(400)
        .backgroundColor(this.hexWithOpacity(AppColors.surface, 0.9))
        .borderRadius(AppShapes.large)
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: this.rgbaColor(0, 0, 0, ElevationMapping.level2.opacity),
          offsetX: ElevationMapping.level2.x,
          offsetY: ElevationMapping.level2.y
        });

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(AppTypography.titleFontSize)
            .fontWeight(AppTypography.titleFontWeight)
            .fontColor(AppColors.onSurface);

          Blank();

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
            .selectedColor(AppColors.secondary)
            .switchPointColor(AppColors.onSecondary)
            .width(50)
            .height(30);
        }
        .width('100%');

        // Add Marker Button
        Button('Add Marker')
          .fontSize(AppTypography.titleFontSize)
          .fontWeight(AppTypography.titleFontWeight)
          .fontColor(AppColors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            this.addMarker();
          });
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.TopBottom,
        colors: [
          [this.hexWithOpacity(AppColors.secondary, 0.3), 0],
          [AppColors.background, 0.5],
          [this.hexWithOpacity(AppColors.primary, 0.3), 1]
        ]
      });
    }
    .width('100%')
    .height('100%')
  }

  private hexWithOpacity(hex: string, opacity: number): string {
    // hex format: #FFRRGGBB
    const r = parseInt(hex.slice(3, 5), 16);
    const g = parseInt(hex.slice(5, 7), 16);
    const b = parseInt(hex.slice(7, 9), 16);
    return `rgba(${r}, ${g}, ${b}, ${opacity})`;
  }

  private rgbaColor(r: number, g: number, b: number, a: number): string {
    return `rgba(${r}, ${g}, ${b}, ${a})`;
  }
}
