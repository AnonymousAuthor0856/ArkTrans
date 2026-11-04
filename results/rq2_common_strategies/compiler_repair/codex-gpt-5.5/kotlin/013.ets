class MusicColors {
  static primary: string = '#EF476F';
  static secondary: string = '#FFD166';
  static tertiary: string = '#06D6A0';
  static background: string = '#FFFCF2';
  static surface: string = '#FFF8E1';
  static surfaceVariant: string = '#FCE7E7';
  static outline: string = '#BDBDBD';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1F1F1F';
  static onSurface: string = '#1F1F1F';
}

@Entry
@Component
struct Index {
  @State knobX: number = 140;
  @State knobY: number = 140;

  @Builder
  RecordPanel() {
    Stack() {
      Circle()
        .width(240)
        .height(240)
        .fill('#00FFFFFF')
        .stroke(MusicColors.secondary)
        .strokeWidth(12)
      Circle()
        .width(40)
        .height(40)
        .fill(MusicColors.primary)
        .position({ x: this.knobX - 20, y: this.knobY - 20 })
    }
    .width(280)
    .height(280)
    .backgroundColor(MusicColors.surface)
    .border({ width: 3, color: MusicColors.outline, radius: 16 })
    .borderRadius(16)
  }

  build() {
    Column() {
      Text('Retro Music Player')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(MusicColors.onSurface)
        .lineHeight(36)
        .width('100%')
        .height(72)
        .textAlign(TextAlign.Center)
        .backgroundColor(MusicColors.background)

      Column() {
        this.RecordPanel()

        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(MusicColors.onSurface)
          .lineHeight(24)

        Row() {
          Button('Play')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(MusicColors.onPrimary)
            .backgroundColor(MusicColors.primary)
            .borderRadius(12)
            .width(120)
            .height(48)
          Button('Pause')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(MusicColors.onSecondary)
            .backgroundColor(MusicColors.secondary)
            .borderRadius(12)
            .width(120)
            .height(48)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Text('Knob X:' + this.knobX.toString() + ' Y:' + this.knobY.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(MusicColors.tertiary)
          .lineHeight(16)

        Blank().height(32)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(MusicColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(MusicColors.background)
  }
}
