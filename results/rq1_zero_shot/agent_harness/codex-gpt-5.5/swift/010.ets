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
struct RootScreen {
  @State private textOpacity: number = 1.0;
  @State private uploadProgress: number = 0.65;
  @State private selectedLayer: number = 3;

  private layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ];

  @Builder
  TopBar() {
    Row() {
      Button('Exit')
        .fontSize(14)
        .fontColor('#263238')
        .backgroundColor(Color.Transparent)
        .padding({ left: 8, right: 8 })
      Blank()
      Text('Story Editor')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#263238')
      Blank()
      Button('Post')
        .fontSize(14)
        .fontColor('#FFFFFF')
        .backgroundColor('#1976D2')
        .height(36)
        .padding({ left: 12, right: 12 })
        .borderRadius(8)
        .margin({ right: 8 })
    }
    .width('100%')
    .height(64)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  PreviewCard() {
    Stack() {
      Rect()
        .width('100%')
        .height(200)
        .fill('#757575')
        .radius(12)
      Text('Your Story Preview')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('rgba(255,255,255,' + this.textOpacity.toString() + ')')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(200)
    .padding({ left: 16, right: 16 })
  }

  @Builder
  UploadStatus() {
    Column() {
      Text('Upload Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#607D8B')
      Stack({ alignContent: Alignment.Start }) {
        Rect()
          .width('100%')
          .height(8)
          .radius(4)
          .fill('#CFD8DC')
        Rect()
          .width((this.uploadProgress * 100).toString() + '%')
          .height(8)
          .radius(4)
          .fill('#4CAF50')
      }
      .width('100%')
      .height(8)
      .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 16, right: 16 })
  }

  @Builder
  LayerItem(layer: StoryLayer) {
    Button() {
      Column() {
        Circle()
          .width(32)
          .height(32)
          .fill(layer.id === this.selectedLayer ? '#33FFFFFF' : '#CFD8DC')
        Text(layer.type)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(layer.id === this.selectedLayer ? '#FFFFFF' : '#B3263238')
          .margin({ top: 8 })
        Text(layer.content)
          .fontSize(14)
          .fontColor(layer.id === this.selectedLayer ? '#FFFFFF' : '#263238')
          .textAlign(TextAlign.Center)
          .maxLines(2)
          .margin({ top: 8 })
      }
      .width(130)
      .padding({ left: 32, right: 32, top: 12, bottom: 12 })
    }
    .width(130)
    .backgroundColor(layer.id === this.selectedLayer ? '#1976D2' : '#FFFFFF')
    .border({ width: 1, color: layer.id === this.selectedLayer ? '#1976D2' : '#B0BEC5', radius: 8 })
    .borderRadius(8)
    .margin({ right: 16 })
    .onClick(() => {
      this.selectedLayer = layer.id;
    })
  }

  @Builder
  LayersSection() {
    Column() {
      Text('Story Layers')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#607D8B')
        .width('100%')
        .padding({ left: 16 })
      Scroll() {
        Row() {
          ForEach(this.layers, (layer: StoryLayer) => {
            this.LayerItem(layer)
          }, (layer: StoryLayer) => layer.id.toString())
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .scrollable(ScrollDirection.Horizontal)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomProperties() {
    Column() {
      Text('Layer Properties')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#607D8B')
      Row() {
        Text('Opacity')
          .fontSize(14)
          .fontColor('#263238')
          .width(80)
        Slider({ value: this.textOpacity, min: 0, max: 1, step: 0.01 })
          .selectedColor('#1976D2')
          .trackColor('#CFD8DC')
          .layoutWeight(1)
          .onChange((value: number) => {
            this.textOpacity = value;
          })
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            this.PreviewCard()
            this.UploadStatus()
              .margin({ top: 16 })
            this.LayersSection()
              .margin({ top: 16 })
            Blank().height(120)
          }
          .width('100%')
          .padding({ top: 16, bottom: 16 })
        }
        .layoutWeight(1)
        .backgroundColor('#ECEFF1')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#ECEFF1')

      this.BottomProperties()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ECEFF1')
  }
}
