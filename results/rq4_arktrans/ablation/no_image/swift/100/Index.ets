@Entry
@Component
struct Index {
  build() {
    Stack() {
      Stack() {
        Scroll() {
          Column() {
            Blank().height(24)

            Row() {
              Column() {
                Text('THURSDAY').fontColor('#8E8E93').letterSpacing(1).fontSize(12).fontWeight(FontWeight.Bold)
                Text('Dec 04').fontColor('#000000').fontSize(24).fontWeight(FontWeight.Bold)
              }
              Blank()
              Button() {
                Circle().width(40).height(40).fill('transparent').stroke('#F5F5F5').strokeWidth(1)
              }.type(ButtonType.Circle).backgroundColor('transparent')
            }.width('100%')

            Blank().height(32)

            Row() {
              Column() {
                Text('Overall Progress').fontSize(14).fontColor('#FFFFFF').opacity(0.7)
                Blank().height(8)
                Text('85%').fontSize(48).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
                Blank().height(4)
                Row() {
                  Image($r('app.media.startIcon')).width(16).height(16).objectFit(ImageFit.Contain)
                  Blank().width(4)
                  Text('12 Day Streak!').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
                }
              }.width('100%').alignItems(HorizontalAlign.Start)
            }.width('100%').height(140).padding(24).borderRadius(24).backgroundColor('#000000')

            Blank().height(32)

            Text("TODAY'S GOALS").width('100%').textAlign(TextAlign.Start).fontColor('#8E8E93').letterSpacing(1.5).fontSize(12).fontWeight(FontWeight.Bold)

            Blank().height(16)

            // Goal Item 1
            Row() {
              Stack() {
                Circle().fill('#F5F5F5')
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
              }.width(48).height(48)

              Blank().width(16)

              Column() {
                Text('Goal Title').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                Blank().height(2)
                Text('Goal Subtitle').fontSize(12).fontColor('#8E8E93')
              }.width('100%').alignItems(HorizontalAlign.Start)

              Blank().width(8)

              Stack() {
                Circle().fill('#4CAF50')
                Circle().stroke('#4CAF50').strokeWidth(2)
                Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain)
              }.width(32).height(32)
            }.width('100%').padding({ top: 8, bottom: 8 }).borderRadius(16).border({ width: 1, color: '#F5F5F5' })

            // Goal Item 2
            Row() {
              Stack() {
                Circle().fill('#F5F5F5')
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
              }.width(48).height(48)

              Blank().width(16)

              Column() {
                Text('Goal Title').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                Blank().height(2)
                Text('Goal Subtitle').fontSize(12).fontColor('#8E8E93')
              }.width('100%').alignItems(HorizontalAlign.Start)

              Blank().width(8)

              Stack() {
                Circle().fill('#4CAF50')
                Circle().stroke('#4CAF50').strokeWidth(2)
                Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain)
              }.width(32).height(32)
            }.width('100%').padding({ top: 8, bottom: 8 }).borderRadius(16).border({ width: 1, color: '#F5F5F5' })

            // Goal Item 3
            Row() {
              Stack() {
                Circle().fill('#F5F5F5')
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
              }.width(48).height(48)

              Blank().width(16)

              Column() {
                Text('Goal Title').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                Blank().height(2)
                Text('Goal Subtitle').fontSize(12).fontColor('#8E8E93')
              }.width('100%').alignItems(HorizontalAlign.Start)

              Blank().width(8)

              Stack() {
                Circle().fill('#4CAF50')
                Circle().stroke('#4CAF50').strokeWidth(2)
                Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain)
              }.width(32).height(32)
            }.width('100%').padding({ top: 8, bottom: 8 }).borderRadius(16).border({ width: 1, color: '#F5F5F5' })

            // Goal Item 4
            Row() {
              Stack() {
                Circle().fill('#F5F5F5')
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
              }.width(48).height(48)

              Blank().width(16)

              Column() {
                Text('Goal Title').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                Blank().height(2)
                Text('Goal Subtitle').fontSize(12).fontColor('#8E8E93')
              }.width('100%').alignItems(HorizontalAlign.Start)

              Blank().width(8)

              Stack() {
                Circle().fill('#4CAF50')
                Circle().stroke('#4CAF50').strokeWidth(2)
                Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain)
              }.width(32).height(32)
            }.width('100%').padding({ top: 8, bottom: 8 }).borderRadius(16).border({ width: 1, color: '#F5F5F5' })

            Blank().height(24)

            Column() {
              Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
              Blank().height(12)
              Text('Small steps every day add up to big results over time.').lineHeight(20).fontColor('#000000').fontSize(14)
            }.width('100%').padding(20).borderRadius(16).backgroundColor('#F5F5F5')

            Blank().height(48)
          }.padding(24)
        }
      }
    }.width('100%').height('100%')
  }
}