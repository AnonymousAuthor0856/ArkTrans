// entry/src/main/ets/pages/Index.ets
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

const PURE_WHITE: string = '#FFFFFF';
const OFF_WHITE: string = '#FAFAFA';
const TEXT_PRIMARY: string = '#1A1A1A';
const TEXT_SECONDARY: string = '#757575';
const ACCENT_GREEN: string = '#4CAF50';
const ACCENT_GREEN_TINT: string = '#1A4CAF50'; // 10% alpha green
const ACCENT_WARNING: string = '#FF9800';
const DIVIDER_COLOR: string = '#EEEEEE';

@Entry
@Component
struct AeroSenseApp {
  @State aqi: number = 42;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    // Edge-to-edge / immersive: draw under the system bars.
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true).catch((e: BusinessError) => {
          console.error(`setWindowLayoutFullScreen failed: ${e.code}`);
        });
      })
      .catch((e: BusinessError) => {
        console.error(`getLastWindow failed: ${e.code}`);
      });
  }

  private deg(degrees: number): number {
    return degrees * Math.PI / 180;
  }

  private drawRing(): void {
    const size: number = 240;
    const cx: number = size / 2;
    const cy: number = size / 2;
    const radius: number = 100;

    this.ctx.clearRect(0, 0, size, size);
    this.ctx.lineCap = 'round';
    this.ctx.lineWidth = 32;

    // Background track: 270 degrees, gap at the bottom.
    this.ctx.beginPath();
    this.ctx.strokeStyle = OFF_WHITE;
    this.ctx.arc(cx, cy, radius, this.deg(135), this.deg(405), false);
    this.ctx.stroke();

    // Progress track, proportional to the AQI value.
    const clamped: number = this.aqi > 100 ? 100 : this.aqi;
    const sweep: number = 270 * clamped / 100;
    this.ctx.beginPath();
    this.ctx.strokeStyle = ACCENT_GREEN;
    this.ctx.arc(cx, cy, radius, this.deg(135), this.deg(135 + sweep), false);
    this.ctx.stroke();

    // Decorative white notch on the track.
    this.ctx.beginPath();
    this.ctx.fillStyle = PURE_WHITE;
    this.ctx.arc(cx + radius * 0.7, cy + radius * 0.7, 13, 0, Math.PI * 2, false);
    this.ctx.fill();
  }

  private refreshData(): void {
    this.aqi = (this.aqi === 42) ? 68 : 42;
    this.drawRing();
  }

  build() {
    Column() {
      this.TopHeader()
      Scroll() {
        Column({ space: 32 }) {
          this.AirQualityCircle()
          this.MetricsGrid()
          this.StatusBanner()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
      .edgeEffect(EdgeEffect.Spring)

      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PURE_WHITE)
  }

  @Builder
  TopHeader() {
    Row() {
      Column({ space: 2 }) {
        Text('Living Room')
          .fontSize(16)
          .fontColor(TEXT_SECONDARY)
          .fontWeight(FontWeight.Normal)
        Text('AeroSense')
          .fontSize(28)
          .fontColor(TEXT_PRIMARY)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Text('⚙')
        .fontSize(22)
        .fontColor(TEXT_PRIMARY)
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
        .backgroundColor(OFF_WHITE)
        .borderRadius(24)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 32, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  AirQualityCircle() {
    Stack() {
      Canvas(this.ctx)
        .width(240)
        .height(240)
        .onReady(() => {
          this.drawRing();
        })

      Column({ space: 4 }) {
        Text('AQI')
          .fontSize(14)
          .fontColor(TEXT_SECONDARY)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontColor(TEXT_PRIMARY)
          .fontWeight(FontWeight.Medium)
          .lineHeight(88)
        Text('Excellent')
          .fontSize(16)
          .fontColor(ACCENT_GREEN)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(ACCENT_GREEN_TINT)
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(260)
    .alignContent(Alignment.Center)
  }

  @Builder
  MetricCard(label: string, value: string, glyph: string, statusColor: string) {
    Column() {
      Row() {
        Text(glyph)
          .fontSize(18)
          .fontColor(statusColor)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column({ space: 2 }) {
        Text(value)
          .fontSize(24)
          .fontColor(TEXT_PRIMARY)
          .fontWeight(FontWeight.Medium)
        Text(label)
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(110)
    .padding(16)
    .backgroundColor(OFF_WHITE)
    .borderRadius(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  MetricsGrid() {
    Column({ space: 16 }) {
      Row({ space: 16 }) {
        this.MetricCard('Temp', '23°C', 'ⓘ', TEXT_PRIMARY)
        this.MetricCard('Humidity', '45%', '✓', ACCENT_GREEN)
      }
      .width('100%')

      Row({ space: 16 }) {
        this.MetricCard('PM 2.5', '12', '✓', ACCENT_GREEN)
        this.MetricCard('CO2', '850', '⚠', ACCENT_WARNING)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  StatusBanner() {
    Column() {
      Row({ space: 12 }) {
        Text('⌂')
          .fontSize(20)
          .fontColor(TEXT_PRIMARY)
        Text('Room Analysis')
          .fontSize(16)
          .fontColor(TEXT_PRIMARY)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TEXT_SECONDARY)
        .lineHeight(22)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: DIVIDER_COLOR })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ControlIcon(glyph: string) {
    Text(glyph)
      .fontSize(20)
      .fontColor(TEXT_PRIMARY)
      .width(48)
      .height(48)
      .textAlign(TextAlign.Center)
      .borderRadius(24)
      .border({ width: 1, color: DIVIDER_COLOR })
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider()
        .color(DIVIDER_COLOR)
        .strokeWidth(1)

      Row() {
        this.ControlIcon('☰')

        Button({ type: ButtonType.Normal }) {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(18)
              .fontColor(PURE_WHITE)
            Text('Refresh Data')
              .fontSize(15)
              .fontColor(PURE_WHITE)
          }
          .alignItems(VerticalAlign.Center)
        }
        .backgroundColor(TEXT_PRIMARY)
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .onClick(() => {
          this.refreshData();
        })

        this.ControlIcon('+')
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(PURE_WHITE)
  }
}