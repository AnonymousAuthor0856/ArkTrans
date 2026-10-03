// AppTokens.ets
interface ColorsType {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyItem {
  size: number;
  weight: FontWeight;
}

interface TypographyType {
  display: TypographyItem;
  title: TypographyItem;
  body: TypographyItem;
  label: TypographyItem;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShadowSpecType {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMappingType {
  level1: ShadowSpecType;
  level2: ShadowSpecType;
}

export class AppTokens {
  static Colors: ColorsType = {
    primary: '#FF2563EB',
    secondary: '#FF60A5FA',
    tertiary: '#FF93C5FD',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E3A8A',
    onTertiary: '#FF1E40AF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A'
  }

  static TypographyTokens: TypographyType = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes: ShapesType = {
    small: 4.0,
    medium: 8.0,
    large: 16.0
  }

  static Spacing: SpacingType = {
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  }

  static ElevationMapping: ElevationMappingType = {
    level1: { elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { elevation: 6.0, radius: 8.0, dy: 4.0, opacity: 0.18 }
  }
}

// Helper to convert hex color string with alpha to rgba string for shadow
function hexToRgba(hex: string, opacity: number): string {
  const r = parseInt(hex.slice(3, 5), 16);
  const g = parseInt(hex.slice(5, 7), 16);
  const b = parseInt(hex.slice(7, 9), 16);
  return `rgba(${r}, ${g}, ${b}, ${opacity})`;
}

// SineWaveCanvas.ets
@Component
export struct SineWaveCanvas {
  @Prop progress: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        const width = this.context.width;
        const height = this.context.height;
        const step = width / 50.0;
        let prevY = height / 2.0;

        this.context.beginPath();
        this.context.moveTo(0, prevY);

        for (let i = 0; i <= 50; i++) {
          const x = i * step;
          const y = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0);
          this.context.lineTo(x, y);
          prevY = y;
        }

        this.context.lineWidth = 4;
        this.context.strokeStyle = AppTokens.Colors.primary;
        this.context.stroke();
      })
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;

  build() {
    Column() {
      // Top App Bar
      Stack({ alignContent: Alignment.Center }) {
        Text('Stock K-Line')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .padding({ top: 36 }) // Status bar padding approximation

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        // Chart Surface
        Stack() {
          SineWaveCanvas({ progress: this.progress })
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: hexToRgba(AppTokens.Colors.onBackground, AppTokens.ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text('Market Trend')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(44)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.progress = value;
          })

        // Linear Progress Indicator
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Column()
            .width('100%')
            .height(8)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(4)

          // Progress
          Column()
            .width(`${this.progress * 100}%`)
            .height(8)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)
        .clip(true)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}