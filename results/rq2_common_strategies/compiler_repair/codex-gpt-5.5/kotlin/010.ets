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

class StoryColors {
  static primary: string = '#1976D2';
  static secondary: string = '#607D8B';
  static tertiary: string = '#757575';
  static background: string = '#ECEFF1';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#CFD8DC';
  static outline: string = '#B0BEC5';
  static success: string = '#4CAF50';
  static warning: string = '#FFC107';
  static error: string = '#F44336';
  static onPrimary: string = '#FFFFFF';
  static onTertiary: string = '#FFFFFF';
  static onBackground: string = '#263238';
  static onSurface: string = '#263238';
}

@Entry
@Component
struct Index {
  @State textOpacity: number = 1;
  @State uploadProgress: number = 0.65;
  @State selectedLayer: number = 3;

  private layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ];

  private opacityColor(): string {
    let alpha: number = Math.round(this.textOpacity * 255);
    let hex: string = alpha.toString(16).toUpperCase();
    if (hex.length < 2) {
      hex = '0' + hex;
    }
    return '#' + hex + 'FFFFFF';
  }

  @Builder
  TopBar() {
    Row() {
      Button('Exit')
        .fontSize(14)
        .fontColor(StoryColors.onBackground)
        .backgroundColor('#00FFFFFF')
        .padding({ left: 8, right: 8 })
      Text('Story Editor')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(StoryColors.onSurface)
        .lineHeight(24)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
      Button('Post')
        .fontSize(14)
        .fontColor(StoryColors.onPrimary)
        .backgroundColor(StoryColors.primary)
        .borderRadius(8)
        .padding({ left: 8, right: 8 })
    }
    .width('100%')
    .height(56)
    .padding({ left: 8, right: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(StoryColors.surface)
  }

  @Builder
  LayerCard(layer: StoryLayer) {
    Column({ space: 8 }) {
      Blank()
        .width(32)
        .height(32)
        .backgroundColor(this.selectedLayer === layer.id ? '#33FFFFFF' : StoryColors.surfaceVariant)
        .borderRadius(32)
      Text(layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedLayer === layer.id ? StoryColors.onPrimary : '#B3263238')
        .lineHeight(16)
      Text(layer.content)
        .fontSize(14)
        .fontColor(this.selectedLayer === layer.id ? StoryColors.onPrimary : StoryColors.onSurface)
        .lineHeight(20)
    }
    .width(100)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.selectedLayer === layer.id ? StoryColors.primary : StoryColors.surface)
    .border({ width: 1, color: this.selectedLayer === layer.id ? StoryColors.primary : StoryColors.outline, radius: 8 })
    .borderRadius(8)
    .onClick(() => {
      this.selectedLayer = layer.id;
    })
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: 16 }) {
        Stack() {
          Text('Your Story Preview')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.opacityColor())
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .margin(16)
        .backgroundColor(StoryColors.tertiary)
        .borderRadius(12)
        .alignContent(Alignment.Center)
        .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })

        Column({ space: 8 }) {
          Text('Upload Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(StoryColors.secondary)
            .lineHeight(16)
          Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color(StoryColors.success)
            .backgroundColor(StoryColors.surfaceVariant)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })

        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.layers, (layer: StoryLayer) => {
              this.LayerCard(layer)
            }, (layer: StoryLayer) => layer.id.toString())
          }
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(StoryColors.secondary)
          .lineHeight(16)
        Blank().height(12)
        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontColor(StoryColors.onSurface)
            .lineHeight(20)
            .width(80)
          Slider({ value: this.textOpacity * 100, min: 0, max: 100, step: 1 })
            .layoutWeight(1)
            .selectedColor(StoryColors.primary)
            .trackColor(StoryColors.surfaceVariant)
            .onChange((value: number) => {
              this.textOpacity = value / 100;
            })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(StoryColors.surface)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(StoryColors.background)
  }
}
