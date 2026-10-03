// Design tokens
class ColorTokens {
  primary: string = '#8B5CF6';
  secondary: string = '#D946EF';
  tertiary: string = '#3B82F6';
  background: string = '#F9F5FF';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#F1E9FE';
  outline: string = '#E3D7FE';
  success: string = '#22C55E';
  warning: string = '#FACC15';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#1E1E1E';
  onSurface: string = '#1E1E1E';
}

class SpacingTokens {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

const Colors: ColorTokens = new ColorTokens();
const Spacing: SpacingTokens = new SpacingTokens();

@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Subtitle Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .border({ width: { bottom: 0.5 }, color: Colors.outline })

      // Main content area
      Column({ space: Spacing.xl }) {

        // Sample Subtitle Card
        Column() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(Colors.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .backgroundColor(Colors.surface)
        .borderRadius(22)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.18)',
          offsetX: 0,
          offsetY: 6
        })

        // Font Size Label
        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(14)
          .fontColor(Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')

        // Font Size Slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(Colors.outline)
          .selectedColor(Colors.primary)
          .blockColor(Colors.surface)
          .onChange((value: number) => {
            this.fontSize = value;
          })

        // Sync Progress Label
        Text('Sync Progress')
          .fontSize(14)
          .fontColor(Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track background
          Row()
            .width('100%')
            .height(6)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(3)

          // Progress fill
          Row()
            .width(`${this.syncProgress * 100}%`)
            .height(6)
            .backgroundColor(Colors.primary)
            .borderRadius(3)
        }
        .width('100%')
        .height(6)

        // Buttons Row
        Row({ space: Spacing.md }) {
          // Sync + Button
          Button('Sync +')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .borderRadius(14)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })

          // Sync - Button
          Button('Sync -')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSecondary)
            .backgroundColor(Colors.secondary)
            .borderRadius(14)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            })
        }
        .width('100%')
      }
      .padding(Spacing.lg)
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [Colors.surfaceVariant, 0.0],
          [Colors.background, 0.5],
          [Colors.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}