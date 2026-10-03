// entry/src/main/ets/pages/Index.ets

interface ColorConfig {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onSurface: string;
}

interface ShapeConfig {
  large: string;
  medium: string;
}

interface SpacingConfig {
  lg: string;
  md: string;
}

@Entry
@Component
struct SubtitleEditorPage {
  // State variables to mimic the mutable state from Compose
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  // Constants matching AppTokens from the Kotlin code
  private readonly COLORS: ColorConfig = {
    primary: '#8B5CF6',
    secondary: '#D946EF',
    tertiary: '#3B82F6',
    background: '#F9F5FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F1E9FE',
    outline: '#E3D7FE',
    onSurface: '#1E1E1E'
  };

  private readonly SHAPES: ShapeConfig = {
    large: '22vp',
    medium: '14vp'
  };

  private readonly SPACING: SpacingConfig = {
    lg: '16vp',
    md: '12vp'
  };

  build() {
    Column() {
      // Top Bar / Title
      Text('Subtitle Editor')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.COLORS.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 20 })

      // Main Content Area
      Column() {
        // Sample Subtitle Card
        Row() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(this.COLORS.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(this.COLORS.surface)
        .borderRadius(this.SHAPES.large)
        .shadow({ radius: 12, color: 'rgba(0, 0, 0, 0.18)', offsetY: 6 })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        // Font Size Label
        Text(`Font Size: ${this.fontSize}sp`)
          .fontSize(14)
          .fontColor(this.COLORS.onSurface)
          .margin({ top: this.SPACING.lg, bottom: this.SPACING.md })

        // Slider for Font Size
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          style: SliderStyle.OutSet
        })
          .blockColor(this.COLORS.secondary)
          .selectedColor(this.COLORS.primary)
          .trackColor(this.COLORS.surfaceVariant)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = Math.round(value);
          })

        // Sync Progress Label
        Text('Sync Progress')
          .fontSize(14)
          .fontColor(this.COLORS.onSurface)
          .margin({ top: this.SPACING.lg, bottom: this.SPACING.md })

        // Linear Progress Indicator (Simulated with Row and Rectangle)
        Row() {
          // Active track
          Row()
            .width(`${this.syncProgress * 100}%`)
            .height(6)
            .backgroundColor(this.COLORS.primary)
            .borderRadius(3)
        }
        .width('100%')
        .height(6)
        .backgroundColor(this.COLORS.surfaceVariant)
        .borderRadius(3)

        // Action Buttons
        Row() {
          // Sync + Button
          Button('Sync +')
            .type(ButtonType.Capsule)
            .backgroundColor(this.COLORS.primary)
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })

          // Spacer
          Blank().width(this.SPACING.md)

          // Sync - Button
          Button('Sync -')
            .type(ButtonType.Capsule)
            .backgroundColor(this.COLORS.secondary)
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            })
        }
        .width('100%')
        .margin({ top: this.SPACING.lg })

      }
      .width('100%')
      .padding(this.SPACING.lg)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#F1E9FE', 0.0],
        ['#F9F5FF', 0.5],
        ['#FFFFFF', 1.0]
      ]
    })
  }
}