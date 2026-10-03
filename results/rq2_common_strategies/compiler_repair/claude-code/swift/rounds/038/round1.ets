// MARK: - AppTokens

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
  static readonly onSurface: string = '#FF0F172A';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
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

class ElevationLevel {
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
  static readonly level1: ElevationLevel = new ElevationLevel(4, 0, 2, 0.12);
  static readonly level2: ElevationLevel = new ElevationLevel(8, 0, 4, 0.18);
}

// MARK: - Data Model

interface Marker {
  id: string;
  x: number;
  y: number;
  label: string;
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: 'm1', x: 120, y: 200, label: 'A1' },
    { id: 'm2', x: 300, y: 400, label: 'B2' },
    { id: 'm3', x: 520, y: 600, label: 'C3' }
  ];
  @State scanning: boolean = false;
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;

  build() {
    Column() {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background);

      // Main Content Area
      Column({ space: AppSpacing.lg }) {
        // Surface with the canvas area
        Stack() {
          // Inner circle (surfaceVariant) - drawn as centered circle
          Circle()
            .width(this.canvasWidth > 0 ? Math.min(this.canvasWidth, this.canvasHeight) / 1.25 : 0)
            .height(this.canvasHeight > 0 ? Math.min(this.canvasWidth, this.canvasHeight) / 1.25 : 0)
            .fill(AppColors.surfaceVariant);

          // Markers
          ForEach(this.markers, (marker: Marker) => {
            Circle()
              .width(24)
              .height(24)
              .fill(AppColors.primary)
              .position({ x: marker.x, y: marker.y });
          }, (marker: Marker) => marker.id);
        }
        .width('100%')
        .height(400)
        .padding(AppSpacing.md)
        .backgroundColor(this.hexAlpha(AppColors.surface, 0.9))
        .borderRadius(AppShapes.large)
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: `rgba(0, 0, 0, ${ElevationMapping.level2.opacity})`,
          offsetX: ElevationMapping.level2.x,
          offsetY: ElevationMapping.level2.y
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.canvasWidth = newValue.width as number - AppSpacing.md * 2;
          this.canvasHeight = newValue.height as number - AppSpacing.md * 2;
        });

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onSurface);

          Blank();

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .onChange((isOn: boolean) => {
              this.scanning = isOn;
            })
            .selectedColor(AppColors.secondary)
            .switchPointColor(AppColors.onSecondary);
        }
        .width('100%');

        // Add Marker Button
        Button('Add Marker')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
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
          [this.hexAlpha(AppColors.secondary, 0.3), 0.0],
          [AppColors.background, 0.5],
          [this.hexAlpha(AppColors.primary, 0.3), 1.0]
        ]
      });
    }
    .width('100%')
    .height('100%')
  }

  private addMarker(): void {
    if (!this.scanning) {
      return;
    }
    const newMarker: Marker = {
      id: 'm' + Date.now(),
      x: 80 + Math.floor(Math.random() * 500),
      y: 150 + Math.floor(Math.random() * 500),
      label: 'N' + (this.markers.length + 1)
    };
    this.markers.push(newMarker);
  }

  private hexAlpha(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(3, 5), 16);
    const g = parseInt(hex.slice(5, 7), 16);
    const b = parseInt(hex.slice(7, 9), 16);
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
  }
}
