@Entry
@Component
struct BrewingScreen {
  @State steps: BrewStep[] = [
    { title: 'Bloom', description: 'Wet the grounds evenly to release CO2.', waterTarget: '60g', time: '0:00 - 0:45', isCompleted: true },
    { title: 'First Pour', description: 'Pour slowly in concentric circles.', waterTarget: '180g', time: '0:45 - 1:30', isCompleted: false },
    { title: 'Second Pour', description: 'Gently pour remaining water.', waterTarget: '300g', time: '1:30 - 2:15', isCompleted: false },
    { title: 'Draw Down', description: 'Wait for the water to drain completely.', waterTarget: '300g', time: '2:15 - 3:00', isCompleted: false }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Column() {
          Text('V60 Guide').fontSize(28).fontWeight(FontWeight.Bold).letterSpacing(-0.5).fontColor('#000')
          Text('Ethiopia Yirgacheffe').fontSize(14).fontColor('#999')
        }
        Blank()
        Image($r('app.media.startIcon')).width(24).height(24)
      }.width('100%').padding({ left: 24, right: 24, top: 48, bottom: 0 })

      // Timer Display
      Column({ space: 8 }) {
        Text('00:45').fontSize(80).fontWeight(FontWeight.Normal).fontFamily('monospace').letterSpacing(-2).fontColor('#000')
        Text('Target: 300g').fontSize(14).fontColor('#999')
      }.width('100%').justifyContent(FlexAlign.Center).padding({ top: 24, bottom: 24 })

      // Stats Row
      Row({ space: 24 }) {
        this.StatItemComponent('Ratio', '1:15', 'add')
        this.StatItemComponent('Beans', '20g', 'heart')
        this.StatItemComponent('Temp', '93°C', 'refresh')
      }.width('100%').justifyContent(FlexAlign.SpaceEvenly).padding({ bottom: 32 })

      Divider().color('#F0F0F0')

      Text('Brewing Steps').fontSize(18).fontWeight(FontWeight.Bold).margin({ top: 24, bottom: 16 })

      // Steps List
      List({ space: 16 }) {
        ForEach(this.steps, (step: BrewStep, index: number) => {
          ListItem() {
            this.StepCardComponent(index + 1, step)
          }
        })
        ListItem() {
          Column() {
            Blank().height(80)
          }
        }
      }.layoutWeight(1)

      // Bottom Button
      Button() {
        Row() {
          Image($r('app.media.startIcon')).width(24).height(24)
          Text('Start Brewing').fontSize(16).fontWeight(FontWeight.Bold).margin({ left: 8 }).fontColor('#FFF')
        }.justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
      }.width('100%').height(64).backgroundColor('#000').borderRadius(16).margin({ left: 24, right: 24, bottom: 24 })
    }.width('100%').height('100%').backgroundColor('#FFF').padding({ left: 24, right: 24 })
  }

  @Builder
  StatItemComponent(label: string, value: string, type: string) {
    Column({ space: 8 }) {
      Row() {
        Image($r('app.media.startIcon')).width(20).height(20)
      }.width(48).height(48).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).border({ width: 1, color: '#E0E0E0' }).borderRadius(24)
      
      Text(value).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000')
      Text(label).fontSize(12).fontColor('#999')
    }.alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCardComponent(number: number, step: BrewStep) {
    Row() {
      // Timeline Indicator
      Column({ space: 4 }) {
        Row() {
          if (step.isCompleted) {
            Image($r('app.media.startIcon')).width(14).height(14)
          } else {
            Text(number.toString()).fontSize(12).fontColor('#FFF')
          }
        }
        .width(24).height(24).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
        .backgroundColor(step.isCompleted ? '#000' : '#E0E0E0').borderRadius(12)

        Column().width(1).height(60).backgroundColor('#F0F0F0')
      }.alignItems(HorizontalAlign.Center).margin({ end: 16 })

      // Content Card
      Column() {
        Row() {
          Text(step.title).fontSize(16).fontWeight(FontWeight.Bold).fontColor(step.isCompleted ? '#999' : '#000')
          Blank()
          Text(step.waterTarget).fontSize(14).fontWeight(FontWeight.Bold).fontFamily('monospace').fontColor('#000')
        }.width('100%')

        Text(step.description).fontSize(14).fontColor('#999').margin({ top: 4 })

        Text(step.time).fontSize(12).fontColor('#999').backgroundColor('#F5F5F5').borderRadius(4).padding({ left: 8, right: 8, top: 4, bottom: 4 }).margin({ top: 8 })
      }
      .width('100%').padding(16).backgroundColor(step.isCompleted ? '#F8F8F8' : '#FFF')
      .border({ width: 1, color: step.isCompleted ? '#FFF' : '#EEEEEE' }).borderRadius(12)
    }
  }
}

interface BrewStep {
  title: string;
  description: string;
  waterTarget: string;
  time: string;
  isCompleted: boolean;
}