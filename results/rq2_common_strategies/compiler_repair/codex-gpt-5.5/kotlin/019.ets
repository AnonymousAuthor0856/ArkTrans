class SubtitleColors {
  static primary: string = '#8B5CF6';
  static secondary: string = '#D946EF';
  static tertiary: string = '#3B82F6';
  static background: string = '#F9F5FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F1E9FE';
  static outline: string = '#E3D7FE';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State fontSize: number = 24;
  @State syncProgress: number = 30;

  @Builder
  PreviewPanel() {
    Column() {
      Text('Sample Subtitle Line')
        .fontSize(this.fontSize)
        .fontColor(SubtitleColors.onSurface)
        .fontWeight(FontWeight.Normal)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(SubtitleColors.surface)
    .borderRadius(22)
    .shadow({ radius: 12, color: '#2E000000', offsetX: 0, offsetY: 6 })
  }

  @Builder
  SyncButton(label: string, color: string, delta: number) {
    Button(label)
      .fontSize(18)
      .fontWeight(FontWeight.Medium)
      .fontColor(delta > 0 ? SubtitleColors.onPrimary : SubtitleColors.onSecondary)
      .width('48%')
      .height(48)
      .backgroundColor(color)
      .borderRadius(14)
      .onClick(() => {
        let nextValue: number = this.syncProgress + delta;
        if (nextValue > 100) {
          nextValue = 100;
        }
        if (nextValue < 0) {
          nextValue = 0;
        }
        this.syncProgress = nextValue;
      })
  }

  build() {
    Column() {
      Text('Subtitle Editor')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(SubtitleColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        this.PreviewPanel()

        Text('Font Size: ' + Math.floor(this.fontSize).toString() + 'sp')
          .fontSize(14)
          .fontColor(SubtitleColors.onSurface)
          .lineHeight(20)
          .margin({ top: 16 })

        Slider({ value: this.fontSize, min: 16, max: 48, step: 1 })
          .width('100%')
          .selectedColor(SubtitleColors.primary)
          .trackColor(SubtitleColors.surfaceVariant)
          .blockColor(SubtitleColors.secondary)
          .onChange((value: number) => {
            this.fontSize = value;
          })

        Text('Sync Progress')
          .fontSize(14)
          .fontColor(SubtitleColors.onSurface)
          .lineHeight(20)
          .margin({ top: 16 })

        Progress({ value: this.syncProgress, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(SubtitleColors.primary)
          .backgroundColor(SubtitleColors.surfaceVariant)

        Row() {
          this.SyncButton('Sync +', SubtitleColors.primary, 10)
          this.SyncButton('Sync -', SubtitleColors.secondary, -10)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 135,
        colors: [[SubtitleColors.surfaceVariant, 0.0], [SubtitleColors.background, 0.5], [SubtitleColors.surface, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(SubtitleColors.background)
  }
}
