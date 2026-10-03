// MARK: - 1. Colors
class AppColors {
  static readonly pureWhite: string = '#FFFFFF';
  static readonly offWhite: string = '#FAFAFA';
  static readonly textPrimary: string = '#1A1A1A';
  static readonly textSecondary: string = '#757575';
  static readonly accentGreen: string = '#4CAF50';
  static readonly accentWarning: string = '#FF9800';
  static readonly dividerColor: string = '#EEEEEE';
  static readonly accentGreenOpacity: string = '#1A4CAF50';
}

// MARK: - 2. Main App Structure
@Entry
@Component
struct AeroSenseApp {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column().width('100%').height('100%').backgroundColor(AppColors.pureWhite);

      Column() {
        TopHeader();

        Scroll() {
          MainContent();
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
        .padding({ left: 24, right: 24, bottom: 16 });
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.pureWhite);

      Column() {
        Blank();
        BottomControlBar();
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 3. Top Header
@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.textSecondary);
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.textPrimary);
      }
      .alignItems(HorizontalAlign.Start);

      Blank();

      Button() {
        Text('⚙').fontSize(24).fontColor(AppColors.textPrimary);
      }
      .type(ButtonType.Normal)
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(AppColors.offWhite);
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 });
  }
}

// MARK: - 4. Main Content
@Component
struct MainContent {
  build() {
    Column({ space: 32 }) {
      AirQualityCircle({ aqi: 42 });

      Column({ space: 16 }) {
        Row({ space: 16 }) {
          MetricCard({
            label: 'Temp',
            value: '23°C',
            iconName: 'ℹ️',
            statusColor: AppColors.textPrimary
          })
          MetricCard({
            label: 'Humidity',
            value: '45%',
            iconName: '✔️',
            statusColor: AppColors.accentGreen
          })
        }.width('100%');

        Row({ space: 16 }) {
          MetricCard({
            label: 'PM 2.5',
            value: '12',
            iconName: '✔️',
            statusColor: AppColors.accentGreen
          })
          MetricCard({
            label: 'CO2',
            value: '850',
            iconName: '⚠️',
            statusColor: AppColors.accentWarning
          })
        }.width('100%');
      }.width('100%');

      StatusBanner();
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 });
  }
}

// MARK: - 5. Air Quality Circle
@Component
struct AirQualityCircle {
  private aqi: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.context)
          .width(220)
          .height(220)
          .onReady(() => {
            let lineWidth: number = 40.0;
            let size: number = 220;
            let radius: number = (size - lineWidth) / 2;
            let centerX: number = size / 2;
            let centerY: number = size / 2;

            this.context.beginPath();
            this.context.lineWidth = lineWidth;
            this.context.strokeStyle = AppColors.offWhite;
            this.context.lineCap = 'round';
            this.context.arc(centerX, centerY, radius, 135 * Math.PI / 180, 405 * Math.PI / 180, false);
            this.context.stroke();

            this.context.beginPath();
            this.context.lineWidth = lineWidth;
            this.context.strokeStyle = AppColors.accentGreen;
            this.context.lineCap = 'round';
            this.context.arc(centerX, centerY, radius, 135 * Math.PI / 180, 245 * Math.PI / 180, false);
            this.context.stroke();

            let dotRadius: number = 12.0;
            let angleForDot: number = 245 * Math.PI / 180;
            let xOffset: number = radius * Math.cos(angleForDot);
            let yOffset: number = radius * Math.sin(angleForDot);
            let dotCenterX: number = centerX + xOffset;
            let dotCenterY: number = centerY + yOffset;

            this.context.beginPath();
            this.context.fillStyle = AppColors.pureWhite;
            this.context.arc(dotCenterX, dotCenterY, dotRadius / 2, 0, 2 * Math.PI);
            this.context.fill();
          });

        Column() {
          Text('AQI')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.textSecondary)
            .letterSpacing(2);
          Text(`${this.aqi}`)
            .fontSize(80)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.textPrimary);
          Text('Excellent')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.accentGreen)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .backgroundColor(AppColors.accentGreenOpacity)
            .borderRadius(16);
        }
        .justifyContent(FlexAlign.Center);
      }
      .width('100%')
      .aspectRatio(1.2);
    }
    .width('100%');
  }
}

// MARK: - 6. Metric Card
@Component
struct MetricCard {
  private label: string = '';
  private value: string = '';
  private iconName: string = '';
  private statusColor: string = '';

  build() {
    Column() {
      Row() {
        Text(this.iconName).fontSize(20).fontColor(this.statusColor);
        Blank();
      }.width('100%');

      Blank();

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.textPrimary);
        Text(this.label)
          .fontSize(12)
          .fontColor(AppColors.textSecondary);
      }
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .height(110)
    .padding(16)
    .backgroundColor(AppColors.offWhite)
    .borderRadius(24)
    .layoutWeight(1);
  }
}

// MARK: - 7. Status Banner
@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Text('🏠').fontSize(24).fontColor(AppColors.textPrimary);
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.textPrimary)
          .margin({ left: 12 });
      }.width('100%');

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(AppColors.textSecondary)
        .lineHeight(22)
        .margin({ top: 12 });
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: AppColors.dividerColor });
  }
}

// MARK: - 8. Bottom Control Bar
@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider().color(AppColors.dividerColor).strokeWidth(1);

      Row() {
        ControlIcon({ iconName: '☰' });

        Button() {
          Row({ space: 8 }) {
            Text('🔄').fontSize(18);
            Text('Refresh Data').fontSize(16).fontWeight(FontWeight.Medium);
          }
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
          .backgroundColor(AppColors.textPrimary)
          .borderRadius(16);
        }
        .type(ButtonType.Normal)
        .backgroundColor(AppColors.textPrimary);

        ControlIcon({ iconName: '+' });
      }
      .width('100%')
      .padding(24)
      .backgroundColor(AppColors.pureWhite);
    }
    .width('100%');
  }
}

// MARK: - 9. Control Icon
@Component
struct ControlIcon {
  private iconName: string = '';

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(24)
        .fontColor(AppColors.textPrimary);
    }
    .type(ButtonType.Normal)
    .width(48)
    .height(48)
    .borderRadius(24)
    .border({ width: 1, color: AppColors.dividerColor });
  }
}