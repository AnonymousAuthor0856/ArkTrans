interface ColorTokens {
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

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface ElevationSpec {
  radius: number;
  dy: number;
  opacity: number;
}

@Entry
@Component
struct GlassDocReader {
  @State scrollOffsetY: number = 0;

  private colors: ColorTokens = {
    primary: '#FF38BDF8',
    secondary: '#FFA78BFA',
    tertiary: '#FF7DD3FC',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
  };

  private spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  private shapes: ShapeTokens = {
    small: 6,
    medium: 12,
    large: 20,
  };

  private elevationLevel2: ElevationSpec = {
    radius: 8,
    dy: 4,
    opacity: 0.18,
  };

  @Builder
  SampleLine(index: number) {
    Text(`This is a sample line of text content number ${index}.`)
      .fontSize(14)
      .fontWeight(FontWeight.Regular)
      .fontColor(this.colors.onSurface)
  }

  build() {
    Column() {
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .padding({ top: 20, bottom: this.spacing.lg })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.colors.background)

      Stack({ alignContent: Alignment.Center }) {
        Stack() {
        }
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [
            [this.colors.surfaceVariant, 0.8],
            [this.colors.background, 1.0],
            [this.colors.surfaceVariant, 0.8],
          ],
          direction: GradientDirection.Bottom,
        })

        Column({ space: this.spacing.md }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.primary)

          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item: number) => {
            this.SampleLine(item)
          })

          Blank()
        }
        .padding(this.spacing.lg)
        .width('90%')
        .height(400)
        .backgroundColor(this.colors.surface + 'B3')
        .borderRadius(this.shapes.large)
        .shadow({
          radius: this.elevationLevel2.radius,
          color: `rgba(0, 0, 0, ${this.elevationLevel2.opacity})`,
          offsetY: this.elevationLevel2.dy,
          offsetX: 0,
        })
        .translate({ y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY += event.offsetY;
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}
