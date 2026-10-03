@Entry
@Component
struct Index {
  build() {
    Scroll() {
      Column() {
        Blank().height(24)

        Row() {
          Column() {
            Text('THURSDAY').fontSize(12).fontColor('#757575').fontWeight(FontWeight.Bold).letterSpacing(1)
            Text('Dec 04').fontSize(24).fontColor('#121212').fontWeight(FontWeight.Bolder)
          }
          Stack() {
            Text('⚙').fontSize(24).fontColor('#121212')
          }
          .width(40).height(40)
          .borderRadius(20)
          .border({ width: 1, color: '#F5F5F5' })
          .onClick(() => {})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(32)

        StatsCard()

        Blank().height(32)

        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(1.5)
          .width('100%')

        Blank().height(16)

        HabitItem({ icon: '☺', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true })
        HabitItem({ icon: '▶', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false })
        HabitItem({ icon: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false })
        HabitItem({ icon: '♥', title: 'Drink Water', subtitle: '2L target', isCompleted: false })

        Blank().height(24)

        Column() {
          Text('✓').fontSize(20).fontColor('#757575')
          Blank().height(12)
          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor('#121212')
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
        }
        .width('100%')
        .padding(20)
        .borderRadius(16)
        .backgroundColor('#F5F5F5')
        .alignItems(HorizontalAlign.Start)

        Blank().height(48)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress').fontColor('rgba(255,255,255,0.7)').fontSize(14)
        Blank().height(8)
        Text('85%').fontColor('#FFFFFF').fontSize(48).fontWeight(FontWeight.Bold)
        Blank().height(4)
        Row() {
          Text('★').fontSize(16).fontColor('#FFD700')
          Blank().width(4)
          Text('12 Day Streak!').fontColor('#FFFFFF').fontSize(14).fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .borderRadius(24)
    .backgroundColor('#121212')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HabitItem {
  @Prop icon: string = ''
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop isCompleted: boolean = false
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = this.isCompleted
  }

  build() {
    Row() {
      Stack() {
        Text(this.icon).fontSize(24).fontColor('#121212')
      }
      .width(48).height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? '#757575' : '#121212')
          .decoration({ type: this.checked ? TextDecorationType.LineThrough : TextDecorationType.None })
        Blank().height(2)
        Text(this.subtitle).fontSize(12).fontColor('#757575')
      }
      .layoutWeight(1)

      Blank().width(8)

      Stack() {
        if (this.checked) {
          Text('✓').fontSize(18).fontColor('#FFFFFF')
        }
      }
      .width(32).height(32)
      .borderRadius(16)
      .backgroundColor(this.checked ? '#4CAF50' : '#00000000')
      .border({ width: 2, color: this.checked ? '#4CAF50' : '#F5F5F5' })
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5' })
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .onClick(() => { this.checked = !this.checked })
  }
}
