// Color constants
const pureWhite = '#FFFFFFFF';
const offWhite = '#FFFAFAFA';
const textPrimary = '#FF1A1A1A';
const textSecondary = '#FF757575';
const accentGreen = '#FF4CAF50';
const accentWarning = '#FFFF9800';
const dividerColor = '#FFEEEEEE';

@Entry
@Component
struct AeroSenseContentView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Header
        Row() {
          Column() {
            Text('Living Room')
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .fontColor(textSecondary)
            Text('AeroSense')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .fontColor(textPrimary)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button({ type: ButtonType.Circle }) {
            Text('⚙')
              .fontSize(22)
              .fontColor(textPrimary)
          }
          .width(48)
          .height(48)
          .backgroundColor(offWhite)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 50, bottom: 24 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Main Content
        Scroll() {
          Column({ space: 32 }) {
            // Air Quality Circle
            AirQualityCircleComponent({ aqi: 42 })

            // Metrics Grid
            Column({ space: 16 }) {
              Row({ space: 16 }) {
                MetricCardComponent({
                  label: 'Temp',
                  value: '23°C',
                  iconText: 'ℹ',
                  statusColor: textPrimary
                })
                MetricCardComponent({
                  label: 'Humidity',
                  value: '45%',
                  iconText: '✓',
                  statusColor: accentGreen
                })
              }
              .width('100%')

              Row({ space: 16 }) {
                MetricCardComponent({
                  label: 'PM 2.5',
                  value: '12',
                  iconText: '✓',
                  statusColor: accentGreen
                })
                MetricCardComponent({
                  label: 'CO2',
                  value: '850',
                  iconText: '⚠',
                  statusColor: accentWarning
                })
              }
              .width('100%')
            }
            .width('100%')

            // Status Banner
            StatusBannerComponent()
          }
          .padding({ top: 16, bottom: 100 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .padding({ left: 24, right: 24 })
        .layoutWeight(1)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(pureWhite)
      .alignItems(HorizontalAlign.Start)

      // Bottom Control Bar
      BottomControlBarComponent()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(pureWhite)
  }
}

@Component
struct AirQualityCircleComponent {
  aqi: number = 42;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.ctx)
        .width(220)
        .height(220)
        .onReady(() => {
          const lineWidth = 40;
          const size = 220;
          const radius = (size - lineWidth) / 2;
          const cx = size / 2;
          const cy = size / 2;

          // Background track
          this.ctx.beginPath();
          this.ctx.arc(cx, cy, radius, (135 * Math.PI) / 180, ((135 + 270) * Math.PI) / 180, false);
          this.ctx.strokeStyle = offWhite;
          this.ctx.lineWidth = lineWidth;
          this.ctx.lineCap = 'round';
          this.ctx.stroke();

          // Progress track
          this.ctx.beginPath();
          this.ctx.arc(cx, cy, radius, (135 * Math.PI) / 180, ((135 + 110) * Math.PI) / 180, false);
          this.ctx.strokeStyle = accentGreen;
          this.ctx.lineWidth = lineWidth;
          this.ctx.lineCap = 'round';
          this.ctx.stroke();

          // Dot at end of progress
          const dotRadius = 12;
          const angleRad = ((135 + 110) * Math.PI) / 180;
          const dotX = cx + radius * Math.cos(angleRad);
          const dotY = cy + radius * Math.sin(angleRad);
          this.ctx.beginPath();
          this.ctx.arc(dotX, dotY, dotRadius / 2, 0, 2 * Math.PI, false);
          this.ctx.fillStyle = pureWhite;
          this.ctx.fill();
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(textSecondary)
          .letterSpacing(2)
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(textPrimary)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(accentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#1A4CAF50')
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(220)
  }
}

@Component
struct MetricCardComponent {
  label: string = '';
  value: string = '';
  iconText: string = '';
  statusColor: string = textPrimary;

  build() {
    Column() {
      Row() {
        Text(this.iconText)
          .fontSize(20)
          .fontColor(this.statusColor)
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .borderRadius(14)
          .backgroundColor(this.statusColor === accentGreen ? '#1A4CAF50' :
            this.statusColor === accentWarning ? '#1AFF9800' : '#1A1A1A1A')
        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(textPrimary)
        Text(this.label)
          .fontSize(12)
          .fontColor(textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .height(110)
    .layoutWeight(1)
    .backgroundColor(offWhite)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct StatusBannerComponent {
  build() {
    Column() {
      Row() {
        Text('🏠')
          .fontSize(22)
          .fontColor(textPrimary)
        Blank().width(12)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(textPrimary)
        Blank()
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank().height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(textSecondary)
        .lineHeight(22)
        .width('100%')
    }
    .padding(20)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .border({ width: 1, color: dividerColor, radius: 20 })
  }
}

@Component
struct BottomControlBarComponent {
  build() {
    Column() {
      Divider()
        .color(dividerColor)
        .strokeWidth(1)

      Row() {
        // Menu icon
        Button({ type: ButtonType.Circle }) {
          Column({ space: 4 }) {
            Divider().strokeWidth(2).color(textPrimary).width(20)
            Divider().strokeWidth(2).color(textPrimary).width(20)
            Divider().strokeWidth(2).color(textPrimary).width(20)
          }
          .width(24)
          .height(18)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width(48)
        .height(48)
        .backgroundColor(pureWhite)
        .border({ width: 1, color: dividerColor, radius: 24 })

        Blank()

        // Refresh button
        Button() {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(18)
              .fontColor(pureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(pureWhite)
          }
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .backgroundColor(textPrimary)
        .borderRadius(16)
        .type(ButtonType.Normal)

        Blank()

        // Add icon
        Button({ type: ButtonType.Circle }) {
          Text('+')
            .fontSize(24)
            .fontColor(textPrimary)
        }
        .width(48)
        .height(48)
        .backgroundColor(pureWhite)
        .border({ width: 1, color: dividerColor, radius: 24 })
      }
      .padding(24)
      .width('100%')
      .backgroundColor(pureWhite)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .backgroundColor(pureWhite)
  }
}