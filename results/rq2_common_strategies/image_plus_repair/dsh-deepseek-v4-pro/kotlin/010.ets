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

const C_PRIMARY: string = '#1976D2';
const C_SECONDARY: string = '#607D8B';
const C_TERTIARY: string = '#757575';
const C_BACKGROUND: string = '#ECEFF1';
const C_SURFACE: string = '#FFFFFF';
const C_SURFACE_VARIANT: string = '#CFD8DC';
const C_OUTLINE: string = '#B0BEC5';
const C_SUCCESS: string = '#4CAF50';
const C_ON_PRIMARY: string = '#FFFFFF';
const C_ON_BACKGROUND: string = '#263238';
const C_ON_SURFACE: string = '#263238';
const C_ON_TERTIARY: string = '#FFFFFF';
const C_ON_SURFACE_70: string = '#B3263829';
const C_ON_PRIMARY_20: string = '#33FFFFFF';
const C_SHADOW: string = '#1A000000';

@Entry
@Component
struct StoryEditorPage {
  @State textOpacity: number = 1;
  @State uploadProgress: number = 0.65;
  @State selectedLayer: number = 3;
  layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ];

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_BACKGROUND)
        Row() {
          Button('Exit')
            .height(40)
            .fontSize(14)
            .fontColor(C_ON_BACKGROUND)
            .backgroundColor(Color.Transparent)
            .padding({ left: 8, right: 8 })
            .onClick(() => {})
          Blank()
          Button('Post')
            .height(40)
            .fontSize(14)
            .fontColor(C_ON_PRIMARY)
            .backgroundColor(C_PRIMARY)
            .borderRadius(8)
            .padding({ left: 8, right: 8 })
            .onClick(() => {})
        }
        .width('100%')
        .height('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height(64)
      .backgroundColor(C_SURFACE)

      Column({ space: 16 }) {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Text('Your Story Preview')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(C_ON_TERTIARY)
              .opacity(this.textOpacity)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .margin(16)
        .backgroundColor(C_TERTIARY)
        .borderRadius(12)
        .shadow({ radius: 6, color: C_SHADOW, offsetX: 0, offsetY: 2 })

        Column({ space: 8 }) {
          Text('Upload Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_SECONDARY)
          Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
            .color(C_SUCCESS)
            .backgroundColor(C_SURFACE_VARIANT)
            .width('100%')
            .height(8)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .alignItems(HorizontalAlign.Start)

        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.layers, (layer: StoryLayer) => {
              Column({ space: 8 }) {
                Column() {}
                  .width(32)
                  .height(32)
                  .backgroundColor(layer.id === this.selectedLayer ? C_ON_PRIMARY_20 : C_SURFACE_VARIANT)
                  .borderRadius(16)
                Text(layer.type)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(layer.id === this.selectedLayer ? C_ON_PRIMARY : C_ON_SURFACE_70)
                Text(layer.content)
                  .fontSize(14)
                  .fontColor(layer.id === this.selectedLayer ? C_ON_PRIMARY : C_ON_SURFACE)
              }
              .width(100)
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(layer.id === this.selectedLayer ? C_PRIMARY : C_SURFACE)
              .borderRadius(8)
              .border({ width: 1, color: layer.id === this.selectedLayer ? C_PRIMARY : C_OUTLINE })
              .onClick(() => {
                this.selectedLayer = layer.id;
              })
            }, (layer: StoryLayer) => layer.id.toString())
          }
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .width('100%')
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_SECONDARY)
        Blank()
          .height(12)
        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontColor(C_ON_SURFACE)
            .width(80)
          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet,
            direction: Axis.Horizontal
          })
            .selectedColor(C_PRIMARY)
            .trackColor(C_SURFACE_VARIANT)
            .blockColor(C_PRIMARY)
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(C_SURFACE)
      .shadow({ radius: 6, color: C_SHADOW, offsetX: 0, offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}
