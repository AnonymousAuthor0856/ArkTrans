@Entry
@Component
struct SubtitleEditorPage {
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  private readonly primary: ResourceColor = '#FF8B5CF6';
  private readonly secondary: ResourceColor = '#FFD946EF';
  private readonly background: ResourceColor = '#FFF9F5FF';
  private readonly surface: ResourceColor = '#FFFFFFFF';
  private readonly surfaceVariant: ResourceColor = '#FFF1E9FE';
  private readonly onSurface: ResourceColor = '#FF1E1E1E';
  private readonly onPrimary: ResourceColor = '#FFFFFFFF';
  private readonly onSecondary: ResourceColor = '#FFFFFFFF';
  private readonly spacingLg: number = 16;
  private readonly spacingMd: number = 12;
  private readonly shapeLarge: number = 22;
  private readonly shapeMedium: number = 14;
  private readonly elevationRadius: number = 12;
  private readonly elevationY: number = 6;

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Subtitle Editor')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.background)

      Column() {
        // Subtitle preview surface
        Stack() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(this.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(this.surface)
        .borderRadius(this.shapeLarge)
        .shadow({
          radius: this.elevationRadius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetY: this.elevationY
        })

        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.onSurface)
          .margin({ top: this.spacingLg })

        // Font size slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(this.secondary)
          .selectedColor(this.primary)
          .trackColor(this.surfaceVariant)
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value;
          })

        Text('Sync Progress')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.onSurface)
          .margin({ top: this.spacingLg })

        // Sync progress indicator
        Progress({ value: this.syncProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(this.primary)
          .backgroundColor(this.surfaceVariant)
          .borderRadius(3)

        // Sync buttons row
        Row() {
          Button('Sync +', { type: ButtonType.Normal })
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimary)
            .backgroundColor(this.primary)
            .borderRadius(this.shapeMedium)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })

          Button('Sync -', { type: ButtonType.Normal })
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSecondary)
            .backgroundColor(this.secondary)
            .borderRadius(this.shapeMedium)
            .height(48)
            .layoutWeight(1)
            .margin({ left: this.spacingMd })
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            })
        }
        .width('100%')
        .margin({ top: this.spacingLg })
      }
      .width('100%')
      .height('100%')
      .padding(this.spacingLg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [this.surfaceVariant, 0.0],
          [this.background, 0.5],
          [this.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}
