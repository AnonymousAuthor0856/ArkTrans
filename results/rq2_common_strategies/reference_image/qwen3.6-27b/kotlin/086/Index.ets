import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// Define the main entry component
@Entry
@Component
struct PocketBeatsApp {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 80; // Representing 0-100 for slider
  @State pads: boolean[] = new Array(16).fill(false);

  build() {
    Column() {
      // Top Header
      this.HeaderSection()

      // LCD Display / Info Panel
      this.InfoDisplay()

      // The Grid (Drum Pads)
      this.PadGrid()

      // Bottom Controls (Sliders and Transport)
      this.ControlSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 24, right: 24 })
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("POCKET")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#999999')
          .letterSpacing(2)
        
        Text("BEATS-909")
          .fontSize(28)
          .fontWeight(FontWeight.Black)
          .letterSpacing(-1)
      }
      
      Image($r('app.media.settings_icon')) // Assuming a settings icon exists or use text
        .width(32)
        .height(32)
        .objectFit(ImageFit.Contain)
        .onClick(() => {
          // Settings action
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoDisplay() {
    Row() {
      Column() {
        Text("TEMPO")
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#999999')
        
        Text(`${this.bpm}`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontFamily('monospace')
      }

      Circle({ width: 12, height: 12 })
        .fill(this.isPlaying ? '#FF5722' : '#CCCCCC')
    }
    .width('100%')
    .height(80)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .borderRadius(4)
    .border({ width: 2, color: Color.Black })
    .backgroundColor('#F5F5F5')
    .padding(16)
    .margin({ top: 20, bottom: 24 })
  }

  @Builder
  PadGrid() {
    GridContainer()
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr')
      .gaps({ row: 12, column: 12 })
      .width('100%')
      .aspectRatio(1) // Make the grid square-ish based on width
      .margin({ bottom: 24 })
      .forEach((_, index) => {
        this.DrumPad(index)
      })
  }

  @Builder
  DrumPad(index: number) {
    Column() {
      if (this.pads[index]) {
        Circle({ width: 6, height: 6 })
          .fill(Color.White)
          .margin({ bottom: 4 })
      }
      
      Text(this.getPadLabel(index))
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.pads[index] ? Color.White : '#999999')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .borderRadius(8)
    .backgroundColor(this.pads[index] ? Color.Black : '#EEEEEE')
    .border({ width: 1, color: this.pads[index] ? Color.Black : '#E0E0E0', radius: 8 })
    .onClick(() => {
      this.pads[index] = !this.pads[index];
    })
  }

  @Builder
  ControlSection() {
    Column() {
      // Sliders Row
      Row() {
        Column() {
          Text("BPM")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          
          Slider({ value: this.bpm, min: 60, max: 200, step: 1 })
            .width('100%')
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .blockColor(Color.Black)
            .showTips(false)
        }
        .layoutWeight(1)
        
        Column() {
          Text("VOL")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          
          Slider({ value: this.volume, min: 0, max: 100, step: 1 })
            .width('100%')
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .blockColor(Color.Black)
            .showTips(false)
        }
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ bottom: 24 })

      // Transport Buttons
      Row() {
        // Clear Button
        Row() {
          Image($r('app.media.delete_icon')) // Assuming delete icon
            .width(16)
            .height(16)
            .objectFit(ImageFit.Contain)
            .margin({ right: 8 })
          
          Text("CLEAR")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .borderRadius(24)
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
        .padding({ left: 24, right: 24 })
        .onClick(() => {
          this.pads.fill(false);
        })

        // Play Button (Large)
        Row() {
          if (this.isPlaying) {
            // Pause Icon
            Row() {
              Rect().width(4).height(16).fill(Color.White)
              Rect().width(4).height(16).fill(Color.White).margin({ left: 4 })
            }
          } else {
            // Play Icon
            Path()
              .commands('M0,0 L16,8 L0,16 Z')
              .fill(Color.White)
              .width(16)
              .height(16)
          }
          
          Text(this.isPlaying ? "STOP" : "PLAY")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .letterSpacing(1)
            .margin({ left: 12 })
        }
        .height(64)
        .width(140)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .borderRadius(32)
        .backgroundColor(Color.Black)
        .onClick(() => {
          this.isPlaying = !this.isPlaying;
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
  }

  getPadLabel(index: number): string {
    const labels = [
      "KICK", "SNARE", "CLAP", "HI-HAT",
      "TOM 1", "TOM 2", "CRASH", "RIDE",
      "PERC 1", "PERC 2", "FX 1", "FX 2",
      "SMP 13", "SMP 14", "SMP 15", "SMP 16"
    ];
    return labels[index] || `SMP ${index + 1}`;
  }
}

// Helper component to simulate LazyGrid behavior with fixed items
@Component
struct GridContainer {
  @BuilderParam childBuilder: () => void;
  
  build() {
    Flex() {
      ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], (index: number) => {
        this.childBuilder()
      })
    }
    .wrap(FlexWrap.Wrap)
    .width('100%')
  }
}