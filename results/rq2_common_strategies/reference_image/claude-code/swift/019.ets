@Entry
@Component
struct SubtitleEditorPage {
  @State fontSize: number = 23;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      Text("Subtitle Editor")
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor("#FF1E1E1E")
        .width("100%")
        .textAlign(TextAlign.Center)
        .padding({ top: 12, bottom: 12 })
        .backgroundColor("#FFF9F5FF")

      Column({ space: 24 }) {
        Column() {
          Text("Sample Subtitle Line")
            .fontSize(this.fontSize)
            .fontColor("#FF1E1E1E")
        }
        .width("100%")
        .height(200)
        .justifyContent(FlexAlign.Center)
        .backgroundColor("#FFFFFFFF")
        .borderRadius(22)
        .shadow({
          radius: 8,
          color: "rgba(0, 0, 0, 0.18)",
          offsetX: 0,
          offsetY: 6
        })

        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor("#FF1E1E1E")

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor("#FFFFFFFF")
          .selectedColor("#FF8B5CF6")
          .trackColor("#FFE0E0E0")
          .width("100%")
          .onChange((value: number) => {
            this.fontSize = value;
          })

        Text("Sync Progress")
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor("#FF1E1E1E")

        Progress({ value: this.syncProgress * 100, total: 100, type: ProgressType.Linear })
          .color("#FF8B5CF6")
          .backgroundColor("#FFD6C9F5")
          .width("100%")
          .height(6)

        Row({ space: 12 }) {
          Button("Sync +")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor("#FFFFFFFF")
            .backgroundColor("#FF8B5CF6")
            .borderRadius(14)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })

          Button("Sync -")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor("#FFFFFFFF")
            .backgroundColor("#FFD946EF")
            .borderRadius(14)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
            })
        }
        .width("100%")
      }
      .width("100%")
      .padding(16)
      .flexGrow(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ["#FFF1E9FE", 0.0],
          ["#FFF9F5FF", 0.5],
          ["#FFFFFFFF", 1.0]
        ]
      })
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#FFF9F5FF")
  }
}
