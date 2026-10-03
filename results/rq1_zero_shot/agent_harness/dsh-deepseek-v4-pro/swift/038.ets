// 038.ets - translated from 038.swift (Invoice Scanner)

// MARK: - AppTokens

const CLEAR: string = '#00000000';

class AppTokensColors {
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

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppTokensSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

interface ShadowSpec {
  radius: number;
  x: number;
  y: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { radius: 4, x: 0, y: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { radius: 8, x: 0, y: 4, opacity: 0.18 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Shapes = AppTokensShapes;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - Data Model

class Marker {
  id: string;
  x: number;
  y: number;
  label: string;

  constructor(id: string, x: number, y: number, label: string) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker('A1', 120, 200, 'A1'),
    new Marker('B2', 300, 400, 'B2'),
    new Marker('C3', 520, 600, 'C3')
  ];
  @State scanning: boolean = false;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const w = this.ctx.width;
    const h = this.ctx.height;
    const cx = w / 2;
    const cy = h / 2;
    const r = Math.min(w, h) / 2.5;
    // 内圆
    this.ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, r, 0, Math.PI * 2);
    this.ctx.fill();
    // 标记
    for (let i = 0; i < this.markers.length; i++) {
      this.ctx.fillStyle = AppTokens.Colors.primary;
      this.ctx.beginPath();
      this.ctx.arc(this.markers[i].x, this.markers[i].y, 12, 0, Math.PI * 2);
      this.ctx.fill();
    }
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        // Surface containing the Canvas
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('rgba(255,255,255,0.9)')
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.y })

          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.md)
            .onReady(() => {
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(400)

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(AppTokens.Colors.secondary)
            .switchPointColor(AppTokens.Colors.secondary)
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
        }
        .width('100%')

        // Add Marker Button
        Button('Add Marker')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            if (this.scanning) {
              const x = Math.random() * (580 - 80) + 80;
              const y = Math.random() * (650 - 150) + 150;
              const label = 'N' + (this.markers.length + 1);
              const marker = new Marker(label, x, y, label);
              this.markers = this.markers.concat(marker);
              this.drawCanvas();
            }
          })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['rgba(59,130,246,0.3)', 0.0], [AppTokens.Colors.background, 0.5], ['rgba(6,182,212,0.3)', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
