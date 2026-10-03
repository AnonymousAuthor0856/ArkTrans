// 007_StoryEditor_en
// UI_TYPE: Social
// STYLE_THEME: Monochrome
// LANG: en
// BASELINE_SIZE: 720x1280

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

interface PaddingValues {
  horizontal?: Length;
  vertical?: Length;
}

@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1;
  @State uploadProgress: number = 0.65;
  @State selectedLayer: number = 3;
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
        Button("Exit")
          .backgroundColor(Color.Transparent)
          .fontColor('#FF263238')
          .padding({ left: 8, right: 8 })
          .height(40);

        Text("Story Editor")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Button("Post")
          .backgroundColor('#FF1976D2')
          .fontColor('#FFFFFFFF')
          .borderRadius(8)
          .padding({ left: 12, right: 12 })
          .height(40);
      }
      .width('100%')
      .height(56)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#FFFFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      // Content Area
      Column() {
        // Story Preview Card
        Column() {
          Text("Your Story Preview")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(`rgba(255, 255, 255, ${this.textOpacity})`)
            .textAlign(TextAlign.Center);
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .backgroundColor('#FF757575')
        .borderRadius(12)
        .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: 16 });

        // Upload Status
        Column() {
          Text("Upload Status")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF607D8B')
            .margin({ bottom: 4 });

          Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#FF4CAF50')
            .backgroundColor('#FFCFD8DC');
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 8 });

        // Layers List
        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.layers, (layer: StoryLayer) => {
              this.LayerCard(layer)
            })
          }
          .padding({ left: 16, right: 16, top: 12, bottom: 12 });
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%');
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 16, bottom: 16 });

      // Bottom Bar
      Column() {
        Text("Layer Properties")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF607D8B')
          .margin({ bottom: 12 });

        Row() {
          Text("Opacity")
            .fontSize(14)
            .width(80);

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .trackColor('#FFCFD8DC')
            .selectedColor('#FF1976D2')
            .blockColor('#FF1976D2')
            .onChange((value: number) => {
              this.textOpacity = value;
            });
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFECEFF1');
  }

  @Builder
  LayerCard(layer: StoryLayer) {
    Column() {
      Column()
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.selectedLayer === layer.id ? '#33FFFFFF' : '#FFCFD8DC')
        .margin({ bottom: 8 });

      Text(layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedLayer === layer.id ? '#FFFFFFFF' : '#B3263238')
        .margin({ bottom: 4 });

      Text(layer.content)
        .fontSize(14)
        .fontColor(this.selectedLayer === layer.id ? '#FFFFFFFF' : '#FF263238');
    }
    .width(100)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(this.selectedLayer === layer.id ? '#FF1976D2' : '#FFFFFFFF')
    .borderRadius(8)
    .border({ width: 1, color: this.selectedLayer === layer.id ? '#FF1976D2' : '#FFB0BEC5' })
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedLayer = layer.id;
    });
  }
}