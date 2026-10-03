// entry/src/main/ets/pages/Index.ets

interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

const COLOR_PRIMARY: string = '#1976D2';
const COLOR_SECONDARY: string = '#607D8B';
const COLOR_TERTIARY: string = '#757575';
const COLOR_BACKGROUND: string = '#ECEFF1';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#CFD8DC';
const COLOR_OUTLINE: string = '#B0BEC5';
const COLOR_SUCCESS: string = '#4CAF50';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_BACKGROUND: string = '#263238';
const COLOR_ON_SURFACE: string = '#263238';
const COLOR_ON_TERTIARY: string = '#FFFFFF';
const COLOR_ON_SURFACE_70: string = '#B3263238';
const COLOR_ON_PRIMARY_20: string = '#331976D2';
const SHADOW_1: string = '#1A000000';

const SPACE_SM: number = 8;
const SPACE_MD: number = 12;
const SPACE_LG: number = 16;

@Entry
@Component
struct Index {
  @State textOpacity: number = 1.0;
  @State uploadProgress: number = 0.65;
  @State selectedLayer: number = 3;

  private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ];

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Story Editor')
        .fontSize(18)
        .fontWeight(500)
        .fontColor(COLOR_ON_BACKGROUND)

      Row() {
        Text('Exit')
          .fontSize(16)
          .fontWeight(400)
          .fontColor(COLOR_ON_BACKGROUND)
          .padding({ left: SPACE_SM, right: SPACE_SM })
          .onClick(() => {
          })

        Button('Post')
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontWeight(500)
          .fontColor(COLOR_ON_PRIMARY)
          .backgroundColor(COLOR_PRIMARY)
          .height(40)
          .borderRadius(8)
          .padding({ left: SPACE_LG, right: SPACE_LG })
          .onClick(() => {
          })
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: SPACE_SM, right: SPACE_SM })
    }
    .width('100%')
    .height(56)
    .backgroundColor(COLOR_SURFACE)
  }

  @Builder
  StoryPreview() {
    Column() {
      Column() {
        Text('Your Story Preview')
          .fontSize(24)
          .fontWeight(600)
          .fontColor(COLOR_ON_TERTIARY)
          .opacity(this.textOpacity)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .borderRadius(12)
      .backgroundColor(COLOR_TERTIARY)
      .shadow({ radius: 3, color: SHADOW_1, offsetX: 0, offsetY: 1 })
    }
    .width('100%')
    .layoutWeight(1)
    .padding(SPACE_LG)
  }

  @Builder
  UploadStatus() {
    Column() {
      Text('Upload Status')
        .fontSize(12)
        .fontWeight(500)
        .fontColor(COLOR_SECONDARY)

      Stack({ alignContent: Alignment.Start }) {
        Rect()
          .width('100%')
          .height(8)
          .radius(4)
          .fill(COLOR_SURFACE_VARIANT)

        Rect()
          .width(`${this.uploadProgress * 100}%`)
          .height(8)
          .radius(4)
          .fill(COLOR_SUCCESS)

        Row() {
          Blank()

          Circle()
            .width(8)
            .height(8)
            .fill(COLOR_SUCCESS)
        }
        .width('100%')
        .height(8)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(8)
      .margin({ top: SPACE_SM })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: SPACE_LG, right: SPACE_LG })
  }

  @Builder
  LayerStrip() {
    List({ space: SPACE_MD }) {
      ForEach(this.layers, (layer: StoryLayer) => {
        ListItem() {
          Column() {
            Circle()
              .width(32)
              .height(32)
              .fill(layer.id === this.selectedLayer ? COLOR_ON_PRIMARY_20 : COLOR_SURFACE_VARIANT)

            Text(layer.type)
              .fontSize(12)
              .fontWeight(500)
              .fontColor(layer.id === this.selectedLayer ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE_70)
              .margin({ top: SPACE_SM })

            Text(layer.content)
              .fontSize(14)
              .fontWeight(400)
              .fontColor(layer.id === this.selectedLayer ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
              .margin({ top: SPACE_SM })
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .width(132)
          .padding({
            left: SPACE_LG,
            right: SPACE_LG,
            top: SPACE_MD,
            bottom: SPACE_MD
          })
          .alignItems(HorizontalAlign.Center)
          .borderRadius(8)
          .border({
            width: 1,
            color: layer.id === this.selectedLayer ? COLOR_PRIMARY : COLOR_OUTLINE
          })
          .backgroundColor(layer.id === this.selectedLayer ? COLOR_PRIMARY : COLOR_SURFACE)
        }
        .onClick(() => {
          this.selectedLayer = layer.id;
        })
      }, (layer: StoryLayer) => `${layer.id}-${layer.id === this.selectedLayer}`)
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(110)
    .padding({
      left: SPACE_LG,
      right: SPACE_LG,
      top: SPACE_MD,
      bottom: SPACE_MD
    })
  }

  @Builder
  LayerProperties() {
    Column() {
      Text('Layer Properties')
        .fontSize(12)
        .fontWeight(500)
        .fontColor(COLOR_SECONDARY)

      Row() {
        Text('Opacity')
          .fontSize(14)
          .fontWeight(400)
          .fontColor(COLOR_ON_SURFACE)
          .width(80)

        Slider({
          value: this.textOpacity,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.InSet
        })
          .layoutWeight(1)
          .selectedColor(COLOR_PRIMARY)
          .trackColor(COLOR_SURFACE_VARIANT)
          .blockColor(COLOR_PRIMARY)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.textOpacity = value;
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: SPACE_MD })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(SPACE_LG)
    .backgroundColor(COLOR_BACKGROUND)
    .border({ width: { top: 1 }, color: COLOR_OUTLINE })
    .shadow({ radius: 6, color: SHADOW_1, offsetX: 0, offsetY: -2 })
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        this.StoryPreview()
        this.UploadStatus()
        this.LayerStrip()
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      this.LayerProperties()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}