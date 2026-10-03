import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// Define the main entry component
@Entry
@Component
struct PocketBeatsApp {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 80; // Representing 0-100 for ArkUI Slider
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
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
      }
      
      // Spacer to push settings icon to the right
      Blank()

      // Settings Icon (Simulated with a circle/shape as we don't have vector assets directly in code without resources)
      // Using a simple shape to represent the gear icon visually similar to screenshot
      Circle({ width: 24, height: 24 })
        .fill('#000000')
        .onClick(() => {
          // No-op
        })
    }
    .width('100%')
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
          .fontFamily('monospace') // Approximation of monospace
      }

      Blank()

      // Status Dot
      Circle({ width: 12, height: 12 })
        .fill(this.isPlaying ? '#FF5722' : '#CCCCCC')
    }
    .width('100%')
    .height(80)
    .borderWidth(2)
    .borderColor('#000000')
    .borderRadius(4)
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
      .margin({ bottom: 24 })
      .forEach((_, index: number) => {
        this.DrumPad(index)
      }, 16)
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
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.pads[index] ? '#000000' : '#EEEEEE')
    .borderWidth(1)
    .borderColor(this.pads[index] ? '#000000' : '#E0E0E0')
    .borderRadius(8)
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
            .selectedColor('#000000')
            .blockColor('#000000')
            .showTips(false)
        }
        .layoutWeight(1)
        .margin({ right: 16 })

        Column() {
          Text("VOL")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          
          Slider({ value: this.volume, min: 0, max: 100, step: 1 })
            .width('100%')
            .trackColor('#E0E0E0')
            .selectedColor('#000000')
            .blockColor('#000000')
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
          // Simulated Delete Icon
          Circle({ width: 16, height: 16 })
            .fill('#999999')
            .margin({ right: 8 })
          
          Text("CLEAR")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .borderWidth(1)
        .borderColor('#E0E0E0')
        .borderRadius(24)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.pads.fill(false);
        })

        Blank()

        // Play Button
        Row() {
          // Simulated Play/Pause Icon
          if (this.isPlaying) {
            // Pause symbol
            Row() {
              CustomRect({ rectWidth: 4, rectHeight: 16, color: Color.White })
              CustomRect({ rectWidth: 4, rectHeight: 16, color: Color.White }).margin({ left: 4 })
            }
          } else {
            // Play symbol (Triangle approximation using path or polygon)
            // Using a simple triangle shape via Path for better control
            Path()
              .width(16)
              .height(16)
              .fill(Color.White)
              .commands(`M0 0 L16 8 L0 16 Z`) // Simple triangle
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
        .backgroundColor('#000000')
        .borderRadius(32)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.isPlaying = !this.isPlaying;
        })
      }
      .width('100%')
    }
  }

  getPadLabel(index: number): string {
    switch (index) {
      case 0: return "KICK";
      case 1: return "SNARE";
      case 2: return "CLAP";
      case 3: return "HI-HAT";
      case 4: return "TOM 1";
      case 5: return "TOM 2";
      case 6: return "CRASH";
      case 7: return "RIDE";
      case 8: return "PERC 1";
      case 9: return "PERC 2";
      case 10: return "FX 1";
      case 11: return "FX 2";
      default: return `SMP ${index + 1}`;
    }
  }
}

// Helper components for shapes since we can't import vector icons directly in this text format easily
@Component
struct CustomRect {
  private rectWidth: number;
  private rectHeight: number;
  private color: ResourceColor = Color.Black;

  constructor(options: { rectWidth: number, rectHeight: number, color?: ResourceColor }) {
    super();
    this.rectWidth = options.rectWidth;
    this.rectHeight = options.rectHeight;
    if (options.color) {
      this.color = options.color;
    }
  }

  build() {
    Rect()
      .width(this.rectWidth)
      .height(this.rectHeight)
      .fill(this.color)
  }
}