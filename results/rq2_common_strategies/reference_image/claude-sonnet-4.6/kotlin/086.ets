/**
 * BeatMakerApp.ets
 * ArkTS / ArkUI port of the Kotlin Compose "BEATS-909" drum machine UI.
 * Target: HarmonyOS NEXT (DevEco Studio 5.x, API 11+)
 */

const PAD_LABELS: string[] = [
  'KICK', 'SNARE', 'CLAP', 'HI-HAT',
  'TOM 1', 'TOM 2', 'CRASH', 'RIDE',
  'PERC 1', 'PERC 2', 'FX 1', 'FX 2',
  'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16'
];

const PAD_COUNT: number = 16;

@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = [
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
    false, false, false, false
  ];

  aboutToAppear(): void {
    // Immersive mode: keep the layout edge-to-edge like enableEdgeToEdge()
    // (expandSafeArea on the root container below does the same job decoratively)
  }

  private clearPads(): void {
    const cleared: boolean[] = [];
    for (let i = 0; i < PAD_COUNT; i++) {
      cleared.push(false);
    }
    this.pads = cleared; // fresh array => ForEach keys change => full re-render
  }

  build() {
    Column() {
      // ---------------------------------------------------------------
      // Header
      // ---------------------------------------------------------------
      Row() {
        Column() {
          Text('POCKET')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#9E9E9E')
            .letterSpacing(2)
          Text('BEATS-909')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)

        Text('⚙')
          .fontSize(26)
          .fontColor(Color.Black)
          .onClick(() => {
            // no-op, mirrors the Compose IconButton
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // ---------------------------------------------------------------
      // LCD / Info panel
      // ---------------------------------------------------------------
      Row() {
        Column() {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#9E9E9E')
          Text(this.bpm.toFixed(0))
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontFamily('monospace')
            .fontColor(Color.Black)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Circle()
          .width(12)
          .height(12)
          .fill(this.isPlaying ? '#FF5722' : '#D3D3D3')
      }
      .width('100%')
      .height(80)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .border({ width: 2, color: Color.Black, radius: 4 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // ---------------------------------------------------------------
      // 4 x 4 drum pad grid
      // ---------------------------------------------------------------
      Flex({
        wrap: FlexWrap.Wrap,
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Start
      }) {
        ForEach(this.pads, (isActive: boolean, index: number) => {
          Column() {
            if (isActive) {
              Circle()
                .width(6)
                .height(6)
                .fill(Color.White)
            }
            Text(PAD_LABELS[index])
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(isActive ? Color.White : '#9E9E9E')
              .maxLines(1)
              .textAlign(TextAlign.Center)
              .margin({ top: isActive ? 4 : 0 })
          }
          .width('23%')
          .aspectRatio(1)
          .margin({ bottom: 12 })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(isActive ? Color.Black : '#EEEEEE')
          .border({
            width: 1,
            color: isActive ? Color.Black : '#E0E0E0',
            radius: 8
          })
          .onClick(() => {
            this.pads[index] = !this.pads[index];
          })
        }, (isActive: boolean, index: number) => index + '_' + isActive)
      }
      .width('100%')

      // ---------------------------------------------------------------
      // Bottom controls: sliders + transport
      // ---------------------------------------------------------------
      Column() {
        Row() {
          // BPM slider
          Column() {
            Text('BPM')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
            Slider({
              value: this.bpm,
              min: 60,
              max: 200,
              step: 1,
              style: SliderStyle.OutSet
            })
              .blockColor(Color.Black)
              .selectedColor(Color.Black)
              .trackColor('#E0E0E0')
              .width('100%')
              .onChange((value: number, mode: SliderChangeMode) => {
                this.bpm = value;
              })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          // Volume slider
          Column() {
            Text('VOL')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
            Slider({
              value: this.volume,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .blockColor(Color.Black)
              .selectedColor(Color.Black)
              .trackColor('#E0E0E0')
              .width('100%')
              .onChange((value: number, mode: SliderChangeMode) => {
                this.volume = value;
              })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 16 })
        }
        .width('100%')

        // Transport row
        Row() {
          // CLEAR (outlined pill)
          Row() {
            Text('▤')
              .fontSize(12)
              .fontColor('#9E9E9E')
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ left: 8 })
          }
          .height(48)
          .padding({ left: 24, right: 24 })
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            this.clearPads();
          })

          // PLAY / STOP (filled pill)
          Row() {
            if (this.isPlaying) {
              // Pause glyph: two bars drawn as Rects
              Row({ space: 6 }) {
                Rect().width(4).height(14).fill(Color.White).radius(1)
                Rect().width(4).height(14).fill(Color.White).radius(1)
              }
            } else {
              // Play glyph: triangle path
              Path()
                .width(16)
                .height(16)
                .commands('M0 0 L16 8 L0 16 Z')
                .fill(Color.White)
            }

            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .letterSpacing(1)
              .margin({ left: 12 })
          }
          .width(140)
          .height(64)
          .backgroundColor(Color.Black)
          .borderRadius(32)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            this.isPlaying = !this.isPlaying;
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}