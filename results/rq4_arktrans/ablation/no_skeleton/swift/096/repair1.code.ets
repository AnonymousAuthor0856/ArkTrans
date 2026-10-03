import { DrawTask, CanvasContext, LineCap } from '@kit.ArkGraphics';

@Entry
@Component
struct AeroSenseApp {
  build() {
    Stack() {
      Column() {
        // Top Header
        Row() {
          Column({ space: 0 }) {
            Text('Living Room')
              .fontSize(16)
              .fontColor('#757575')
            Text('AeroSense')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1A1A1A')
          }
          Blank()
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#1A1A1A')
          }
          .backgroundColor('#FAFAFA')
          .borderRadius(24)
          .width(48)
          .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        // Main Content Scrollable
        Scroll() {
          Column({ space: 32 }) {
            // Air Quality Circle
            AirQualityCircle()

            // Metrics Grid
            Column({ space: 16 }) {
              Row({ space: 16 }) {
                MetricCard({ label: 'Temp', value: '23°C', color: '#1A1A1A' })
                MetricCard({ label: 'Humidity', value: '45%', color: '#4CAF50' })
              }
              Row({ space: 16 }) {
                MetricCard({ label: 'PM 2.5', value: '12', color: '#4CAF50' })
                MetricCard({ label: 'CO2', value: '850', color: '#FF9800' })
              }
            }

            // Status Banner
            StatusBanner()
          }
          .padding({ top: 16, bottom: 16 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // Bottom Control Bar
      Column() {
        Divider().color('#EEEEEE')
        Row() {
          ControlIcon()
          
          Button() {
            Row({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(18)
                .height(18)
                .fillColor('#FFFFFF')
              Text('Refresh Data')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
          }
          .backgroundColor('#1A1A1A')
          .borderRadius(16)
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
          .layoutWeight(1)

          ControlIcon()
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
      }
    }
    .width('100%')
    .height('100%')
    .safeArea({ right: false, left: false, bottom: false })
  }
}

@Component
struct AirQualityCircle {
  private ctx: DrawTask = new DrawTask((context: CanvasContext, canvas: CanvasRenderingContext2D) => {
    const width = canvas.width;
    const height = canvas.height;
    const lineWidth = 40;
    const radius = (Math.min(width, height) - lineWidth) / 2;
    const center = { x: width / 2, y: height / 2 };

    // Background Track
    context.beginPath();
    context.arc(center.x, center.y, radius, Math.PI * 0.75, Math.PI * 2.25, true);
    context.lineWidth = lineWidth;
    context.lineCap = LineCap.Round;
    context.strokeStyle = '#FAFAFA';
    context.stroke();

    // Progress Track (Green)
    context.beginPath();
    context.arc(center.x, center.y, radius, Math.PI * 0.75, Math.PI * 1.36, true);
    context.lineWidth = lineWidth;
    context.lineCap = LineCap.Round;
    context.strokeStyle = '#4CAF50';
    context.stroke();

    // Dot at end of progress
    const angle = Math.PI * 1.36;
    const dotX = center.x + radius * Math.cos(angle);
    const dotY = center.y + radius * Math.sin(angle);
    
    context.beginPath();
    context.arc(dotX, dotY, 12, 0, Math.PI * 2, false);
    context.fillStyle = '#FFFFFF';
    context.fill();
  });

  build() {
    Stack() {
      Canvas(this.ctx)
        .width(220)
        .height(220)
      
      Column({ space: 0 }) {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(2)
        
        Text('42')
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#4CAF50')
          .backgroundColor('#E8F5E9')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
    }
    .width('100%')
    .aspectRatio(1.2)
  }
}

interface MetricCardProps {
  label: string;
  value: string;
  color: string;
}

@Component
struct MetricCard {
  props: MetricCardProps

  build() {
    Column() {
      Row() {
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .fillColor(this.props.color)
        Blank()
      }
      Blank()
      Column({ space: 4 }) {
        Text(this.props.value)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text(this.props.label)
          .fontSize(12)
          .fontColor('#757575')
      }
    }
    .width('100%')
    .height(110)
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .layoutWeight(1)
  }
}

@Component
struct StatusBanner {
  build() {
    Column({ space: 12 }) {
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#1A1A1A')
        Blank().width(12)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
      }
      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor('#757575')
        .lineHeight(22)
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct ControlIcon {
  build() {
    Button() {
      Image($r('app.media.startIcon'))
        .width(24)
        .height(24)
        .fillColor('#1A1A1A')
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
  }
}