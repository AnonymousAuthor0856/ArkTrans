interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

const PRIMARY: string = '#FF1976D2';
const SECONDARY: string = '#FF607D8B';
const TERTIARY: string = '#FF757575';
const BACKGROUND: string = '#FFECEFF1';
const SURFACE: string = '#FFFFFFFF';
const SURFACE_VARIANT: string = '#FFCFD8DC';
const OUTLINE: string = '#FFB0BEC5';
const SUCCESS: string = '#FF4CAF50';
const ON_BACKGROUND: string = '#FF263238';

@Entry
@Component
struct StoryEditor {
  @State private textOpacity: number = 100;
  @State private uploadProgress: number = 65;
  @State private selectedLayer: number = 3;

  private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ];

  @Builder
  private layerCard(layer: StoryLayer) {
    Column({ space: 8 }) {
      Circle()
        .width(64)
        .height(64)
        .fill(layer.id === this.selectedLayer ? '#33FFFFFF' : SURFACE_VARIANT);

      Text(layer.type)
        .fontSize(24)
        .fontColor(layer.id === this.selectedLayer ? SURFACE : '#B3263238')
        .textAlign(TextAlign.Center);

      Text(layer.content)
        .fontSize(24)
        .fontColor(layer.id === this.selectedLayer ? SURFACE : ON_BACKGROUND)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis });
    }
    .width(262)
    .height(224)
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.Center)
    .backgroundColor(layer.id === this.selectedLayer ? PRIMARY : SURFACE)
    .borderRadius(16)
    .border({
      width: 2,
      color: layer.id === this.selectedLayer ? PRIMARY : OUTLINE
    })
    .onClick(() => {
      this.selectedLayer = layer.id;
    });
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Button('Exit', { type: ButtonType.Normal })
            .fontSize(28)
            .fontColor(ON_BACKGROUND)
            .backgroundColor('#00000000')
            .padding({ left: 16, right: 16 })
            .onClick(() => {});

          Text('Story Editor')
            .layoutWeight(1)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_BACKGROUND)
            .textAlign(TextAlign.Center);

          Button('Post', { type: ButtonType.Normal })
            .fontSize(28)
            .fontColor(SURFACE)
            .backgroundColor(PRIMARY)
            .borderRadius(16)
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })
            .margin({ right: 16 })
            .onClick(() => {});
        }
        .width('100%')
        .height(128)
        .backgroundColor(SURFACE)
        .alignItems(VerticalAlign.Center);

        Scroll() {
          Column({ space: 24 }) {
            Stack({ alignContent: Alignment.Center }) {
              Text('Your Story Preview')
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .fontColor(SURFACE)
                .opacity(this.textOpacity / 100)
                .textAlign(TextAlign.Center);
            }
            .width('calc(100% - 64vp)')
            .height(400)
            .backgroundColor(TERTIARY)
            .borderRadius(24)
            .shadow({
              radius: 6,
              color: '#1A000000',
              offsetX: 0,
              offsetY: 2
            })
            .margin({ top: 32 });

            Column({ space: 12 }) {
              Text('Upload Status')
                .fontSize(26)
                .fontColor(SECONDARY)
                .width('100%');

              Progress({
                value: this.uploadProgress,
                total: 100,
                type: ProgressType.Linear
              })
                .width('100%')
                .height(16)
                .color(SUCCESS)
                .backgroundColor(SURFACE_VARIANT)
                .borderRadius(8);
            }
            .width('calc(100% - 64vp)');

            Column({ space: 12 }) {
              Text('Story Layers')
                .fontSize(26)
                .fontColor(SECONDARY)
                .width('100%');

              Scroll() {
                Row({ space: 32 }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    this.layerCard(layer);
                  }, (layer: StoryLayer) => layer.id.toString());
                }
                .padding({ left: 0, right: 24, top: 12, bottom: 12 });
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%');
            }
            .width('100%')
            .padding({ left: 32 });
          }
          .width('100%')
          .padding({ bottom: 260 });
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(BACKGROUND)
        .scrollBar(BarState.Off);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND);

      Column({ space: 20 }) {
        Text('Layer Properties')
          .fontSize(26)
          .fontColor(SECONDARY)
          .width('100%');

        Row() {
          Text('Opacity')
            .fontSize(28)
            .fontColor('#FF000000')
            .width(178);

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .blockColor(SURFACE)
            .trackColor(PRIMARY)
            .selectedColor(PRIMARY)
            .onChange((value: number) => {
              this.textOpacity = value;
            });
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);
      }
      .width('100%')
      .height(180)
      .padding({ left: 32, right: 32, top: 28, bottom: 24 })
      .backgroundColor(SURFACE)
      .shadow({
        radius: 12,
        color: '#1A000000',
        offsetX: 0,
        offsetY: -4
      });
    }
    .width('100%')
    .height('100%');
  }
}
