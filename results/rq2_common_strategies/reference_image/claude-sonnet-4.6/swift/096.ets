/**
 * AeroSense — ArkTS / ArkUI 版本
 * 由 SwiftUI 源码 1:1 转换
 */
import { window } from '@kit.ArkUI';

// MARK: - 1. Colors
const PURE_WHITE: string = '#FFFFFF';
const OFF_WHITE: string = '#FAFAFA';
const TEXT_PRIMARY: string = '#1A1A1A';
const TEXT_SECONDARY: string = '#757575';
const ACCENT_GREEN: string = '#4CAF50';
const ACCENT_WARNING: string = '#FF9800';
const DIVIDER_COLOR: string = '#EEEEEE';
const ACCENT_GREEN_10: string = '#1A4CAF50'; // AccentGreen.copy(alpha = 0.1f)

// MARK: - 3. Top Header
@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(TEXT_SECONDARY)
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Text('\u2699') // gearshape.fill
          .fontSize(24)
          .fontColor(TEXT_PRIMARY)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(OFF_WHITE)
      .onClick(() => {
        // No op
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - 5. Air Quality Circle
@Component
struct AirQualityCircle {
  aqi: number = 42;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private drawGauge(): void {
    const size: number = 220;
    const lineWidth: number = 40;
    const radius: number = (size - lineWidth) / 2;
    const cx: number = size / 2;
    const cy: number = size / 2;
    const startAngle: number = 135 * Math.PI / 180;
    const totalSweep: number = 270 * Math.PI / 180;
    const progressSweep: number = totalSweep * (this.aqi / 100);

    this.ctx.clearRect(0, 0, size, size);
    this.ctx.lineWidth = lineWidth;
    this.ctx.lineCap = 'round';

    // 背景轨道
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, radius, startAngle, startAngle + totalSweep, false);
    this.ctx.strokeStyle = OFF_WHITE;
    this.ctx.stroke();

    // 进度轨道
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, radius, startAngle, startAngle + progressSweep, false);
    this.ctx.strokeStyle = ACCENT_GREEN;
    this.ctx.stroke();

    // 装饰点（进度末端）
    const endAngle: number = startAngle + progressSweep;
    const dotX: number = cx + radius * Math.cos(endAngle);
    const dotY: number = cy + radius * Math.sin(endAngle);
    this.ctx.beginPath();
    this.ctx.arc(dotX, dotY, 6, 0, Math.PI * 2, false);
    this.ctx.fillStyle = PURE_WHITE;
    this.ctx.fill();
  }

  build() {
    Stack() {
      Canvas(this.ctx)
        .width(220)
        .height(220)
        .onReady(() => {
          this.drawGauge();
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_SECONDARY)
          .letterSpacing(2)
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT_PRIMARY)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ACCENT_GREEN)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(ACCENT_GREEN_10)
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }
}

// MARK: - 6. Metric Card
@Component
struct MetricCard {
  label: string = '';
  value: string = '';
  iconKind: string = 'check'; // 'check' | 'info' | 'warning'
  statusColor: string = TEXT_PRIMARY;

  @Builder
  StatusIcon() {
    if (this.iconKind === 'warning') {
      Text('\u26A0') // exclamationmark.triangle.fill
        .fontSize(20)
        .fontColor(this.statusColor)
    } else {
      Stack() {
        Text(this.iconKind === 'info' ? 'i' : '\u2713')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(PURE_WHITE)
      }
      .width(22)
      .height(22)
      .borderRadius(11)
      .backgroundColor(this.statusColor)
    }
  }

  build() {
    Column() {
      Row() {
        this.StatusIcon()
        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
        Text(this.label)
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(110)
    .layoutWeight(1)
    .padding(16)
    .backgroundColor(OFF_WHITE)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - 7. Status Banner
@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Text('\u2302') // house.fill
          .fontSize(24)
          .fontColor(TEXT_PRIMARY)
        Blank().width(12)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
      }
      .alignItems(VerticalAlign.Center)

      Blank().height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TEXT_SECONDARY)
        .lineHeight(22)
        .width('100%')
    }
    .width('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(20)
    .border({ width: 1, color: DIVIDER_COLOR })
  }
}

// MARK: - 4. Main Content
@Component
struct MainContent {
  build() {
    Scroll() {
      Column({ space: 32 }) {
        AirQualityCircle({ aqi: 42 })

        Column({ space: 16 }) {
          Row({ space: 16 }) {
            MetricCard({
              label: 'Temp',
              value: '23\u00B0C',
              iconKind: 'info',
              statusColor: TEXT_PRIMARY
            })
            MetricCard({
              label: 'Humidity',
              value: '45%',
              iconKind: 'check',
              statusColor: ACCENT_GREEN
            })
          }
          .width('100%')

          Row({ space: 16 }) {
            MetricCard({
              label: 'PM 2.5',
              value: '12',
              iconKind: 'check',
              statusColor: ACCENT_GREEN
            })
            MetricCard({
              label: 'CO2',
              value: '850',
              iconKind: 'warning',
              statusColor: ACCENT_WARNING
            })
          }
          .width('100%')
        }
        .width('100%')

        StatusBanner()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 24, right: 24 })
  }
}

// MARK: - 9. Control Icon
@Component
struct ControlIcon {
  icon: string = '';
  description: string = '';

  build() {
    Stack() {
      Text(this.icon)
        .fontSize(24)
        .fontColor(TEXT_PRIMARY)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .border({ width: 1, color: DIVIDER_COLOR })
    .accessibilityText(this.description)
    .onClick(() => {
      // No op
    })
  }
}

// MARK: - 8. Bottom Control Bar
@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .strokeWidth(1)
        .color(DIVIDER_COLOR)

      Row() {
        ControlIcon({ icon: '\u2630', description: 'Menu' }) // line.horizontal.3

        Row({ space: 8 }) {
          Text('\u21BB') // arrow.clockwise
            .fontSize(18)
            .fontColor(PURE_WHITE)
          Text('Refresh Data')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(PURE_WHITE)
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .backgroundColor(TEXT_PRIMARY)
        .borderRadius(16)
        .onClick(() => {
          // No op
        })

        ControlIcon({ icon: '+', description: 'Add Room' }) // add
      }
      .width('100%')
      .padding(24)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(PURE_WHITE)
    }
    .width('100%')
  }
}

// MARK: - 2. Main App Structure (入口)
@Entry
@Component
struct AeroSensePage {
  aboutToAppear(): void {
    // 全屏显示并隐藏顶部状态栏
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch(() => {
        // 忽略窗口设置失败
      });
  }

  build() {
    Column() {
      TopHeader()
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      MainContent()

      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PURE_WHITE)
  }
}