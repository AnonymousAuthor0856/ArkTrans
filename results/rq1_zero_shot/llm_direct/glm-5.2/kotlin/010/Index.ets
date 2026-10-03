// 007_StoryEditor_en.ets

class StoryLayer {
  id: number;
  type: string;
  content: string;

  constructor(id: number, type: string, content: string) {
    this.id = id;
    this.type = type;
    this.content = content;
  }
}

@Entry
@Component
struct StoryEditor {
  @State private textOpacity: number = 1.0;
  @State private uploadProgress: number = 0.65;
  @State private selectedLayer: number = 3;

  private layers: StoryLayer[] = [
    new StoryLayer(1, "BG", "Gradient"),
    new StoryLayer(2, "IMG", "User Photo"),
    new StoryLayer(3, "TXT", "Hello World"),
    new StoryLayer(4, "ICO", "Sticker")
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Exit")
          .fontSize(14)
          .fontColor("#263238")
          .padding({ left: 8, right: 8 })
        Text("Story Editor")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text("Post")
          .fontSize(14)
          .fontColor("#FFFFFF")
          .backgroundColor("#1976D2")
          .borderRadius(8)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .backgroundColor("#FFFFFF")
      .alignItems(VerticalAlign.Center)

      // Main Content
      Scroll() {
        Column() {
          // Story Preview Card
          Column() {
            Text("Your Story Preview")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(`rgba(38, 50, 56, ${this.textOpacity})`)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .layoutWeight(1)
          .margin(16)
          .padding(16)
          .backgroundColor("#757575")
          .borderRadius(12)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)

          // Upload Status
          Column() {
            Text("Upload Status")
              .fontSize(12)
              .fontColor("#607D8B")
              .margin({ bottom: 4 })
            Progress({ value: Math.floor(this.uploadProgress * 100), total: 100, type: ProgressType.Linear })
              .width('100%')
              .color("#4CAF50")
              .backgroundColor("#CFD8DC")
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 8 })

          // Layers List
          Row() {
            ForEach(this.layers, (layer: StoryLayer) => {
              LayerCard({
                layer: layer,
                isSelected: this.selectedLayer === layer.id,
                onClick: () => {
                  this.selectedLayer = layer.id;
                }
              })
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
      }
      .layoutWeight(1)
      .backgroundColor("#ECEFF1")

      // Bottom Bar
      Column() {
        Text("Layer Properties")
          .fontSize(12)
          .fontColor("#607D8B")
          .margin({ bottom: 12 })
        Row() {
          Text("Opacity")
            .fontSize(14)
            .width(80)
          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .selectedColor("#1976D2")
            .trackColor("#CFD8DC")
            .onChange((value: number) => {
              this.textOpacity = value;
            })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor("#FFFFFF")
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct LayerCard {
  @Prop layer: StoryLayer;
  @Prop isSelected: boolean;
  private onClick: () => void = () => {};

  build() {
    Column() {
      Column()
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.isSelected ? "rgba(255,255,255,0.2)" : "#CFD8DC")
      Text(this.layer.type)
        .fontSize(12)
        .fontColor(this.isSelected ? "#FFFFFF" : "rgba(38, 50, 56, 0.7)")
        .margin({ top: 8 })
      Text(this.layer.content)
        .fontSize(14)
        .fontColor(this.isSelected ? "#FFFFFF" : "#263238")
        .margin({ top: 4 })
    }
    .width(100)
    .padding({ top: 12, bottom: 12, left: 16, right: 16 })
    .backgroundColor(this.isSelected ? "#1976D2" : "#FFFFFF")
    .borderRadius(8)
    .border({ width: 1, color: this.isSelected ? "#1976D2" : "#B0BEC5" })
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.onClick();
    })
  }
}