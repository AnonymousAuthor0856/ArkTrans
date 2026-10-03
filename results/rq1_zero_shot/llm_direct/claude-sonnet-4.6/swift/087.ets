import { router } from '@kit.ArkUI';

// App Colors
const TeaColors = {
  primary: '#6D4C41',
  secondary: '#A1887F',
  surfaceVariant: '#FAFAFA',
  outline: '#EEEEEE',
  backgroundTint: '#F5F5F5',
  teaLeafDetail: '#8D6E63',
  favoriteTint: '#FFCDD2',
  textSecondary: '#9E9E9E',
  textPrimary: '#000000',
  leafCircleBg: '#EFEBE9',
  divider: '#EEEEEE',
  resetBorder: '#E0E0E0',
  white: '#FFFFFF',
};

@Entry
@Component
struct TeaBrewingScreen {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(TeaColors.white)

      Scroll() {
        Column({ space: 0 }) {
          // Header
          HeaderSection()
            .margin({ top: 24, bottom: 32 })

          // Tea Selection Card
          TeaSelectionCard()
            .margin({ bottom: 32 })

          // Timer
          TimerDisplay({ time: '02:00' })
            .margin({ bottom: 40 })

          // Control Buttons
          ControlButtons()

          // Spacer
          Column()
            .layoutWeight(1)
            .height(24)

          // Preparation Steps
          PreparationSteps()
            .margin({ bottom: 24 })
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(TeaColors.textSecondary)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(TeaColors.textPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(TeaColors.backgroundTint)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CustomLeafIcon {
  build() {
    Stack() {
      // Circle outline
      Circle()
        .width(30)
        .height(30)
        .fill(Color.Transparent)
        .stroke(TeaColors.primary, 2)

      // Vertical line approximation using a thin rectangle
      Column()
        .width(2)
        .height(15)
        .backgroundColor(TeaColors.primary)
        .borderRadius(1)
    }
    .width(30)
    .height(30)
    .alignContent(Alignment.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill(TeaColors.leafCircleBg)

        CustomLeafIcon()
      }
      .width(60)
      .height(60)
      .alignContent(Alignment.Center)

      // Tea Info
      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Favorite Icon
      Image($r('sys.media.ohos_ic_public_favor_filled'))
        .width(24)
        .height(24)
        .fillColor(TeaColors.favoriteTint)
    }
    .padding(20)
    .width('100%')
    .backgroundColor(TeaColors.surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: TeaColors.outline, radius: 24 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TimerDisplay {
  @Prop time: string;

  build() {
    Stack() {
      // Background Circle
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke(TeaColors.backgroundTint, 12)

      // Progress Arc using Canvas
      Canvas(new RenderingContextSettings(true))
        .width(220)
        .height(220)
        .onReady((context: CanvasRenderingContext2D) => {
          const cx = 110;
          const cy = 110;
          const radius = 104;
          const startAngle = (-210 * Math.PI) / 180;
          const endAngle = startAngle + (0.66 * 2 * Math.PI);

          context.beginPath();
          context.arc(cx, cy, radius, startAngle, endAngle);
          context.strokeStyle = TeaColors.primary;
          context.lineWidth = 12;
          context.lineCap = 'round';
          context.stroke();
        })

      // Timer Text
      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TeaColors.textSecondary)
          .letterSpacing(2)

        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ControlButtons {
  build() {
    Row({ space: 24 }) {
      // Reset Button
      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_refresh'))
          .width(24)
          .height(24)
          .fillColor(TeaColors.textSecondary)
      }
      .width(60)
      .height(60)
      .backgroundColor(TeaColors.white)
      .border({ width: 1, color: TeaColors.resetBorder, radius: 30 })

      // Start Button
      Button() {
        Row({ space: 8 }) {
          Image($r('sys.media.ohos_ic_public_play'))
            .width(18)
            .height(18)
            .fillColor(TeaColors.white)
          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(TeaColors.white)
        }
      }
      .width(120)
      .height(60)
      .backgroundColor(TeaColors.primary)
      .borderRadius(24)

      // Add Note Button
      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor(TeaColors.textSecondary)
      }
      .width(60)
      .height(60)
      .backgroundColor(TeaColors.white)
      .border({ width: 1, color: TeaColors.resetBorder, radius: 30 })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }
}

@Component
struct PreparationSteps {
  build() {
    Column({ space: 0 }) {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#CCCCCC')
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })

      Divider()
        .color(TeaColors.backgroundTint)
        .strokeWidth(1)

      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })

      Divider()
        .color(TeaColors.backgroundTint)
        .strokeWidth(1)

      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct StepItem {
  @Prop step: string;
  @Prop text: string;

  build() {
    Row({ space: 12 }) {
      // Step Number Circle
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TeaColors.textPrimary)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(TeaColors.backgroundTint)
        .borderRadius(12)

      // Step Text
      Text(this.text)
        .fontSize(14)
        .fontColor(TeaColors.textSecondary)
        .layoutWeight(1)

      // Checkmark
      Image($r('sys.media.ohos_ic_public_ok'))
        .width(12)
        .height(12)
        .fillColor(TeaColors.outline)
    }
    .padding({ top: 8, bottom: 8 })
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}