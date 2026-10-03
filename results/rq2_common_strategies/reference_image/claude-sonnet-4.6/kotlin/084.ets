// entry/src/main/ets/pages/Index.ets
// HarmonyOS ArkTS (ArkUI) port of the Compose "V60 Guide" brewing screen.
// Note: for the immersive/edge-to-edge look of the original, set
//   window.getLastWindow(this.context).then(w => w.setWindowLayoutFullScreen(true))
// inside EntryAbility.onWindowStageCreate().

class BrewStep {
  title: string;
  description: string;
  waterTarget: string;
  timeRange: string;
  isCompleted: boolean;

  constructor(title: string, description: string, waterTarget: string,
              timeRange: string, isCompleted: boolean = false) {
    this.title = title;
    this.description = description;
    this.waterTarget = waterTarget;
    this.timeRange = timeRange;
    this.isCompleted = isCompleted;
  }
}

class StatInfo {
  label: string;
  value: string;
  icon: string;

  constructor(label: string, value: string, icon: string) {
    this.label = label;
    this.value = value;
    this.icon = icon;
  }
}

@Entry
@Component
struct BrewingScreen {
  private steps: BrewStep[] = [
    new BrewStep('Bloom', 'Wet the grounds evenly to release CO2.', '60g', '0:00 - 0:45', true),
    new BrewStep('First Pour', 'Pour slowly in concentric circles.', '180g', '0:45 - 1:30', false),
    new BrewStep('Second Pour', 'Gently pour remaining water.', '300g', '1:30 - 2:15', false),
    new BrewStep('Draw Down', 'Wait for the water to drain completely.', '300g', '2:15 - 3:00', false)
  ];

  private stats: StatInfo[] = [
    new StatInfo('Ratio', '1:15', '+'),
    new StatInfo('Beans', '20g', '♥'),
    new StatInfo('Temp', '93°C', '⟳')
  ];

  build() {
    Column() {
      // ---------- Header ----------
      Row() {
        Column() {
          Text('V60 Guide')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .letterSpacing(-0.5)
          Text('Ethiopia Yirgacheffe')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // Settings (Compose Icons.Default.Settings)
        Text('⚙')
          .fontSize(24)
          .fontColor('#000000')
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 48, bottom: 24 })
      .alignItems(VerticalAlign.Center)

      // ---------- Main timer ----------
      Column() {
        Text('00:45')
          .fontSize(80)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
          .fontFamily('monospace') // swap for a registered monospace font if needed
          .letterSpacing(-2)
        Text('Target: 300g')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 4 })
      }
      .width('100%')
      .padding({ top: 24, bottom: 24 })
      .alignItems(HorizontalAlign.Center)

      // ---------- Stats row ----------
      Row() {
        ForEach(this.stats, (item: StatInfo) => {
          StatItem({ label: item.label, value: item.value, icon: item.icon })
        }, (item: StatInfo) => item.label)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ bottom: 32 })

      Divider()
        .color('#F0F0F0')
        .strokeWidth(1)

      Text('Brewing Steps')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 24, bottom: 16 })

      // ---------- Steps list ----------
      List({ space: 16 }) {
        ForEach(this.steps, (step: BrewStep, index: number) => {
          ListItem() {
            StepCard({
              stepNumber: index + 1,
              title: step.title,
              description: step.description,
              waterTarget: step.waterTarget,
              timeRange: step.timeRange,
              isCompleted: step.isCompleted
            })
          }
        }, (step: BrewStep, index: number) => index + '-' + step.title)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // ---------- Bottom action ----------
      Button({ type: ButtonType.Normal }) {
        Row() {
          Text('▶')
            .fontSize(16)
            .fontColor('#FFFFFF')
          Text('Start Brewing')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor('#000000')
      .borderRadius(16)
      .margin({ top: 16, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct StatItem {
  @Prop label: string;
  @Prop value: string;
  @Prop icon: string;

  build() {
    Column() {
      Column() {
        Text(this.icon)
          .fontSize(18)
          .fontColor('#999999')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text(this.value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(11)
        .fontColor('#999999')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  @Prop stepNumber: number;
  @Prop title: string;
  @Prop description: string;
  @Prop waterTarget: string;
  @Prop timeRange: string;
  @Prop isCompleted: boolean;

  build() {
    Row() {
      // ---------- Timeline indicator ----------
      Column() {
        Column() {
          if (this.isCompleted) {
            Text('✓')
              .fontSize(12)
              .fontColor('#FFFFFF')
          } else {
            Text(this.stepNumber.toString())
              .fontSize(11)
              .fontColor('#FFFFFF')
          }
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.isCompleted ? '#000000' : '#E0E0E0')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Column()
          .width(1)
          .height(60)
          .backgroundColor('#F0F0F0')
      }
      .width(24)
      .alignItems(HorizontalAlign.Center)
      .margin({ right: 16, top: 4 })

      // ---------- Content card ----------
      Column() {
        Row() {
          Text(this.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isCompleted ? '#999999' : '#000000')
            .layoutWeight(1)
          Text(this.waterTarget)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontFamily('monospace')
            .fontColor(this.isCompleted ? '#999999' : '#000000')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Text(this.description)
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 4 })

        Text(this.timeRange)
          .fontSize(11)
          .fontColor('#999999')
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .margin({ top: 8 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .backgroundColor(this.isCompleted ? '#F8F8F8' : '#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: this.isCompleted ? '#00000000' : '#EEEEEE' })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}