@Entry
@Component
struct Index {
  @State textOpacity: number = 1.0;
  @State uploadProgress: number = 0.65;
  @State selectedLayerId: number = 3;

  private layers: StoryLayer[] = [
    { id: 1, type: "BG", content: "Gradient" },
    { id: 2, type: "IMG", content: "User Photo" },
    { id: 3, type: "TXT", content: "Hello World" },
    { id: 4, type: "ICO", content: "Sticker" }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button("Exit")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')
          .backgroundColor(Color.Transparent)
          .borderRadius(8)
          .margin({ left: 8, right: 8 })

        Text("Story Editor")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button("Post")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .backgroundColor('#1976D2')
          .borderRadius(8)
          .margin({ left: 8, right: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)

      // Main Content
      Column() {
        // Story Preview Card
        Column() {
          Text("Your Story Preview")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(`rgba(255, 255, 255, ${this.textOpacity})`)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ left: 16, right: 16, top: 16, bottom: 16 })
        .backgroundColor('#757575')
        .borderRadius(24)
        .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.1)', offsetY: 1 })

        // Upload Status
        Column({ space: 8 }) {
          Text("Upload Status")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#607D8B')

          Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#4CAF50')
            .backgroundColor('#CFD8DC')
            .borderRadius(4)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 8 })

        // Layer Cards - Horizontal Scroll
        List({ space: 12 }) {
          ForEach(this.layers, (layer: StoryLayer) => {
            ListItem() {
              Column() {
                Circle({ width: 32, height: 32 })
                  .fill(layer.id === this.selectedLayerId
                    ? 'rgba(255, 255, 255, 0.2)'
                    : '#CFD8DC')

                Text(layer.type)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(layer.id === this.selectedLayerId
                    ? Color.White
                    : 'rgba(38, 50, 56, 0.7)')

                Text(layer.content)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(layer.id === this.selectedLayerId
                    ? Color.White
                    : '#263238')
              }
              .width(100)
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(layer.id === this.selectedLayerId
                ? '#1976D2'
                : Color.White)
              .borderRadius(12)
              .border({
                width: 1,
                color: layer.id === this.selectedLayerId
                  ? '#1976D2'
                  : '#B0BEC5'
              })
              .onClick(() => {
                this.selectedLayerId = layer.id;
              })
            }
          }, (layer: StoryLayer) => layer.id.toString())
        }
        .width('100%')
        .height(120)
        .listDirection(Axis.Horizontal)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .scrollBar(BarState.Off)
        .divider(null)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#ECEFF1')

      // Bottom Bar - Layer Properties
      Column() {
        Text("Layer Properties")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#607D8B')
          .margin({ bottom: 12 })

        Row() {
          Text("Opacity")
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .width(80)

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .blockColor('#1976D2')
            .trackColor('#CFD8DC')
            .selectedColor('#1976D2')
            .onChange((value: number) => {
              this.textOpacity = value;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.1)', offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ECEFF1')
  }
}

interface StoryLayer {
  id: number;
  type: string;
  content: string;
}
