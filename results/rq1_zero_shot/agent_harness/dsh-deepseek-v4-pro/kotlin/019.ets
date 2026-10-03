const Colors = {
  primary: '#8B5CF6',
  secondary: '#D946EF',
  tertiary: '#3B82F6',
  background: '#F9F5FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F1E9FE',
  outline: '#E3D7FE',
  success: '#22C55E',
  warning: '#FACC15',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State fontSize: number = 24
  @State syncProgress: number = 0.3

  build() {
    Column() {
      Row() {
        Text('Subtitle Editor')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.background)

      Column({ space: Spacing.lg }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(Colors.surface)
        .borderRadius(22)
        .shadow({ radius: 12, color: '#14000000', offsetY: 4 })

        Text('Font Size: ' + Math.floor(this.fontSize) + 'sp')
          .fontSize(14)
          .fontColor(Colors.onSurface)

        Slider({ value: this.fontSize, min: 16, max: 48, step: 1 })
          .blockColor(Colors.secondary)
          .selectedColor(Colors.primary)
          .trackColor(Colors.surfaceVariant)
          .onChange((value: number, mode: SliderChangeMode) => { this.fontSize = value })

        Text('Sync Progress')
          .fontSize(14)
          .fontColor(Colors.onSurface)

        Progress({ value: Math.round(this.syncProgress * 100), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)

        Row({ space: Spacing.md }) {
          Button('Sync +', { type: ButtonType.Normal })
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(18)
            .layoutWeight(1)
            .height(48)
            .borderRadius(14)
            .onClick(() => { this.syncProgress = Math.min(this.syncProgress + 0.1, 1) })

          Button('Sync -', { type: ButtonType.Normal })
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .fontSize(18)
            .layoutWeight(1)
            .height(48)
            .borderRadius(14)
            .onClick(() => { this.syncProgress = Math.max(this.syncProgress - 0.1, 0) })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({ angle: 180, colors: [[Colors.surfaceVariant, 0.0], [Colors.background, 0.5], [Colors.surface, 1.0]] })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
