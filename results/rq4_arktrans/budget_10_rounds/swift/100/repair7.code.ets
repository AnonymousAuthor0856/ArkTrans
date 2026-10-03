@Entry
@Component
struct Index {
  @State goals: GoalItem[] = [
    { title: "Morning Meditation", subtitle: "15 minutes mindfulness", icon: $r('app.media.startIcon'), isCompleted: true },
    { title: "Gym Session", subtitle: "Upper body workout", icon: $r('app.media.startIcon'), isCompleted: false },
    { title: "Learn Spanish", subtitle: "Daily lesson completed", icon: $r('app.media.startIcon'), isCompleted: false }
  ]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Scroll() {
        Column() {
          Blank().height(24)

          Row() {
            Column() {
              Text('THURSDAY').fontColor('#8E8E93').letterSpacing(1).fontSize(12).fontWeight(FontWeight.Bold)
              Text('Dec 04').fontColor('#1C1C1E').fontSize(24).fontWeight(FontWeight.ExtraBold)
            }
            Blank()
            Button() {
              Image($r('app.media.startIcon')).width(24).height(24)
            }.borderRadius(20).backgroundColor('#FFFFFF').border({ width: 1, color: '#F5F5F5' }).width(40).height(40)
          }.width('100%')

          Blank().height(32)

          // Overall Progress Card
          Column() {
            Text('Overall Progress').fontSize(14).fontColor('#FFFFFF').opacity(0.7)
            Blank().height(8)
            Text('85%').fontSize(48).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
            Blank().height(4)
            Row() {
              Image($r('app.media.startIcon')).width(16).height(16).objectFit(ImageFit.Contain).fillColor('#FFD700')
              Blank().width(4)
              Text('12 Day Streak!').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
            }
          }.width('100%').padding(24).backgroundColor('#1C1C1E').borderRadius(24).height(140)

          Blank().height(32)

          Text("TODAY'S GOALS").width('100%').textAlign(TextAlign.Start).fontColor('#8E8E93').letterSpacing(1.5).fontSize(12).fontWeight(FontWeight.Bold)
          Blank().height(16)

          ForEach(this.goals, (item: GoalItem) => {
            this.GoalRow(item)
          })

          Blank().height(24)

          // Quote Card
          Column() {
            Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain).fillColor('#8E8E93')
            Blank().height(12)
            Text('Small steps every day add up to big results over time.')
              .lineHeight(20)
              .fontColor('#1C1C1E')
              .fontStyle(FontStyle.Italic)
              .fontSize(14)
          }.width('100%').padding(20).backgroundColor('#F5F5F5').borderRadius(16)

          Blank().height(48)
        }.width('100%').padding(24)
      }
    }.width('100%').height('100%')
  }

  @Builder
  GoalRow(item: GoalItem) {
    Row() {
      Stack() {
        Circle().fill('#F5F5F5').width(48).height(48)
        Image(item.icon).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#1C1C1E')
      }
      Blank().width(16)
      Column() {
        Text(item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(item.isCompleted ? '#8E8E93' : '#1C1C1E')
          .decoration({ type: item.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None, color: '#8E8E93' })
        Blank().height(2)
        Text(item.subtitle).fontSize(12).fontColor('#8E8E93')
      }.layoutWeight(1).alignItems(HorizontalAlign.Start)
      Blank().width(8)
      Stack() {
        Circle().fill(item.isCompleted ? '#4CAF50' : Color.Transparent).width(32).height(32)
        Circle().stroke(item.isCompleted ? '#4CAF50' : '#F5F5F5').strokeWidth(2).width(32).height(32)
        if (item.isCompleted) {
          Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain).fillColor('#FFFFFF')
        }
      }
    }
    .width('100%')
    .padding({ top: 8, bottom: 8, left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5' })
    .onClick(() => {
      const index = this.goals.findIndex(g => g.title === item.title);
      if (index !== -1) {
        this.goals[index].isCompleted = !this.goals[index].isCompleted;
      }
    })
  }
}

interface GoalItem {
  title: string;
  subtitle: string;
  icon: Resource;
  isCompleted: boolean;
}