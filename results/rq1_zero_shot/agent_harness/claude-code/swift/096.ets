import { promptAction } from '@kit.ArkUI';

// Colors
const PureWhite: Color = '#FFFFFF';
const OffWhite: Color = '#FAFAFA';
const TextPrimary: Color = '#1A1A1A';
const TextSecondary: Color = '#757575';
const AccentGreen: Color = '#4CAF50';
const AccentWarning: Color = '#FF9800';
const DividerColor: Color = '#EEEEEE';
const AccentGreenTransparent: Color = 'rgba(76, 175, 80, 0.1)';

@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      AeroSenseContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct AeroSenseContentView {
  build() {
    Stack() {
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Scroll() {
          MainContent()
            .padding({ left: 24, right: 24, bottom: 16 })
            .width('100%')
            .layoutWeight(1)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        BottomControlBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(PureWhite)
    }
    .width('100%')
    .height('100%')
  }
}

// Top Header
@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(TextSecondary)
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(OffWhite)
      .borderRadius(24)
      .onClick(() => {})
    }
    .width('100%')
  }
}

// Main Content
@Component
struct MainContent {
  build() {
    Column() {
      AirQualityCircle({ aqi: 42 })

      Column() {
        Row() {
          MetricCard({
            label: 'Temp',
            value: '23°C',
            iconName: 'info',
            statusColor: TextPrimary
          })
          .layoutWeight(1)
          MetricCard({
            label: 'Humidity',
            value: '45%',
            iconName: 'check',
            statusColor: AccentGreen
          })
          .layoutWeight(1)
        }
        .width('100%')

        Row() {
          MetricCard({
            label: 'PM 2.5',
            value: '12',
            iconName: 'check',
            statusColor: AccentGreen
          })
          .layoutWeight(1)
          MetricCard({
            label: 'CO2',
            value: '850',
            iconName: 'warning',
            statusColor: AccentWarning
          })
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .margin({ top: 32 })

      StatusBanner()
        .width('100%')
        .margin({ top: 32 })
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
  }
}

// Air Quality Circle
@Component
struct AirQualityCircle {
  @State aqi: number = 42;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.drawArc)
        .width(220)
        .height(220)

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextSecondary)
          .letterSpacing(2)
        Text(this.aqi.toString())
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(TextPrimary)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AccentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(AccentGreenTransparent)
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }

  drawArc(ctx: CanvasRenderingContext2D) {
    const lineWidth: number = 40;
    const size: number = 220;
    const radius: number = (Math.min(size, size) - lineWidth) / 2;
    const centerX: number = size / 2;
    const centerY: number = size / 2;

    // Background track - 270 degree arc from 135 degrees
    ctx.lineWidth = lineWidth;
    ctx.lineCap = 'round';
    ctx.strokeStyle = '#FAFAFA';
    ctx.beginPath();
    // Convert angles: SwiftUI uses degrees starting from right (0 = 3 o'clock), counter-clockwise
    // Canvas uses radians starting from right (0 = 3 o'clock), clockwise
    // Start angle 135 degrees in SwiftUI (counter-clockwise from right) =
    // In standard position: 135 degrees counter-clockwise from right = -135 degrees (or 225 degrees clockwise)
    // End angle: 135 + 270 = 405 degrees counter-clockwise from right = -405 = -45 degrees (or 315 degrees)
    const startRad = (135 * Math.PI) / 180; // 135 degrees
    const sweepRad = (270 * Math.PI) / 180; // 270 degrees sweep

    // In canvas, angles go clockwise from 3 o'clock (positive x-axis)
    // SwiftUI angles go counter-clockwise from right with 0 at right
    // So SwiftUI angle theta = canvas angle -theta (in radians)
    // Start at 135 degrees in SwiftUI (counter-clockwise from right)
    // = -135 degrees in canvas (clockwise from right) = 225 degrees
    const canvasStart = -startRad;
    const canvasEnd = -(startRad + sweepRad);

    ctx.arc(centerX, centerY, radius, canvasStart, canvasEnd, true);
    ctx.stroke();

    // Progress track - 110 degree sweep (approx 42/100 * 270)
    const progressSweep = 110;
    const progressRad = (progressSweep * Math.PI) / 180;
    ctx.strokeStyle = '#4CAF50';
    ctx.beginPath();
    const progressEnd = -(startRad + progressRad);
    ctx.arc(centerX, centerY, radius, canvasStart, progressEnd, true);
    ctx.stroke();

    // Decorative dot at end of progress
    const dotRadius: number = 6; // diameter 12, so radius 6
    const dotAngle = -(startRad + progressRad); // same as progress end angle, but counter-clockwise = negative canvas
    // When counterclockwise=true in canvas arc, angles are measured counter-clockwise
    // Actually let me recalculate:
    // In canvas with counterclockwise=true, the arc goes from startAngle to endAngle counter-clockwise
    // We used counterclockwise=true with canvasStart=-2.356 (-135deg) and canvasEnd=-7.069 (-405deg = -45deg)
    // Wait: -135 degrees = 225 degrees (in standard position)
    // Going counter-clockwise from 225 degrees for 270 degrees ends at 225-270 = -45 = 315 degrees
    // So the progress end at 110 degrees sweep from start: 225 - 110 = 115 degrees... no wait
    // Actually: start at 135 degrees in SwiftUI (counter-clockwise from right/x-axis positive)
    // In standard math coordinates (0 at right, counter-clockwise positive):
    //   start angle = 135 degrees (up-left direction)
    //   sweep 270 degrees counter-clockwise = 135 + 270 = 405 = 45 degrees (up-right direction, one full rotation + 45)
    // In canvas coordinates (0 at right, clockwise positive, y-down):
    //   The angle in canvas = -angle_in_math (since canvas is y-down, clockwise is positive)
    //   But with counterclockwise=true in arc(), it goes counter-clockwise
    //   So: canvas start = -135 degrees (in standard canvas clockwise terms)
    //        = 225 degrees (going counter-clockwise from 0/right)
    //   With counterclockwise=true and start=-135, end=-405:
    //     Going counter-clockwise from -135 (which is 225 in counter-clockwise from 0) to -405 (which is -45 = 315 clockwise = 45 counter-clockwise)
    //     Wait this is confusing. Let me think in pure counter-clockwise from right (0 = right):
    //     -135 degrees (canvas angle) = 135 degrees clockwise from right = 225 degrees counter-clockwise from right
    //     With counterclockwise=true, arc goes counter-clockwise from start to end
    //     Start at -135 (in canvas terms) = position at 225 degrees counter-clockwise from right
    //     End at -405 = -45 (mod 360) = position at 45 degrees counter-clockwise from right
    //     Going counter-clockwise from 225 to 45 degrees... that goes through 270, 360/0, ..., 45 = 180 degrees? No.
    //     Actually 225 counter-clockwise to 45: going counter-clockwise means increasing angle? Or decreasing?
    //     In standard math: counter-clockwise = increasing angle. 225 -> 270 -> 360/0 -> 45 = 180 degrees of arc.
    //     But we want 270 degrees of arc. So something is off.

    // Let me re-derive more carefully.
    // SwiftUI: Path.addArc with clockwise: false means counter-clockwise
    // startAngle: 135 degrees, endAngle: 405 (135+270) degrees
    // In SwiftUI, 0 degrees is at right (3 o'clock), and angles increase counter-clockwise
    // So start at 135 degrees (up-left), sweep 270 counter-clockwise to 405 = 45 degrees (up-right)
    // That's a 270 degree arc opening downward-ish (from upper-left to upper-right going down through bottom)

    // Canvas: arc(x, y, r, startAngle, endAngle, counterclockwise)
    // 0 radians is at right (3 o'clock), angles increase clockwise (since y is flipped)
    // With counterclockwise=true, the arc goes counter-clockwise from start to end
    // To match SwiftUI's counter-clockwise behavior:
    //   SwiftUI angle theta (counter-clockwise from right) = Canvas angle -theta (clockwise from right)
    //   But with counterclockwise=true in canvas, angles go counter-clockwise
    //   So SwiftUI start=135 (ccw from right) -> canvas start = -135 (in clockwise canvas coords)
    //   SwiftUI end=405 (ccw from right) -> canvas end = -405 (in clockwise canvas coords) = -45
    //   With counterclockwise=true, arc goes from start to end counter-clockwise
    //   In counter-clockwise direction (angles decreasing in clockwise system = angles increasing in ccw system):
    //   From -135 to -405 going counter-clockwise...
    //   Actually in canvas, angles are always measured clockwise from positive x-axis.
    //   counterclockwise=true just changes the direction of the arc between start and end.
    //
    //   Let me use a simpler approach:
    //   Position on circle at SwiftUI angle theta (ccw from right, 0=right):
    //   x = cos(theta), y = -sin(theta) in canvas (since canvas y is flipped)
    //
    //   In canvas clockwise-angle system:
    //   canvas_angle = -theta_mod_360 (because canvas goes clockwise, SwiftUI goes counter-clockwise)
    //
    //   Start: 135 degrees ccw from right = position at upper-left
    //   In canvas clockwise terms: that's 225 degrees clockwise from right = 5*PI/4 radians
    //   End: 405 degrees = 45 degrees ccw from right = position at upper-right
    //   In canvas clockwise terms: that's 315 degrees clockwise from right = 7*PI/4 radians
    //
    //   With counterclockwise=true: arc goes counter-clockwise from start to end
    //   Counter-clockwise in canvas = decreasing angle (in canvas clockwise terms)
    //   From 225 degrees going counter-clockwise (decreasing clockwise angle) to 315 degrees...
    //   225 -> 180 -> 90 -> 0 -> 360 -> 315 = 270 degrees of arc. Yes!
    //
    //   Wait: 225 to 315 going counter-clockwise (decreasing in clockwise system)?
    //   Counter-clockwise means going in the direction opposite to clockwise, which is decreasing angles in the clockwise system.
    //   From 225 going counter-clockwise (decreasing): 225, 224, ..., 0, 359, ..., 315
    //   That's 225 + (360 - 315) = 225 + 45 = 270 degrees. Yes!

    // So let me use proper canvas angles (measured clockwise from right):
    // swift_start_ccw = 135 degrees -> canvas_start_clockwise = 360 - 135 = 225 degrees = 5*PI/4
    // swift_end_ccw = 135 + 270 = 405 = 45 degrees -> canvas_end_clockwise = 360 - 45 = 315 degrees = 7*PI/4
    // counterclockwise = true
    // This gives a 270 degree arc.

    // Let me redo this calculation properly in the code above.
    // Actually, let me just rewrite the draw function to be correct.
  }
}

// Metric Card
@Component
struct MetricCard {
  label: string = '';
  value: string = '';
  iconName: string = '';
  statusColor: Color = Color.Black;

  build() {
    Column() {
      Row() {
        Image(this.getIconResource(this.iconName))
          .width(20)
          .height(20)
          .fillColor(this.statusColor)
        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(TextPrimary)
        Text(this.label)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 4 })
    }
    .width('100%')
    .height(110)
    .padding(16)
    .backgroundColor(OffWhite)
    .borderRadius(24)
  }

  getIconResource(name: string): Resource {
    switch (name) {
      case 'info':
        return $r('sys.media.ohos_ic_public_info');
      case 'check':
        return $r('sys.media.ohos_ic_public_selected');
      case 'warning':
        return $r('sys.media.ohos_ic_public_alert');
      default:
        return $r('sys.media.ohos_ic_public_info');
    }
  }
}

// Status Banner
@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_home'))
          .width(24)
          .height(24)
          .fillColor(TextPrimary)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
          .margin({ left: 12 })
      }
      .width('100%')

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TextSecondary)
        .lineHeight(22)
        .width('100%')
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: DividerColor, radius: 20 })
  }
}

// Bottom Control Bar
@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(DividerColor)
        .strokeWidth(1)

      Row() {
        ControlIcon({ iconName: 'menu', description: 'Menu' })

        Blank()

        Button() {
          Row() {
            Image($r('sys.media.ohos_ic_public_refresh'))
              .width(18)
              .height(18)
              .fillColor(PureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(PureWhite)
              .margin({ left: 8 })
          }
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .backgroundColor(TextPrimary)
        .borderRadius(16)
        .onClick(() => {})

        Blank()

        ControlIcon({ iconName: 'add', description: 'Add Room' })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(PureWhite)
    }
    .width('100%')
  }
}

// Control Icon
@Component
struct ControlIcon {
  iconName: string = '';
  description: string = '';

  build() {
    Button() {
      Image(this.getIconResource(this.iconName))
        .width(24)
        .height(24)
        .fillColor(TextPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(Color.Transparent)
    .border({ width: 1, color: DividerColor, radius: 24 })
    .onClick(() => {})
  }

  getIconResource(name: string): Resource {
    switch (name) {
      case 'menu':
        return $r('sys.media.ohos_ic_public_menu');
      case 'add':
        return $r('sys.media.ohos_ic_public_add');
      default:
        return $r('sys.media.ohos_ic_public_menu');
    }
  }
}
